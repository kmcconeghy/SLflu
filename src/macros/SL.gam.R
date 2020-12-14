SL.gam <- function(train, test) {
  
  X_trn_df <- train %>%
    select(-year, -season, 
           -starts_with('outc_'), 
           -starts_with('y'),  
           -starts_with('frer_'),
           -starts_with('week_'), 
           outc_dth_tot)
  
  X_tst_df <- test %>%
    select(-year, -season, 
           -starts_with('outc_'), 
           -starts_with('y'), 
           -starts_with('frer_'),
           -starts_with('week_'), 
           outc_dth_tot)
  
  y_trn <- X_trn_df['outc_dth_tot'] %>% unlist()
  y_tst <- X_tst_df['outc_dth_tot'] %>% unlist()
  
  X_mat <- model.matrix(outc_dth_tot ~ ., data=X_trn_df) %>% .[, -1]
  
  fit <- gamsel::gamsel(X_mat, y_trn)  
  
  lambda = fit$lambda
  n <- length(y_tst) 
  
  newX_mat <- model.matrix(outc_dth_tot ~ ., data=X_tst_df) %>% .[, -1]
  
  y_pred <- predict(fit, newdata = newX_mat, type = "response")
  
  residuals = (y_tst- y_pred)
  mse = colMeans(residuals^2)
  sse = colSums(residuals^2)
  df = colSums(fit[['betas']]>0)
  nvar = df + 1
  aic = n*log(mse)+2*nvar
  aicc = aic+(2*nvar*(nvar+1))/(n-nvar-1)
  
  selected=best.model = which(aicc == min(aicc))
  
  rtn_y_pred <- predict(fit, newdata = newX_mat, index = selected, type = "response")
  
  return(rtn_y_pred)
}