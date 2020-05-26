library(tidyverse)
library(ggplot2)
library(HistData)

#Will use the 'Cholera' historic data.
data("GaltonFamilies")

data <- GaltonFamilies 

### Correlation between fathers/mothers height vs sons height -------------
#Filtering data
family <- data %>% 
  select(1,2,3,8) %>% 
  group_by(family) %>% 
  summarize(father=mean(father), mother=mean(mother), child=mean(childHeight)) %>% 
  ungroup()
family$child <- round(family$child, 2)

#Tidy form for ggplot
family.t <- family %>% 
  gather(key="parent", value="parent_height", 2:3) %>% 
  select(-1)

ggplot(family.t, aes(x=parent_height, y=child))+
  geom_point(alpha=0.5)+
  geom_smooth(method=lm, se=F, linetype="dashed", color="red")+
  facet_wrap(.~parent)

#Correlation
family.c <- family %>%  
  summarize(f.cor=cor(father, child), m.cor=cor(mother, child))







  
