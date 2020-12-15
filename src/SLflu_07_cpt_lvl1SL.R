d_full <- readRDS(here::here('prj_dbdf', dta.names$f_analysis[2])) 

d_rawpreds <- readRDS(here::here('prj_dbdf', dta.names$f_cpt[1])) 

d_y_sl <- d_full %>%
  select(outc_dth_tot) %>%
  pull()

d_preds_sl <- d_rawpreds %>%
  select(-train, -test, -starts_with('mse'), -set) %>%
  slice(1) %>%
  unnest(cols = everything()) %>%
  ungroup %>%
  bind_cols(y_sl = d_y_sl, .)

d_y_mse <- d_rawpreds %>%
  select(test, set) %>%
  unnest(cols=everything()) %>%
  pull(outc_dth_tot)
  
d_preds_cv <- d_rawpreds %>%
  select(-train, test, starts_with('mse'), -starts_with('SL.'), set) %>%
  unnest(cols = everything()) %>%
  ungroup %>%
  select(starts_with('mse')) %>%
  bind_cols(y_mse = d_y_mse, .)

d_preds <- bind_cols(d_preds_sl, d_preds_cv)

saveRDS(d_preds, here::here('prj_dbdf', dta.names$f_cpt[2])) 

# Level-1-Model  
X <- d_preds %>%
  select(starts_with('SL')) %>%
  as.matrix(.)

Y <- d_preds %>% pull(y_sl)

#Non-negative least squares with no intercept
nonnegls <- glmnet(X, Y, lambda = 0, lower.limits = 0, intercept = FALSE)
alpha <- coef(nonnegls)[-1, 1] #-1 to remove intercept

# normalize
alpha <- alpha/sum(alpha)

# SL weights
saveRDS(alpha, here::here('prj_dbdf', dta.names$f_cpt[3])) 

sl_wtd <- d_preds %>%
  select(starts_with('SL')) %>%
  as.matrix(.)

mse_wtd <- d_preds %>%
  select(starts_with('mse')) %>%
  as.matrix(.)

#add SuperLearner  
d_preds$SL.SL <- mse_wtd %*% alpha
d_preds$mse.SL <- sl_wtd %*% alpha  

saveRDS(d_preds, here::here('prj_dbdf', dta.names$f_cpt[4]))  

