setwd('~/master/TFM/plots')

library(readr)
library(ggplot2)
library(tidyverse)
library(reshape2)
library(ggpubr)

make_plot <- function(metric) {
  data %>% ggplot(aes_string(x = 'Episodio', y = metric)) +
    geom_point(aes(shape = Agente, colour = Agente), size=3) + theme_bw() + 
    theme(text=element_text(size=20))
}

make_single_plot <- function(metric) {
  data %>% ggplot(aes_string(x = 'Episodio', y = metric)) +
    geom_point(size=3, colour='red') + theme_bw() + 
    theme(text=element_text(size=20))
}

############ ENTORNOS DISCRETOS ############

## COOL ##
RBC_disc_cool <- read_csv('RBC/disc-cool.csv')
A2C_disc_cool <- read_csv('A2C/disc-cool.csv')
PPO_disc_cool <- read_csv('PPO/disc-cool.csv')
#RAND_disc_cool <- read_csv('RAND/disc-cool.csv')
DQN_disc_cool <- read_csv('DQN/disc-cool.csv')

RBC_disc_cool <- RBC_disc_cool %>% mutate(Agente = 'RBC')
A2C_disc_cool <- A2C_disc_cool %>% mutate(Agente = 'A2C')
PPO_disc_cool <- PPO_disc_cool %>% mutate(Agente = 'PPO')
#RAND_disc_cool <- RAND_disc_cool %>% mutate(Agente = 'RAND')
DQN_disc_cool <- DQN_disc_cool %>% mutate(Agente = 'DQN')

data <- rbind(RBC_disc_cool, A2C_disc_cool, PPO_disc_cool, DQN_disc_cool) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_media`=`mean_reward`,
         `consumo_medio`=`mean_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`mean_comfort_penalty`,
         `penalizacion_consumo`=`mean_power_penalty`,
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
#RAND_disc_mixed <- read_csv('RAND/disc-mixed.csv')
DQN_disc_mixed <- read_csv('DQN/disc-mixed.csv')

RBC_disc_mixed <- RBC_disc_mixed %>% mutate(Agente = 'RBC')
A2C_disc_mixed <- A2C_disc_mixed %>% mutate(Agente = 'A2C')
PPO_disc_mixed <- PPO_disc_mixed %>% mutate(Agente = 'PPO')
#RAND_disc_mixed <- RAND_disc_mixed %>% mutate(Agente = 'RAND')
DQN_disc_mixed <- DQN_disc_mixed %>% mutate(Agente = 'DQN')

data <- rbind(RBC_disc_mixed, A2C_disc_mixed, PPO_disc_mixed, DQN_disc_mixed) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_media`=`mean_reward`,
         `consumo_medio`=`mean_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`mean_comfort_penalty`,
         `penalizacion_consumo`=`mean_power_penalty`,
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
#RAND_disc_hot <- read_csv('RAND/disc-hot.csv')
DQN_disc_hot <- read_csv('DQN/disc-hot.csv')

RBC_disc_hot <- RBC_disc_hot %>% mutate(Agente = 'RBC')
A2C_disc_hot <- A2C_disc_hot %>% mutate(Agente = 'A2C')
PPO_disc_hot <- PPO_disc_hot %>% mutate(Agente = 'PPO')
#RAND_disc_hot <- RAND_disc_hot %>% mutate(Agente = 'RAND')
DQN_disc_hot <- DQN_disc_hot %>% mutate(Agente = 'DQN')

data <- rbind(RBC_disc_hot, A2C_disc_hot, PPO_disc_hot, DQN_disc_hot) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_media`=`mean_reward`,
         `consumo_medio`=`mean_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`mean_comfort_penalty`,
         `penalizacion_consumo`=`mean_power_penalty`,
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
#RAND_cont_cool <- read_csv('RAND/cont-cool.csv')
DDPG_cont_cool <- read_csv('DDPG/cont-cool.csv')
SAC_cont_cool <- read_csv('SAC/cont-cool.csv')

RBC_cont_cool <- RBC_cont_cool %>% mutate(Agente = 'RBC')
A2C_cont_cool <- A2C_cont_cool %>% mutate(Agente = 'A2C')
PPO_cont_cool <- PPO_cont_cool %>% mutate(Agente = 'PPO')
#RAND_cont_cool <- RAND_cont_cool %>% mutate(Agente = 'RAND')
DDPG_cont_cool <- DDPG_cont_cool %>% mutate(Agente = 'DDPG')
SAC_cont_cool <- SAC_cont_cool %>% mutate(Agente = 'SAC')

data <- rbind(RBC_cont_cool, A2C_cont_cool, PPO_cont_cool, DDPG_cont_cool, SAC_cont_cool) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_media`=`mean_reward`,
         `consumo_medio`=`mean_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`mean_comfort_penalty`,
         `penalizacion_consumo`=`mean_power_penalty`,
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
#RAND_cont_mixed <- read_csv('RAND/cont-mixed.csv')
DDPG_cont_mixed <- read_csv('DDPG/cont-mixed.csv')
SAC_cont_mixed <- read_csv('SAC/cont-mixed.csv')

RBC_cont_mixed <- RBC_cont_mixed %>% mutate(Agente = 'RBC')
A2C_cont_mixed <- A2C_cont_mixed %>% mutate(Agente = 'A2C')
PPO_cont_mixed <- PPO_cont_mixed %>% mutate(Agente = 'PPO')
#RAND_cont_mixed <- RAND_cont_mixed %>% mutate(Agente = 'RAND')
DDPG_cont_mixed <- DDPG_cont_mixed %>% mutate(Agente = 'DDPG')
SAC_cont_mixed <- SAC_cont_mixed %>% mutate(Agente = 'SAC')

data <- rbind(RBC_cont_mixed, A2C_cont_mixed, PPO_cont_mixed, DDPG_cont_mixed, SAC_cont_mixed) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_media`=`mean_reward`,
         `consumo_medio`=`mean_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`mean_comfort_penalty`,
         `penalizacion_consumo`=`mean_power_penalty`,
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
#RAND_cont_hot <- read_csv('RAND/cont-hot.csv')
DDPG_cont_hot <- read_csv('DDPG/cont-hot.csv')
SAC_cont_hot <- read_csv('SAC/cont-hot.csv')

RBC_cont_hot <- RBC_cont_hot %>% mutate(Agente = 'RBC')
A2C_cont_hot <- A2C_cont_hot %>% mutate(Agente = 'A2C')
PPO_cont_hot <- PPO_cont_hot %>% mutate(Agente = 'PPO')
#RAND_cont_hot <- RAND_cont_hot %>% mutate(Agente = 'RAND')
DDPG_cont_hot <- DDPG_cont_hot %>% mutate(Agente = 'DDPG')
SAC_cont_hot <- SAC_cont_hot %>% mutate(Agente = 'SAC')

data <- rbind(RBC_cont_hot, A2C_cont_hot, PPO_cont_hot, DDPG_cont_hot, SAC_cont_hot) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_media`=`mean_reward`,
         `consumo_medio`=`mean_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`mean_comfort_penalty`,
         `penalizacion_consumo`=`mean_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_plot)

ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('continuous-hot-plots.pdf')

##### STATS #####

# DQN_disc_mixed %>% select(mean_reward) %>% summarise(media=round(mean(mean_reward),3), sd=round(sd(mean_reward),3))

get_stats <- function(df) {
  rbind(df %>% select(mean_reward) %>% summarise_if(is.numeric, mean), 
        df %>% select(mean_reward) %>% summarise_if(is.numeric, sd))
}

get_stats_col <- function(df, col) {
  rbind(df %>% select(mean_reward) %>% select(col) %>% summarise_if(is.numeric, mean), 
        df %>% select(mean_reward) %>% select(col) %>% summarise_if(is.numeric, sd))
}

calc_percent <- function(df1, df2, var) {
  m1 <- abs(mean(df1[[var]]))
  m2 <- abs(mean(df2[[var]]))
  100 - (m2*100/m1)
}

stat_calc <- function(df, var) {
  df %>% select({{var}}) %>% summarise(media=round(mean({{var}}),3), sd=round(sd({{var}}),3))
}

stat_calc(SAC_cont_hot, mean_power_consumption)
stat_calc(SAC_cont_cool, mean_power_consumption)
stat_calc(SAC_cont_mixed, mean_power_consumption)

##### EQUILIBRIO CONFORT-CONSUMO #####

DDPG_75_energy_cont_mixed <- read_csv('Pesos/DDPG_75_Energy.csv')
DDPG_100_energy_cont_mixed <- read_csv('Pesos/DDPG_100_Energy.csv')

DDPG_75_energy_cont_mixed <- DDPG_75_energy_cont_mixed %>% mutate(Agente = 'DDPG 75% consumo')
DDPG_100_energy_cont_mixed <- DDPG_100_energy_cont_mixed %>% mutate(Agente = 'DDPG 100% consumo')

data <- rbind(DDPG_cont_mixed, DDPG_75_energy_cont_mixed, DDPG_100_energy_cont_mixed) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_media`=`mean_reward`,
         `consumo_medio`=`mean_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`mean_comfort_penalty`,
         `penalizacion_consumo`=`mean_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_plot)
ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('energy-weights-DDPG.pdf')

##

DDPG_75_confort_cont_mixed <- read_csv('Pesos/DDPG_25_Energy.csv')
DDPG_100_confort_cont_mixed <- read_csv('Pesos/DDPG_0_Energy.csv')

DDPG_75_confort_cont_mixed <- DDPG_75_confort_cont_mixed %>% mutate(Agente = 'DDPG 75% confort')
DDPG_100_confort_cont_mixed <- DDPG_100_confort_cont_mixed %>% mutate(Agente = 'DDPG 100% confort')

data <- rbind(DDPG_cont_mixed, DDPG_75_confort_cont_mixed, DDPG_100_confort_cont_mixed) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_media`=`mean_reward`,
         `consumo_medio`=`mean_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`mean_comfort_penalty`,
         `penalizacion_consumo`=`mean_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_plot)
ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('confort-weights-DDPG.pdf')

##### ROBUSTEZ #####

DDPG_cont_mixed <- read_csv('DDPG/cont-mixed.csv')
DDPG_cont_mixed_hot <- read_csv('Robust/cont-mixed-hot.csv')
DDPG_cont_mixed_cool <- read_csv('Robust/cont-mixed-cool.csv')

DDPG_cont_mixed <- DDPG_cont_mixed %>% mutate(Agente = 'DDPG mixed-mixed')
DDPG_cont_mixed_hot <- DDPG_cont_mixed_hot %>% mutate(Agente = 'DDPG mixed-hot')
DDPG_cont_mixed_cool <- DDPG_cont_mixed_cool %>% mutate(Agente = 'DDPG mixed-cool')

data <- rbind(DDPG_cont_mixed, DDPG_cont_mixed_hot, DDPG_cont_mixed_cool) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_media`=`mean_reward`,
         `consumo_medio`=`mean_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`mean_comfort_penalty`,
         `penalizacion_consumo`=`mean_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_plot)

ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('mixed-robust-test.pdf')

##

DDPG_cont_cool <- read_csv('DDPG/cont-cool.csv')
DDPG_cont_cool_hot <- read_csv('Robust/cont-cool-hot.csv')

DDPG_cont_cool <- DDPG_cont_cool %>% mutate(Agente = 'DDPG cool-cool')
DDPG_cont_cool_hot <- DDPG_cont_cool_hot %>% mutate(Agente = 'DDPG cool-hot')

data <- rbind(DDPG_cont_cool, DDPG_cont_cool_hot) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_media`=`mean_reward`,
         `consumo_medio`=`mean_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`mean_comfort_penalty`,
         `penalizacion_consumo`=`mean_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_plot)

ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('cool-robust-test.pdf')

##

DDPG_cont_hot <- read_csv('DDPG/cont-hot.csv')
DDPG_cont_hot_cool <- read_csv('Robust/cont-hot-cool.csv')

DDPG_cont_hot <- DDPG_cont_hot %>% mutate(Agente = 'DDPG hot-hot')
DDPG_cont_hot_cool <- DDPG_cont_hot_cool %>% mutate(Agente = 'DDPG hot-cool')

data <- rbind(DDPG_cont_hot, DDPG_cont_hot_cool) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_media`=`mean_reward`,
         `consumo_medio`=`mean_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`mean_comfort_penalty`,
         `penalizacion_consumo`=`mean_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_plot)

ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('hot-robust-test.pdf')

#### DDPG ####

data <- DDPG_cont_mixed %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_media`=`mean_reward`,
         `consumo_medio`=`mean_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`mean_comfort_penalty`,
         `penalizacion_consumo`=`mean_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_plot)

ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('DDPG-results.pdf')

#### CV LEARNING: HOT THEN COOL vs MIXED ####

DDPG_cont_mixed <- read_csv('DDPG/cont-mixed.csv')
DDPG_cont_hot_then_cool <- read_csv('CV/DDPG-cont-mixed-hot-then-cool.csv')

DDPG_cont_mixed <- DDPG_cont_mixed %>% mutate(Agente = 'DDPG mixed')
DDPG_cont_hot_then_cool <- DDPG_cont_hot_then_cool %>% mutate(Agente = 'DDPG hot+cool')

data <- rbind(DDPG_cont_mixed, DDPG_cont_hot_then_cool) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_media`=`mean_reward`,
         `consumo_medio`=`mean_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`mean_comfort_penalty`,
         `penalizacion_consumo`=`mean_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_plot)

ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('CV-learning.pdf')

#### DDPG FIXED TEST ####

DDPG_cont_mixed_fixed <- read_csv('./cont-mixed-fixed-ddpg.csv')
DDPG_cont_mixed_fixed <- DDPG_cont_mixed_fixed %>% mutate(Agente = 'DDPG fixed')

data <- rbind(DDPG_cont_mixed_fixed) %>% 
  select(`Episodio`=`episode_num`,
         `recompensa_media`=`mean_reward`,
         `consumo_medio`=`mean_power_consumption`,
         `violacion_de_confort`=`comfort_violation (%)`,
         `penalizacion_confort`=`mean_comfort_penalty`,
         `penalizacion_consumo`=`mean_power_penalty`,
         Agente)

metrics <- data %>% 
  select(-c('Episodio', 'Agente')) %>% names

plots <- lapply(metrics, make_single_plot)

ggarrange(plotlist = plots, nrow=2, ncol=3, common.legend=TRUE)
ggsave('ddpg-cont-mixed-fixed.pdf')
