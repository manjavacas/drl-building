setwd('~/master/TFM/plots')

library(readr)
library(ggplot2)
library(tidyverse)
library(reshape2)
library(ggpubr)

make_plot <- function(metric) {
  data %>% ggplot(aes_string(x = 'Episodio', y = metric)) +
    geom_line(aes(linetype = Agente, colour = Agente)) + theme_bw()
}

############ ENTORNOS DISCRETOS ############

## COOL ##
RBC_disc_cool <- read_csv('RBC/disc-cool.csv')
A2C_disc_cool <- read_csv('A2C/disc-cool.csv')
PPO_disc_cool <- read_csv('PPO/disc-cool.csv')
RAND_disc_cool <- read_csv('RAND/disc-cool.csv')

RBC_disc_cool <- RBC_disc_cool %>% mutate(Agente = 'RBC')
A2C_disc_cool <- A2C_disc_cool %>% mutate(Agente = 'A2C')
PPO_disc_cool <- PPO_disc_cool %>% mutate(Agente = 'PPO')
RAND_disc_cool <- RAND_disc_cool %>% mutate(Agente = 'RAND')

data <- rbind(RBC_disc_cool, A2C_disc_cool, PPO_disc_cool, RAND_disc_cool) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_acumulada`=`cumulative_reward`,
         `consumo_acumulado`=`cumulative_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`cumulative_comfort_penalty`,
         `penalizacion_consumo`=`cumulative_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_plot)

ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('discrete-cool-plots.pdf')

## MIXED ##
RBC_disc_mixed <- read_csv('RBC/disc-mixed.csv')
A2C_disc_mixed <- read_csv('A2C/disc-mixed.csv')
PPO_disc_mixed <- read_csv('PPO/disc-mixed.csv')
RAND_disc_mixed <- read_csv('RAND/disc-mixed.csv')

RBC_disc_mixed <- RBC_disc_mixed %>% mutate(Agente = 'RBC')
A2C_disc_mixed <- A2C_disc_mixed %>% mutate(Agente = 'A2C')
PPO_disc_mixed <- PPO_disc_mixed %>% mutate(Agente = 'PPO')
RAND_disc_mixed <- RAND_disc_mixed %>% mutate(Agente = 'RAND')

data <- rbind(RBC_disc_mixed, A2C_disc_mixed, PPO_disc_mixed, RAND_disc_mixed) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_acumulada`=`cumulative_reward`,
         `consumo_acumulado`=`cumulative_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`cumulative_comfort_penalty`,
         `penalizacion_consumo`=`cumulative_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_plot)

ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('discrete-mixed-plots.pdf')

## HOT ##
RBC_disc_hot <- read_csv('RBC/disc-hot.csv')
A2C_disc_hot <- read_csv('A2C/disc-hot.csv')
PPO_disc_hot <- read_csv('PPO/disc-hot.csv')
RAND_disc_hot <- read_csv('RAND/disc-hot.csv')

RBC_disc_hot <- RBC_disc_hot %>% mutate(Agente = 'RBC')
A2C_disc_hot <- A2C_disc_hot %>% mutate(Agente = 'A2C')
PPO_disc_hot <- PPO_disc_hot %>% mutate(Agente = 'PPO')
RAND_disc_hot <- RAND_disc_hot %>% mutate(Agente = 'RAND')

data <- rbind(RBC_disc_hot, A2C_disc_hot, PPO_disc_hot, RAND_disc_hot) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_acumulada`=`cumulative_reward`,
         `consumo_acumulado`=`cumulative_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`cumulative_comfort_penalty`,
         `penalizacion_consumo`=`cumulative_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_plot)

ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('discrete-hot-plots.pdf')

############ ENTORNOS CONTINUOS ############

## COOL ##
RBC_cont_cool <- read_csv('RBC/cont-cool.csv')
A2C_cont_cool <- read_csv('A2C/cont-cool.csv')
PPO_cont_cool <- read_csv('PPO/cont-cool.csv')
RAND_cont_cool <- read_csv('RAND/cont-cool.csv')
DDPG_cont_cool <- read_csv('DDPG/cont-cool.csv')
SAC_cont_cool <- read_csv('SAC/cont-cool.csv')

RBC_cont_cool <- RBC_cont_cool %>% mutate(Agente = 'RBC')
A2C_cont_cool <- A2C_cont_cool %>% mutate(Agente = 'A2C')
PPO_cont_cool <- PPO_cont_cool %>% mutate(Agente = 'PPO')
RAND_cont_cool <- RAND_cont_cool %>% mutate(Agente = 'RAND')
DDPG_cont_cool <- DDPG_cont_cool %>% mutate(Agente = 'DDPG')
SAC_cont_cool <- SAC_cont_cool %>% mutate(Agente = 'SAC')

data <- rbind(RBC_cont_cool, A2C_cont_cool, PPO_cont_cool, RAND_cont_cool, DDPG_cont_cool, SAC_cont_cool) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_acumulada`=`cumulative_reward`,
         `consumo_acumulado`=`cumulative_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`cumulative_comfort_penalty`,
         `penalizacion_consumo`=`cumulative_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_plot)

ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('continuous-cool-plots.pdf')

## MIXED ##
RBC_cont_mixed <- read_csv('RBC/cont-mixed.csv')
A2C_cont_mixed <- read_csv('A2C/cont-mixed.csv')
PPO_cont_mixed <- read_csv('PPO/cont-mixed.csv')
RAND_cont_mixed <- read_csv('RAND/cont-mixed.csv')
DDPG_cont_mixed <- read_csv('DDPG/cont-mixed.csv')
SAC_cont_mixed <- read_csv('SAC/cont-mixed.csv')

RBC_cont_mixed <- RBC_cont_mixed %>% mutate(Agente = 'RBC')
A2C_cont_mixed <- A2C_cont_mixed %>% mutate(Agente = 'A2C')
PPO_cont_mixed <- PPO_cont_mixed %>% mutate(Agente = 'PPO')
RAND_cont_mixed <- RAND_cont_mixed %>% mutate(Agente = 'RAND')
DDPG_cont_mixed <- DDPG_cont_mixed %>% mutate(Agente = 'DDPG')
SAC_cont_mixed <- SAC_cont_mixed %>% mutate(Agente = 'SAC')

data <- rbind(RBC_cont_mixed, A2C_cont_mixed, PPO_cont_mixed, RAND_cont_mixed, DDPG_cont_mixed, SAC_cont_mixed) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_acumulada`=`cumulative_reward`,
         `consumo_acumulado`=`cumulative_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`cumulative_comfort_penalty`,
         `penalizacion_consumo`=`cumulative_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_plot)

ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('continuous-mixed-plots.pdf')

## HOT ##
RBC_cont_hot <- read_csv('RBC/cont-hot.csv')
A2C_cont_hot <- read_csv('A2C/cont-hot.csv')
PPO_cont_hot <- read_csv('PPO/cont-hot.csv')
RAND_cont_hot <- read_csv('RAND/cont-hot.csv')
DDPG_cont_hot <- read_csv('DDPG/cont-hot.csv')
SAC_cont_hot <- read_csv('SAC/cont-hot.csv')

RBC_cont_hot <- RBC_cont_hot %>% mutate(Agente = 'RBC')
A2C_cont_hot <- A2C_cont_hot %>% mutate(Agente = 'A2C')
PPO_cont_hot <- PPO_cont_hot %>% mutate(Agente = 'PPO')
RAND_cont_hot <- RAND_cont_hot %>% mutate(Agente = 'RAND')
DDPG_cont_hot <- DDPG_cont_hot %>% mutate(Agente = 'DDPG')
SAC_cont_hot <- SAC_cont_hot %>% mutate(Agente = 'SAC')

data <- rbind(RBC_cont_hot, A2C_cont_hot, PPO_cont_hot, RAND_cont_hot, DDPG_cont_hot, SAC_cont_hot) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_acumulada`=`cumulative_reward`,
         `consumo_acumulado`=`cumulative_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`cumulative_comfort_penalty`,
         `penalizacion_consumo`=`cumulative_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_plot)

ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('continuous-hot-plots.pdf')





