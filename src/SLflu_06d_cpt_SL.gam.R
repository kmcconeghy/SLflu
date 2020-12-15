
library(gamsel)
d_full <- readRDS(here::here('prj_dbdf', dta.names$f_analysis[2])) 

d_cv <- readRDS(here::here('prj_dbdf', dta.names$f_cpt[1])) 

d_cv_2 <- d_cv %>% 
  mutate(mse.gam = map2(train, test, ~SL.gam(.x, .y)),
         SL.gam = list(y = SL.gam(d_full, d_full))) 

saveRDS(d_cv_2, here::here('prj_dbdf', dta.names$f_cpt[1])) 
