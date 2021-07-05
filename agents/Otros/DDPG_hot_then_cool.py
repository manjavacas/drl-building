#!/usr/bin/python3

import gym
import energym
import argparse
import uuid
import mlflow

import numpy as np

from energym.utils.callbacks import LoggerCallback, LoggerEvalCallback
from energym.utils.wrappers import NormalizeObservation, LoggerWrapper

from stable_baselines3 import DDPG
from stable_baselines3.common.callbacks import EvalCallback, BaseCallback, CallbackList
from stable_baselines3.common.vec_env import DummyVecEnv


parser = argparse.ArgumentParser()
parser.add_argument('--environment1', '-env1', type=str, default=None)
parser.add_argument('--environment2', '-env2', type=str, default=None)
parser.add_argument('--episodes', '-ep', type=int, default=1)
parser.add_argument('--learning_rate', '-lr', type=float, default=0.001)
parser.add_argument('--buffer_size', '-bf', type=int, default=1000000)
parser.add_argument('--learning_starts', '-ls', type=int, default=100)
parser.add_argument('--batch_size', '-bs', type=int, default=100)
parser.add_argument('--tau', '-t', type=float, default=0.005)
parser.add_argument('--gamma', '-g', type=float, default=.99)
parser.add_argument('--train_freq', '-tf', type=tuple, default=(1, 'episode'))
parser.add_argument('--gradient_steps', '-gs', type=int, default=-1)
args = parser.parse_args()

# experiment ID
environment1 = args.environment1
environment2 = args.environment2
n_episodes = args.episodes
name = 'DDPG-' + environment1 + '-then-' + environment2 + '-' + str(n_episodes) + '-episodes'

with mlflow.start_run(run_name=name):

    mlflow.log_param('env1', environment1)
    mlflow.log_param('env2', environment2)
    mlflow.log_param('episodes', n_episodes)

    mlflow.log_param('learning_rate', args.learning_rate)
    mlflow.log_param('buffer_size', args.buffer_size)
    mlflow.log_param('batch_size', args.batch_size)
    mlflow.log_param('tau', args.tau)
    mlflow.log_param('gamma', args.gamma)
    mlflow.log_param('train_freq', args.train_freq)
    mlflow.log_param('gradient_steps', args.gradient_steps)

    env1 = gym.make(environment1)
    env1 = NormalizeObservation(LoggerWrapper(env1))

    #### TRAINING ####

    # Build model
    # model = DDPG('MlpPolicy', env1, verbose=1,
    #             learning_rate=args.learning_rate,
    #             buffer_size=args.buffer_size,
    #             batch_size=args.batch_size,
    #             tau=args.tau,
    #             gamma=args.gamma,
    #             train_freq=args.train_freq,
    #             gradient_steps=args.gradient_steps,
    #             tensorboard_log='./tensorboard_log/' + name)

    # # Training
    # model.learn(total_timesteps=timesteps, callback=callback)
    # model.save(name)

    #### LOAD AND TRAIN SECOND MODEL ####

    model = DDPG.load('best_models/best_model.zip')

    env2 = gym.make(environment2)
    env2 = NormalizeObservation(LoggerWrapper(env2))

    n_timesteps_episode = env2.simulator._eplus_one_epi_len / \
         env2.simulator._eplus_run_stepsize
    timesteps = n_episodes * n_timesteps_episode + 501

    print('**********')
    print(n_timesteps_episode)

    # Callbacks
    freq = 20  # evaluate every N episodes
    eval_callback = LoggerEvalCallback(env2, best_model_save_path='./best_models/' + name + '/',
                                       log_path='./best_models/' + name + '/', eval_freq=n_timesteps_episode * freq,
                                       deterministic=True, render=False, n_eval_episodes=1)
    log_callback = LoggerCallback()
    callback = CallbackList([log_callback, eval_callback])

    env2 = DummyVecEnv([lambda: env2])
    
    model.set_env(env2)
    
    model.learn(total_timesteps=timesteps, callback=callback)
    model.save(name + '-CV')

    # for i in range(n_episodes - 1):
    #     obs = env.reset()
    #     rewards = []
    #     done = False
    #     current_month = 0
    #     while not done:
    #         a, _ = model.predict(obs)
    #         obs, reward, done, info = env.step(a)
    #         rewards.append(reward)
    #         if info['month'] != current_month:
    #             current_month = info['month']
    #             print(info['month'], sum(rewards))
    #     print('Episode ', i, 'Mean reward: ', np.mean(rewards), 'Cumulative reward: ', sum(rewards))
    # env.close()

    # mlflow.log_metric('mean_reward', np.mean(rewards))
    # mlflow.log_metric('cumulative_reward', sum(rewards))

    mlflow.end_run()