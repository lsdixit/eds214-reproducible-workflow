# read in each site's data
# keep only the following columns
  # Sample ID
  # Sample Date
  # the following ion concentrations: NO3-N, K, Mg, Ca, Nh4-N
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