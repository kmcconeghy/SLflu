
d_cv <- readRDS(here::here('prj_dbdf', dta.names$f_cpt[1])) 

d_cv_2 <- d_cv %>% 
  mutate(SL.lmf = map2(train, test,
                    ~SL.lmf(.x, .y))) 

d_cv_3 <- d_cv_2 %>% 
  mutate(SL.lmpoly = map2(train, test,
                       ~SL.lmpoly(.x, .y)))  

saveRDS(d_cv_3, here::here('prj_dbdf', dta.names$f_cpt[1])) 
