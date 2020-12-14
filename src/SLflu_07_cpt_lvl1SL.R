d_preds <- readRDS(here::here('prj_dbdf', dta.names$f_cpt[2])) 

# Level-1-Model  
X <- d_preds %>%
  select(starts_with('SL')) %>%
  as.matrix(.)

Y <- d_preds %>% pull(outc_dth_tot)

nonnegls <- glmnet(X, Y, lambda = 0, lower.limits = 0, intercept = FALSE)
alpha <- coef(nonnegls)[-1, 1] #-1 to remove intercept

alpha <- alpha/sum(alpha)

# 
saveRDS(alpha, here::here('prj_dbdf', dta.names$f_cpt[3])) 

