
library(mgcv)

d_cv <- readRDS(here::here('prj_dbdf', dta.names$f_cpt[1])) 

d_cv_2 <- d_cv %>% 
  mutate(SL.gam = map2(train, test,
                    ~SL.gam(.x, .y))) 

saveRDS(d_cv_2, here::here('prj_dbdf', dta.names$f_cpt[1])) 
