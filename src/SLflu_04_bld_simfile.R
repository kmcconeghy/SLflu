#---------------------------------------------------------#
# 
# Project: SuperLearn Modeling
# File to Build lab data
# Programmer: Kevin McConeghy
# Start: 10/22/2020
# 
#--------------------------------------------------------#
# Obtained from https://gis.cdc.gov/grasp/fluview/fluportaldashboard.html
# Accessed: 10/22/2020
# All states, from 2013-2014 - 2018-2019

d_dths <- readRDS(here::here('prj_dbdf', dta.names$f_rawrds[1])) %>%
  mutate_at(vars(starts_with('outc_dth')), as.numeric) %>%
  group_by(season, week) %>%
  summarize_at(vars(starts_with('outc_dth')), sum, na.rm=T) %>%
  mutate(outc_dth_perc_pi = (outc_dth_num_inf + outc_dth_num_pna) / outc_dth_tot) %>%
  select(-outc_dth_perc_comp) %>%
  ungroup()

d_ili <- readRDS(here::here('prj_dbdf', dta.names$f_rawrds[2])) %>%
  mutate_at(vars(starts_with('outc_')), as.numeric) %>%
  group_by(year, week) %>%
  summarize_at(vars(starts_with('outc_')), sum, na.rm=T) %>%
  mutate(prp_ili = outc_ili_totcases / outc_ili_totpats) %>%
  select(year, week, prp_ili) %>%
  mutate(season = case_when(
    40 <= week & week <= 53 ~ year,
    1 <= week & week <= 39 ~ year - 1),
         season = paste0(season, '-', substr(season+1, 3, 4))) %>%
  ungroup() %>%
  select(-year)
  
  
d_lab <- readRDS(here::here('prj_dbdf', dta.names$f_analysis[1])) %>%
  mutate(season = case_when(
    40 <= week & week <= 53 ~ year,
    1 <= week & week <= 39 ~ year - 1),
    season = paste0(season, '-', substr(season+1, 3, 4)))

simfile <- left_join(d_lab, d_dths, by=c('season', 'week')) %>%
  left_join(., d_ili, , by=c('season', 'week'))
  
simfile_2 <- simfile %>%
  select(-prp_ah1, -prp_aunk, -starts_with('prp_who')) %>%
  na.omit(.) %>%
  select(season, year, week, starts_with('prp'), starts_with('outc'))
  
saveRDS(simfile_2, here::here('prj_dbdf', dta.names$f_analysis[2]))
