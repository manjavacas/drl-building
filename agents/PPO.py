#!/usr/bin/python3

import gym
import energym
import argparse
import uuid
import mlflow

import numpy as np

from energym.utils.callbacks import LoggerCallback, LoggerEvalCallback
from energym.utils.wrappers import NormalizeObservation

from stable_baselines3 import PPO
from stable_baselines3.common.callbacks import EvalCallback, BaseCallback, CallbackList
from stable_baselines3.common.vec_env import DummyVecEnv


parser = argparse.ArgumentParser()
parser.add_argument('--environment', '-env', type=str, default=None)
parser.add_argument('--episodes', '-ep', type=int, default=1)
parser.add_argument('--learning_rate', '-lr', type=float, default=.0003)
parser.add_argument('--n_steps', '-n', type=int, default=2048)
parser.add_argument('--batch_size', '-bs', type=int, default=64)
parser.add_argument('--n_epochs', '-ne', type=int, default=10)
parser.add_argument('--gamma', '-g', type=float, default=.99)
parser.add_argument('--gae_lambda', '-gl', type=float, default=.95)
parser.add_argument('--clip_range', '-cr', type=float, default=.2)
parser.add_argument('--ent_coef', '-ec', type=float, default=0)
parser.add_argument('--vf_coef', '-v', type=float, default=.5)
parser.add_argument('--max_grad_norm', '-m', type=float, default=.5)
args = parser.parse_args()

# experiment ID
environment = args.environment
n_episodes = args.episodes
name = 'PPO-' + environment + '-' + str(n_episodes) + '-episodes'

with mlflow.start_run(run_name=name):

    mlflow.log_param('env', environment)
    mlflow.log_param('episodes', n_episodes)

    mlflow.log_param('learning_rate', args.learning_rate)
    mlflow.log_param('n_steps', args.n_steps)
    mlflow.log_param('batch_size', args.batch_size)
    mlflow.log_param('n_epochs', args.n_epochs)
    mlflow.log_param('gamma', args.gamma)
    mlflow.log_param('gae_lambda', args.gae_lambda)
    mlflow.log_param('clip_range', args.clip_range)
    mlflow.log_param('ent_coef', args.ent_coef)
    mlflow.log_param('vf_coef', args.vf_coef)
    mlflow.log_param('max_grad_norm', args.max_grad_norm)

    env = gym.make(environment)
    env = NormalizeObservation(LoggerWrapper(env))

    #### TRAINING ####

    # Build model
    # model = PPO('MlpPolicy', env, verbose=1,
    #             learning_rate=args.learning_rate,
    #             n_steps=args.n_steps,
    #             batch_size=args.batch_size,
    #             n_epochs=args.n_epochs,
    #             gamma=args.gamma,
    #             gae_lambda=args.gae_lambda,
    #             clip_range=args.clip_range,
    #             ent_coef=args.ent_coef,
    #             vf_coef=args.vf_coef,
    #             max_grad_norm=args.max_grad_norm,
    #             tensorboard_log='./tensorboard_log/' + name)

    # n_timesteps_episode = env.simulator._eplus_one_epi_len / \
    #     env.simulator._eplus_run_stepsize
    # timesteps = n_episodes * n_timesteps_episode + 501

    # env = DummyVecEnv([lambda: env])

    # # Callbacks
    # freq = 5  # evaluate every N episodes
    # eval_callback = LoggerEvalCallback(env, best_model_save_path='./best_models/' + name + '/',
    #                                    log_path='./best_models/' + name + '/', eval_freq=n_timesteps_episode * freq,
    #                                    deterministic=True, render=False, n_eval_episodes=2)
    # log_callback = LoggerCallback()
    # callback = CallbackList([log_callback, eval_callback])

    # # Training
    # model.learn(total_timesteps=timesteps, callback=callback)
    # model.save(name)

    #### LOAD MODEL ####

    model = PPO.load('best_models/' + name + '/best_model.zip')

    for i in range(n_episodes - 1):
        obs = env.reset()
        rewards = []
        done = False
        current_month = 0
        while not done:
            a, _ = model.predict(obs)
            obs, reward, done, info = env.step(a)
            rewards.append(reward)
            if info['month'] != current_month:
                current_month = info['month']
                print(info['month'], sum(rewards))
        print('Episode ', i, 'Mean reward: ', np.mean(rewards), 'Cumulative reward: ', sum(rewards))
    env.close()

    mlflow.log_metric('mean_reward', np.mean(rewards))
    mlflow.log_metric('cumulative_reward', sum(rewards))

    mlflow.end_run()
