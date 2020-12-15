library(splines)

d_full <- readRDS(here::here('prj_dbdf', dta.names$f_analysis[2])) 

d_cv <- readRDS(here::here('prj_dbdf', dta.names$f_cpt[1])) 

d_cv_2 <- d_cv %>% 
  mutate(mse.lmf = map2(train, test, ~SL.lmf(.x, .y)),
         SL.lmf = list(y = SL.lmf(d_full, d_full)),
         mse.lmpoly = map2(train, test, ~SL.lmpoly(.x, .y)),
         SL.lmpoly = list(y = SL.lmpoly(d_full, d_full)),
         mse.lmnspl = map2(train, test, ~SL.lmnspl(.x, .y)),
         SL.lmnspl = list(y = SL.lmnspl(d_full, d_full)),
         mse.steplm = map2(train, test, ~SL.steplm(.x, .y)),
         SL.steplm = list(y = SL.steplm(d_full, d_full)))

saveRDS(d_cv_2, here::here('prj_dbdf', dta.names$f_cpt[1])) 
