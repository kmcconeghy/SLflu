
library(randomForest)

d_cv <- readRDS(here::here('prj_dbdf', dta.names$f_cpt[1])) 

d_cv_2 <- d_cv %>% 
  mutate(SL.rf_1 = map2(train, test,
                        ~SL.randomforest(.x, .y)),
         SL.rf_2 = map2(train, test, 
                        ~SL.randomforest(.x, .y, mtry=5, nodesize=10))) 

saveRDS(d_cv_2, here::here('prj_dbdf', dta.names$f_cpt[1])) 
