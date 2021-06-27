#!/usr/bin/python3

import gym
import argparse
import numpy as np
import mlflow

from energym.utils.controllers import RuleBasedController

parser = argparse.ArgumentParser()
parser.add_argument('--environment', '-env', type=str, default=None)
parser.add_argument('--episodes', '-ep', type=int, default=1)
args = parser.parse_args()

environment = args.environment
n_episodes = args.episodes

env = gym.make(environment)

name = 'RBC-' + environment + '-' + str(n_episodes) + '-episodes'

with mlflow.start_run(run_name=name):

    # create rule-based agent
    agent = RuleBasedController(env)

    for i in range(n_episodes - 1):
        obs = env.reset()
        rewards = []
        done = False
        current_month = 0
        while not done:
            a = agent.act(obs)
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
