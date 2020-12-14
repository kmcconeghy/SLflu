d_preds <- readRDS(here::here('prj_dbdf', dta.names$f_cpt[2]))  

sl_wts <- readRDS(here::here('prj_dbdf', dta.names$f_cpt[3]))  

y_sl <- d_preds %>%
  select(starts_with('SL')) %>%
  as.matrix(.)

sl_wtd <- y_sl %*% alpha

d_preds$SL.SL <- sl_wtd  

saveRDS(d_preds, here::here('prj_dbdf', dta.names$f_cpt[4]))  
