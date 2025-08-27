##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            ~~
##     SPAGHETTI CODE -- PRACTICING VARIOUS METHODS TO REPRODUCE FIGURE 3   ----
##     Author: Leela Dixit, dixitleela@gmail.com                              ~~
##                                                                            ~~
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# read in packages
library(tidyverse)
library(here)
library(janitor)
library(lubridate)

# read in data 
Q1 <- read_csv(here("data", "data_raw", "QuebradaCuenca1-Bisley.csv")) %>% 
  select(Sample_ID, Sample_Date, "NO3-N", K, Mg, Ca, "NH4-N") %>% 
  clean_names()
Q2 <- read_csv(here("data", "data_raw", "QuebradaCuenca2-Bisley.csv"))%>% 
  select(Sample_ID, Sample_Date, "NO3-N", K, Mg, Ca, "NH4-N")%>% 
  clean_names()
Q3 <- read_csv(here("data", "data_raw", "QuebradaCuenca3-Bisley.csv"))  %>% 
  select(Sample_ID, Sample_Date, "NO3-N", K, Mg, Ca, "NH4-N")%>% 
  clean_names()
PRM <- read_csv(here("data", "data_raw", "RioMameyesPuenteRoto.csv"))%>% 
  select(Sample_ID, Sample_Date, "NO3-N", K, Mg, Ca, "NH4-N")%>% 
  clean_names()

# combine individual site data frames into one long data frame
full_data <- Q1 %>% 
  full_join(Q2) %>% 
  full_join(Q3) %>% 
  full_join(PRM) %>% 
  pivot_longer("no3_n":"nh4_n", # pivot concentrations and values to be long
               names_to = "ions",
               values_to = "concentration") %>% 
  mutate(day = yday(sample_date))

# create a subset of just potassium data to practice 
full_data_k <- full_data %>% 
  filter(ions == "k") %>% 
  mutate(sample_date = ymd(sample_date)) %>% 
  mutate(sample_date_28 = sample_date + days(28))

full_data_nh4 <- full_data %>% 
  filter(ions == "nh4_n")

# try plotting it
#ggplot(data = full_data, aes(x = sample_date, y = concentration)) +
#  geom_point(aes(color = sample_id)) +
#  facet_wrap(~ concentration)

# practice function to calculate 9 week averages
y <- numeric(length = length(full_data_k$concentration))

please_work <- function(day) {
  for (i in 1:length(day)) {
    bound <- c(i-days(28):i+days(28))
    #bound <- bound[bound %in% seq_along(concentration)]
    #y[i] <- mean(concentration[bound])
  }
}

# mean(c(concentration along date boundaries))

full_data_k %>% 
  for (i in 1:length(sample_date)) {
  bound <- seq(sample_date[i]-days(28), sample_date[i]+days(28))
  #bound <- bound[bound %in% seq_along(concentration)]
  #y[i] <- mean(concentration[bound])
  print(bound) 
}

full_data_k %>% 
  please_work(day = sample_date)

# try something new i guess
bound <- full_data_k %>% 
  interval(sample_date - days(28), sample_date + days(28))

# trying something new part 3
data_k_subset <- full_data_k %>% 
  filter(sample_date <= ymd("1986-12-23") + days(28),
         sample_date >= ymd("1986-12-23") - days(28)) %>% 
  group_by(sample_id) %>% 
  mutate(moving_mean = mean(concentration)) %>% 
  ungroup()
#####IT WORKED OKAY LETS GOOO###

#for loops test
#full_data_k %>% 
#  for (i in 1:length(full_data_k$sample_date)) {
#  filter(sample_date < sample_date[i] + days(28),
#           sample_date > sample_date[i] - days(28))
#  mutate(moving_mean[i] == mean(full_data_k$concentration))
#}

data_k_loop <- 
  for (i in 1:length(full_data_k$sample_date)) {
  filter(sample_date <= ymd(sample_date[i]) + days(28),
         sample_date >= ymd(sample_date[i]) - days(28))
  group_by(sample_id)
  mutate(moving_mean = mean(concentration))
  ungroup()
}
