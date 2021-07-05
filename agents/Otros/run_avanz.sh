#!/bin/bash

#envs=("Eplus-discrete-stochastic-hot-v1" "Eplus-discrete-stochastic-mixed-v1" "Eplus-discrete-stochastic-cool-v1" \
#"Eplus-continuous-stochastic-hot-v1" "Eplus-continuous-stochastic-mixed-v1" "Eplus-continuous-stochastic-cool-v1")

#envs=("Eplus-discrete-stochastic-hot-v1" "Eplus-discrete-stochastic-mixed-v1" "Eplus-discrete-stochastic-cool-v1")
envs=("Eplus-continuous-stochastic-hot-v1" "Eplus-continuous-stochastic-mixed-v1" "Eplus-continuous-stochastic-cool-v1")

./DDPG_avanz.py -env "Eplus-continuous-stochastic-mixed-v1" -ep 20 -ew 1
./DDPG_avanz.py -env "Eplus-continuous-stochastic-mixed-v1" -ep 20 -ew 0.75
./DDPG_avanz.py -env "Eplus-continuous-stochastic-mixed-v1" -ep 20 -ew 0.25
./DDPG_avanz.py -env "Eplus-continuous-stochastic-mixed-v1" -ep 20 -ew 0

