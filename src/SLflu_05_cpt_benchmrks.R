#---------------------------------------------------------#
# 
# Project: SuperLearn Modeling
# Take simulation file and compute benchmarks 
# Programmer: Kevin McConeghy
# Start: 11/18/2020
# 
#--------------------------------------------------------#

d_anls <- readRDS(here::here('prj_dbdf', dta.names$f_analysis[2])) 

d_2 <- d_anls %>%
  group_by(season) %>%
  summarize(outc_dth_peak = week[which(outc_dth_tot == max(outc_dth_tot))],
            outc_dth_sum = sum(outc_dth_tot),
            outc_dth_mean = mean(outc_dth_tot))

  
saveRDS(d_2, here::here('prj_dbdf', dta.names$f_cpt[1]))
