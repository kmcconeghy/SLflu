#---------------------------------------------------------#
# 
# Project: SuperLearn Modeling
# File to Insheet data
# Programmer: Kevin McConeghy
# Start: 10/22/2020
# 
#--------------------------------------------------------#
source(list.files(pattern='*cfg*'))
source(here::here('src', paste0(prj.specs$prj.prefix, '_lst_dtafiles.R')))

# Obtained from https://gis.cdc.gov/grasp/fluview/mortality.html
# Accessed: 10/22/2020
# All states, from 2013-2014 - 2018-2019
df_fludths <- read_csv(here('prj_dbdf', dta.names$f_raw[1])) %>%
  rename(state = `SUB AREA`,
         season = SEASON,
         week = WEEK,
         outc_dth_perc_pi = `PERCENT P&I`,
         outc_dth_num_inf = `NUM INFLUENZA DEATHS`,
         outc_dth_num_pna = `NUM PNEUMONIA DEATHS`,
         outc_dth_tot = `TOTAL DEATHS`,
         outc_dth_perc_comp = `PERCENT COMPLETE`) %>%
  select(-AREA, -`AGE GROUP`) %>%
  mutate(state_abb = state.abb[match(state, state.name)])
saveRDS(df_fludths, here::here('prj_dbdf', dta.names$f_rawrds[1]))

df_ilinet <- read_csv(here('prj_dbdf', dta.names$f_raw[2])) %>%
  rename(state = `REGION`,
         year = YEAR,
         week = WEEK,
         outc_ili_wt = `% WEIGHTED ILI`,
         outc_ili_nowt = `%UNWEIGHTED ILI`,
         outc_ili_totcases = `ILITOTAL`,
         outc_ili_totpats = `TOTAL PATIENTS`) %>%
  select(state, year, week, starts_with('outc_')) %>%
  mutate(state_abb = state.abb[match(state, state.name)])
saveRDS(df_ilinet, here::here('prj_dbdf', dta.names$f_rawrds[2]))