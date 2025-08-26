library(tidyverse)
library(here)
library(janitor)
library(lubridate)

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


full_data <- Q1 %>% 
  full_join(Q2) %>% 
  full_join(Q3) %>% 
  full_join(PRM) %>% 
  pivot_longer("no3_n":"nh4_n",
               names_to = "ions",
               values_to = "concentration") %>% 
  mutate(week = week(sample_date))

full_data_k <- full_data %>% 
  filter(ions == "k")

#i dont know whats going on here, still!
[i-4]:[i+4]

#ggplot(data = full_data, aes(x = sample_date, y = concentration)) +
#  geom_point(aes(color = sample_id)) +
#  facet_wrap(~ concentration)
