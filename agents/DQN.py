#!/usr/bin/python3

import gym
import energym
import argparse
import uuid
import mlflow

import numpy as np

from energym.utils.callbacks import LoggerCallback, LoggerEvalCallback
from energym.utils.wrappers import NormalizeObservation, LoggerWrapper

from stable_baselines3 import DQN
from stable_baselines3.common.callbacks import EvalCallback, BaseCallback, CallbackList
from stable_baselines3.common.vec_env import DummyVecEnv


parser = argparse.ArgumentParser()
parser.add_argument('--environment', '-env', type=str, default=None)
parser.add_argument('--episodes', '-ep', type=int, default=1)
parser.add_argument('--learning_rate', '-lr', type=float, default=0.0001)
parser.add_argument('--buffer_size', '-bf', type=int, default=1000000)
parser.add_argument('--learning_starts', '-ls', type=int, default=50000)
parser.add_argument('--batch_size', '-bs', type=int, default=32)
parser.add_argument('--tau', '-t', type=float, default=1.0)
parser.add_argument('--gamma', '-g', type=float, default=.99)
parser.add_argument('--train_freq', '-tf', type=int, default=4)
parser.add_argument('--gradient_steps', '-gs', type=int, default=1)
parser.add_argument('--target_update_interval', '-tu', type=int, default=10000)
parser.add_argument('--exploration_fraction', '-e', type=float, default=.1)
parser.add_argument('--exploration_initial_eps', '-ei', type=float, default=1.0)
parser.add_argument('--exploration_final_eps', '-ef', type=float, default=.05)
parser.add_argument('--max_grad_norm', '-m', type=float, default=10)
args = parser.parse_args()

# experiment ID
environment = args.environment
n_episodes = args.episodes
name = 'DQN-' + environment + '-' + str(n_episodes) + '-episodes'

with mlflow.start_run(run_name=name):

    mlflow.log_param('env', environment)
    mlflow.log_param('episodes', n_episodes)

    mlflow.log_param('learning_rate', args.learning_rate)
    mlflow.log_param('buffer_size', args.buffer_size)
    mlflow.log_param('learning_starts', args.learning_starts)
    mlflow.log_param('batch_size', args.batch_size)
    mlflow.log_param('tau', args.tau)
    mlflow.log_param('gamma', args.gamma)
    mlflow.log_param('train_freq', args.train_freq)
    mlflow.log_param('gradient_steps', args.gradient_steps)
    mlflow.log_param('target_update_interval', args.target_update_interval)
    mlflow.log_param('exploration_fraction', args.exploration_fraction)
    mlflow.log_param('exploration_initial_eps', args.exploration_initial_eps)
    mlflow.log_param('exploration_final_eps', args.exploration_final_eps)
    mlflow.log_param('max_grad_norm', args.max_grad_norm)

    env = gym.make(environment)
    env = NormalizeObservation(LoggerWrapper(env))

    #### TRAINING ####

    # Build model
    # model = DQN('MlpPolicy', env, verbose=1,
    #             learning_rate=args.learning_rate,
    #             buffer_size=args.buffer_size,
    #             learning_starts=args.learning_starts,
    #             batch_size=args.batch_size,
    #             tau=args.tau,
    #             gamma=args.gamma,
    #             train_freq=args.train_freq,
    #             gradient_steps=args.gradient_steps,
    #             target_update_interval=args.target_update_interval,
    #             exploration_fraction=args.exploration_fraction,
    #             exploration_initial_eps=args.exploration_initial_eps,
    #             exploration_final_eps=args.exploration_final_eps,
    #             max_grad_norm=args.max_grad_norm,
    #             tensorboard_log='./tensorboard_log/' + name)
    
    # n_timesteps_episode = env.simulator._eplus_one_epi_len / \
    #     env.simulator._eplus_run_stepsize
    # timesteps = n_episodes * n_timesteps_episode + 501

    # env = DummyVecEnv([lambda: env])
    # env.env_method('activate_logger')

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

    model = DQN.load('best_models/' + name + '/best_model.zip')

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