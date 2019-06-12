library(tidyverse)

k <- 10
n <- 10000
coin <- rbinom(n, k, .5)/k
pair <- cbind(rbinom(n, k, .3), rbinom(n, k, .7))/k
pair <- rowMeans(pair)
experiment <- data.frame(coin, pair)

pair05 <- replicate(n,
                    MASS::mvrnorm(k, c(-.2,.2), cbind(c(1, 0.5), c(0.5, 1))) > 0,
                    simplify = FALSE) %>% 
  map_dbl(mean)

plot_pair <- experiment %>% gather() %>% 
  ggplot(aes(value)) +
  geom_density(adjust = 3, fill = "lightgrey", color = NA) +
  facet_wrap(~key, ncol = 1) + 
  theme_minimal() +
  theme(axis.title.x = element_text(colour = "lightgrey"),
        axis.title.y = element_text(colour = "lightgrey"),
        strip.text = element_text(colour = "lightgrey"),
        axis.text = element_text(colour = "lightgrey"))
ggsave("../Figs/coin.pdf", plot_pair, width = 4, height = 2, units = "in")

experiment <- mutate(experiment, pair05)

plot_pair05 <- experiment %>% gather() %>% 
  ggplot(aes(value)) +
  geom_density(adjust = 3, fill = "grey", color = NA) +
  facet_wrap(~key, ncol = 1) + 
  theme_minimal() +
  theme(axis.title.x = element_text(colour = "lightgrey"),
        axis.title.y = element_text(colour = "lightgrey"),
        strip.text = element_text(colour = "lightgrey"),
        axis.text = element_text(colour = "lightgrey"))

ggsave("../Figs/coin_cor.pdf", plot_pair05, width = 4, height = 3, units = "in")
