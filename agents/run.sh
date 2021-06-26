#!/bin/bash

#envs=("Eplus-discrete-stochastic-hot-v1" "Eplus-discrete-stochastic-mixed-v1" "Eplus-discrete-stochastic-cool-v1" \
#"Eplus-continuous-stochastic-hot-v1" "Eplus-continuous-stochastic-mixed-v1" "Eplus-continuous-stochastic-cool-v1")

#envs=("Eplus-discrete-stochastic-hot-v1" "Eplus-discrete-stochastic-mixed-v1" "Eplus-discrete-stochastic-cool-v1")
envs=("Eplus-continuous-stochastic-hot-v1" "Eplus-continuous-stochastic-mixed-v1" "Eplus-continuous-stochastic-cool-v1")

for env in ${envs[*]}; do
    ./DDPG.py -env $env -ep 20
done