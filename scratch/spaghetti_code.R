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
#########################################################-
#########################################################-

source(here("R", "moving_average.R"))

# PRM site
PRM$no3_n <- sapply(
  PRM$sample_date,
  moving_average,
  dates = PRM$sample_date,
  conc = PRM$no3_n,
  win_size_wks = 9
)

PRM$k <- sapply(
  PRM$sample_date,
  moving_average,
  dates = PRM$sample_date,
  conc = PRM$k,
  win_size_wks = 9
)

PRM$mg <- sapply(
  PRM$sample_date,
  moving_average,
  dates = PRM$sample_date,
  conc = PRM$mg,
  win_size_wks = 9
)

PRM$ca <- sapply(
  PRM$sample_date,
  moving_average,
  dates = PRM$sample_date,
  conc = PRM$ca,
  win_size_wks = 9
)

PRM$nh4_n <- sapply(
  PRM$sample_date,
  moving_average,
  dates = PRM$sample_date,
  conc = PRM$nh4_n,
  win_size_wks = 9
)

PRM <- PRM %>% 
  pivot_longer("no3_n":"nh4_n", # pivot concentrations and values to be long
               names_to = "ions",
               values_to = "concentration")

ggplot(PRM, aes(x = sample_date, y = concentration)) +
  geom_line() +
  facet_wrap(~ions)

# Q1 sites
Q1$no3_n <- sapply(
  Q1$sample_date,
  moving_average,
  dates = Q1$sample_date,
  conc = Q1$no3_n,
  win_size_wks = 9
)
Q1$k <- sapply(
  Q1$sample_date,
  moving_average,
  dates = Q1$sample_date,
  conc = Q1$k,
  win_size_wks = 9
)
Q1$mg <- sapply(
  Q1$sample_date,
  moving_average,
  dates = Q1$sample_date,
  conc = Q1$mg,
  win_size_wks = 9
)
Q1$ca <- sapply(
  Q1$sample_date,
  moving_average,
  dates = Q1$sample_date,
  conc = Q1$ca,
  win_size_wks = 9
)
Q1$nh4_n <- sapply(
  Q1$sample_date,
  moving_average,
  dates = Q1$sample_date,
  conc = Q1$nh4_n,
  win_size_wks = 9
)
# Q2 sites
Q2$no3_n <- sapply(
  Q2$sample_date,
  moving_average,
  dates = Q2$sample_date,
  conc = Q2$no3_n,
  win_size_wks = 9
)
Q2$k <- sapply(
  Q2$sample_date,
  moving_average,
  dates = Q2$sample_date,
  conc = Q2$k,
  win_size_wks = 9
)
Q2$mg <- sapply(
  Q2$sample_date,
  moving_average,
  dates = Q2$sample_date,
  conc = Q2$mg,
  win_size_wks = 9
)
Q2$ca <- sapply(
  Q2$sample_date,
  moving_average,
  dates = Q2$sample_date,
  conc = Q2$ca,
  win_size_wks = 9
)
Q2$nh4_n <- sapply(
  Q2$sample_date,
  moving_average,
  dates = Q2$sample_date,
  conc = Q2$nh4_n,
  win_size_wks = 9
)
# Q3
Q3$no3_n <- sapply(
  Q3$sample_date,
  moving_average,
  dates = Q3$sample_date,
  conc = Q3$no3_n,
  win_size_wks = 9
)
Q3$k <- sapply(
  Q3$sample_date,
  moving_average,
  dates = Q3$sample_date,
  conc = Q3$k,
  win_size_wks = 9
)
Q3$mg <- sapply(
  Q3$sample_date,
  moving_average,
  dates = Q3$sample_date,
  conc = Q3$mg,
  win_size_wks = 9
)
Q3$ca <- sapply(
  Q3$sample_date,
  moving_average,
  dates = Q3$sample_date,
  conc = Q3$ca,
  win_size_wks = 9
)
Q3$nh4_n <- sapply(
  Q3$sample_date,
  moving_average,
  dates = Q3$sample_date,
  conc = Q3$nh4_n,
  win_size_wks = 9
)
# join code
full_data <- Q1 %>% 
  full_join(Q2) %>% 
  full_join(Q3) %>% 
  full_join(PRM) %>% 
  pivot_longer("no3_n":"nh4_n", # pivot concentrations and values to be long
               names_to = "ions",
               values_to = "concentration") #%>% 
  #filter(sample_date > "1988-10-01",
         #sample_date < "1994-07-01")

hurricane_date <- ymd("1989-09-18")

ggplot(full_data, aes(x = sample_date, y = concentration)) +
  geom_line(aes(linetype = sample_id)) +
  facet_wrap(~ions, ncol = 1, 
             scales = "free_y", 
             strip.position = "left") +
  geom_vline(xintercept = hurricane_date, linetype = "dashed") +
  theme_bw() +
  theme(strip.background = element_blank(),
        strip.placement = "outside",
        strip.text.y.left = element_text(angle = 90),
        axis.title.y = element_blank(),
        panel.spacing = unit(0, "lines"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
  # scale_x_continuous(sec.axis = dup_axis())
  
# test plot
ggplot(full_data, aes(x = sample_date, y = concentration)) +
  geom_line(aes(color = sample_id)) +
  facet_grid(rows = vars(ions)) +
  theme(strip.placement = "right")+
  theme_bw()


legend.position = c(0.8, 0.3)
legend.title=element_blank(),
legend.background = element_blank(),
legend.key=element_blank())

PRM_test <- read_csv(here("data", "RioMameyesPuenteRoto.csv"))%>% 
  select(Sample_ID, Sample_Date, "NO3-N", K, Mg, Ca, "NH4-N")%>% 
  clean_names()

for (i in 1:ncol(PRM_test)) {
  for (j in seq_along(PRM_test$sample_date)) {
    PRM_test[[i]] <- sapply(
      PRM_test$sample_date[j],
      moving_average,
      dates = PRM_test$sample_date,
      conc = PRM_test[[i]],
      win_size_wks = 9
    )
  }
}

