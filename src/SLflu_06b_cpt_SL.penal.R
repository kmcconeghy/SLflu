
library(glmnet)  

d_cv <- readRDS(here::here('prj_dbdf', dta.names$f_cpt[1])) 

d_cv_2 <- d_cv %>% 
  mutate(SL.lasso = map2(train, test,
                    ~SL.penal(.x, .y, alpha=1)),
         SL.elasticnet = map2(train, test,
                         ~SL.penal(.x, .y, alpha=0.5))) 

saveRDS(d_cv_2, here::here('prj_dbdf', dta.names$f_cpt[1])) 
