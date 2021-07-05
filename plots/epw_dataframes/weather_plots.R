setwd("~/master/TFM/plots/epw_dataframes")

library(readr)
library(ggplot2)
library(tidyverse)
library(reshape2)
library(ggpubr)

# Port Angeles (WA)
cool <- read_csv('PortAngeles_EPW.csv')

# J.F.K (NY)
mixed <- read_csv('NewYork_EPW.csv')

# Tucson-Davis (MON)
hot <- read_csv('Tucson_EPW.csv')

cool_2 <- cool %>% mutate(Climate = 'Cool') %>% select(`Hora del año`=`X1`, `Clima`=Climate, `Temperatura ºC`=`drybulb`)
mixed_2 <- mixed %>% mutate(Climate = 'Mixed') %>% select(`Hora del año`=`X1`, `Clima`=Climate, `Temperatura ºC`=`drybulb`)
hot_2 <- hot %>% mutate(Climate = 'Hot') %>% select(`Hora del año`=`X1`, `Clima`=Climate, `Temperatura ºC`=`drybulb`)

df <- rbind(cool_2, mixed_2, hot_2)

df %>% ggplot(aes(x=`Hora del año`, y=`Temperatura ºC`)) + geom_line(aes(col=Clima)) +
  scale_color_manual(values=c('blue', 'red', 'green')) + theme_bw() + 
  theme(text=element_text(size=20))

ggsave('weathers.pdf')
