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

# Obtained from https://gis.cdc.gov/grasp/fluview/fluportaldashboard.html
# Accessed: 10/22/2020
# All states, from 2013-2014 - 2018-2019
df_nrevss_pre <- read_csv(here('prj_dbdf', dta.names$f_raw[3]))
df_nrevss_pub <- read_csv(here('prj_dbdf', dta.names$f_raw[4]))
df_nrevss_who <- read_csv(here('prj_dbdf', dta.names$f_raw[5]))
df_rsv <- read_csv(here('prj_dbdf', dta.names$f_raw[6]))

saveRDS(df_nrevss_pre, here::here('prj_dbdf', dta.names$f_rawrds[3]))
saveRDS(df_nrevss_pub, here::here('prj_dbdf', dta.names$f_rawrds[4]))
saveRDS(df_nrevss_who, here::here('prj_dbdf', dta.names$f_rawrds[5]))
saveRDS(df_rsv, here::here('prj_dbdf', dta.names$f_rawrds[6]))
