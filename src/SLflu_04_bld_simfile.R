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
  group_by(season) %>%
  mutate(week_2 = row_number()) %>%
  ungroup %>%
  dplyr::filter(season != '2018-19') %>%
  dplyr::filter(week_2 !=53) %>%
  select(-week) %>%
  rename(`week` = week_2) %>%
  select(season, year, `week`, starts_with('prp'), starts_with('outc')) %>%
  group_by(season) %>%
  mutate(across(starts_with('prp_'),
                .fns = list(lag_2 = ~lag(., 2)),
                .names = "{col}_{fn}")) %>%
  mutate(across(ends_with('lag_2'),
                .fns = list(lag_2 = ~lag(., 2)),
                .names = "{col}_{fn}")) %>%
  na.omit(.) %>%
  group_by(season) %>%
  mutate(week = row_number()) %>%
  ungroup %>%
  mutate(week_2 = week^2,
         week_3 = week^3,
         week_4 = week^4,
         frer_yr_sin = sinpi(2 * week / 52), 
         frer_yr_cos = cospi(2 * week / 52),
         frer_semiyr_sin = sinpi(2 * week / 26),
         frer_semiyr_sin = cospi(2 * week / 26),
         y = scale(outc_dth_tot, center=T),
         y_var = sd(outc_dth_tot - mean(outc_dth_tot)),
         y_2 = (y*y_var) + mean(outc_dth_tot)) %>%
  ungroup %>%
  na.omit(.)
  
saveRDS(simfile_2, here::here('prj_dbdf', dta.names$f_analysis[2]))
