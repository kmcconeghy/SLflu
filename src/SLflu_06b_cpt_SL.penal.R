
library(glmnet)  

d_full <- readRDS(here::here('prj_dbdf', dta.names$f_analysis[2])) 

d_cv <- readRDS(here::here('prj_dbdf', dta.names$f_cpt[1])) 

d_cv_2 <- d_cv %>% 
  mutate(mse.lasso = map2(train, test, ~SL.penal(.x, .y, alpha=1)),
         SL.lasso = list(y = SL.penal(d_full, d_full, alpha=1)),
         mse.elasticnet = map2(train, test, ~SL.penal(.x, .y, alpha=0.5)),
         SL.elasticnet = list(y = SL.penal(d_full, d_full, alpha=0.5)),
         mse.ridge = map2(train, test, ~SL.penal(.x, .y, alpha=0)),
         SL.ridge = list(y = SL.penal(d_full, d_full, alpha=0))) 

saveRDS(d_cv_2, here::here('prj_dbdf', dta.names$f_cpt[1])) 
