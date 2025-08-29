##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            ~~
##               READ, CLEAN, APPLY FUNCTIONS, AND COMBINE DATA             ----
##                                                                            ~~
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#........................read in packages........................
library(tidyverse)
library(janitor)
library(here)

#....................read in each site's data....................
# keep only the following columns
  # Sample ID
  # Sample Date
  # the following ion concentrations: NO3-N, K, Mg, Ca, Nh4-N
Q1 <- read_csv(here("data", "QuebradaCuenca1-Bisley.csv")) %>% 
  select(Sample_ID, Sample_Date, "NO3-N", K, Mg, Ca, "NH4-N") %>% 
  clean_names()
Q2 <- read_csv(here("data", "QuebradaCuenca2-Bisley.csv"))%>% 
  select(Sample_ID, Sample_Date, "NO3-N", K, Mg, Ca, "NH4-N")%>% 
  clean_names()
Q3 <- read_csv(here("data", "QuebradaCuenca3-Bisley.csv"))  %>% 
  select(Sample_ID, Sample_Date, "NO3-N", K, Mg, Ca, "NH4-N")%>% 
  clean_names()
PRM <- read_csv(here("data", "RioMameyesPuenteRoto.csv"))%>% 
  select(Sample_ID, Sample_Date, "NO3-N", K, Mg, Ca, "NH4-N")%>% 
  clean_names()

#......source the moving average function from its R script......
source(here("R", "moving_average.R"))

# author note: developing a for loop for the following function applications would help de-clutter this code, when time allows.

# PRM site
PRM$no3_n <- sapply( # sapply() is a function that applies a function to a whole data frame
  PRM$sample_date,   # apply the moving mean to the same column name, overwriting original data
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

# Q1 site
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
# Q3 site
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
#........join all 4 sites together into a long data frame........
full_data <- Q1 %>% 
  full_join(Q2) %>% 
  full_join(Q3) %>% 
  full_join(PRM) %>% 
  pivot_longer("no3_n":"nh4_n", # pivot concentrations and values to be long
               names_to = "ions",
               values_to = "concentration") %>% 
  filter(sample_date < ymd("1994-07-01"))

#.........export full data csv file to data clean folder.........
write.csv(full_data, file='output/full_data.csv')

