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
d_nrev_pre <- readRDS(here::here('prj_dbdf', dta.names$f_rawrds[3]))
d_nrev_pub <- readRDS(here::here('prj_dbdf', dta.names$f_rawrds[4]))
d_nrev_who <- readRDS(here::here('prj_dbdf', dta.names$f_rawrds[5]))
d_rsv <- readRDS(here::here('prj_dbdf', dta.names$f_rawrds[6]))

d_nrev_pre_nat <- d_nrev_pre %>%
  mutate_at(vars('TOTAL SPECIMENS',
            'PERCENT POSITIVE',
            starts_with('A'),
            starts_with('B')), as.numeric) %>%
  group_by(YEAR, WEEK) %>%
  summarize_at(vars('TOTAL SPECIMENS',
                    starts_with('A'),
                    starts_with('B')), sum, na.rm=T) %>%
  rename(tot_specs = `TOTAL SPECIMENS`,
         year = YEAR,
         week = WEEK) %>%
  mutate(prp_ah1n1 = `A (2009 H1N1)` / tot_specs,
         prp_ah3 = `A (H3)` / tot_specs,
         prp_ah1 = `A (H1)` / tot_specs,
         prp_b = B / tot_specs,
         prp_pos = prp_ah1n1 + prp_ah3 + prp_ah3 + prp_b) %>%
  select(year, week, starts_with('prp_'))

d_nrev_pub_nat <- d_nrev_pub %>%
  mutate_at(vars('TOTAL SPECIMENS',
                 starts_with('A'),
                 starts_with('B')), as.numeric) %>%
  rename(tot_specs = `TOTAL SPECIMENS`,
         year = YEAR,
         week = WEEK) %>%
  mutate(prp_ah1n1 = `A (2009 H1N1)` / tot_specs,
         prp_ah3 = `A (H3)` / tot_specs,
         prp_aunk = `A (Subtyping not Performed)` / tot_specs,
         prp_b = B / tot_specs,
         prp_pos = prp_ah1n1 + prp_ah3 + prp_aunk + prp_b) %>%
  select(year, week, starts_with('prp_'))

d_nrev_who_nat <- d_nrev_who %>%
  mutate_at(vars('TOTAL SPECIMENS', 'TOTAL A', 'TOTAL B'), 
            as.numeric) %>%
  group_by(YEAR, WEEK) %>%
  summarize_at(vars('TOTAL SPECIMENS',
                    'TOTAL A',
                    'TOTAL B'), sum, na.rm=T) %>%
  rename(year = YEAR,
         week = WEEK) %>%
  mutate(prp_whoa = `TOTAL A` / `TOTAL SPECIMENS`,
         prp_whob = `TOTAL B` / `TOTAL SPECIMENS`,
         prp_whopos = prp_whoa + prp_whob) %>%
  select(year, week, starts_with('prp_'))

d_rsv_nat <- d_rsv %>%
  mutate(date = as_date(RepWeekDate, format = '%m/%d/%Y')) %>%
  group_by(date) %>%
  summarize(tot_specs = sum(RSVtest),
            prp_rsv = sum(`RSV pos`) / tot_specs) %>%
  na.omit(.) %>%
  bind_cols(., MMWRweek::MMWRweek(.$date)) %>%
  rename(year = MMWRyear,
         week = MMWRweek) %>%
  select(year, week, prp_rsv)
  
  
df_lab <- bind_rows(d_nrev_pre_nat,
                    d_nrev_pub_nat,
                    .id = 'source') %>%
  left_join(., d_nrev_who_nat, by=c('year', 'week')) %>%
  left_join(., d_rsv_nat, by=c('year', 'week')) 

saveRDS(df_lab, here::here('prj_dbdf', dta.names$f_analysis[1]))
