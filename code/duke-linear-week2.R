library(tidyverse)
library(ggplot2)
library(statsr)

data("mlb11")

data <- mlb11
attach(data)

ggplot(data, aes(x=at_bats, y=runs))+
  geom_point()+
  geom_smooth(method = "lm", se=F)+
  geom_vline(xintercept = 5579)

cor <- data %>% 
  summarize(correlation=cor(runs, at_bats)) %>% 
  pull()

plot_ss(x=at_bats, y=runs, data=data, showSquares = T)

lm <- lm(runs~at_bats, data)
summary(lm)
lm2 <- lm(runs~homeruns, data)
summary(lm2)

data2 <- data %>% 
  filter(at_bats==5579) %>% 
  select(runs)

ggplot(data = lm, aes(x = .fitted, y = .resid)) +
  geom_point() +
  geom_hline(yintercept = 0, linetype = "dashed") +
  xlab("Fitted values") +
  ylab("Residuals")

ggplot(data = lm, aes(x = .resid)) +
  geom_histogram(binwidth = 25) +
  xlab("Residuals")

ggplot(data = lm, aes(sample = .resid)) +
  stat_qq()+
  stat_qq_line()

lm3 <- lm(runs~hits, data)
lm4 <- lm(runs~wins, data)
lm5 <- lm(runs~bat_avg, data)
summary(lm3)
summary(lm4)
summary(lm5)
summary(lm)

lm6 <- lm(runs~new_obs, data)
lm7 <- lm(runs~new_slug, data)
lm8 <- lm(runs~new_onbase, data)
summary(lm6)
summary(lm7)
summary(lm8)





