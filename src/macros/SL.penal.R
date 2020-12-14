SL.penal <- function(train, test, alpha) {
  y_trn <- train['outc_dth_tot'] %>% unlist()
  y_tst <- test['outc_dth_tot'] %>% unlist()
  
  X_trn_df <- train %>%
    select(-year, -season, -starts_with('outc_'), -starts_with('y'), outc_dth_tot)
  
  X_tst_df <- test %>%
    select(-year, -season, -starts_with('outc_'), -starts_with('y'), outc_dth_tot)
  
  X_mat <- model.matrix(outc_dth_tot ~ ., data=X_trn_df) %>% .[, -1]
  
  fit <- glmnet(X_mat, y_trn, alpha=alpha, nlambda=200)
  
  coef = coef(fit)
  lambda = fit$lambda
  df = fit$df
  n <- length(y_tst) 
  
  newX_mat <- model.matrix(outc_dth_tot ~ ., data=X_tst_df) %>% .[, -1]
  
  y_pred <- predict(fit, newx = newX_mat, type = "response")
  
  residuals = (y_tst- y_pred)
  mse = colMeans(residuals^2)
  sse = colSums(residuals^2)
  
  nvar = df + 1
  aic = n*log(mse)+2*nvar
  aicc = aic+(2*nvar*(nvar+1))/(n-nvar-1)
  
  selected=best.model = which(aicc == min(aicc))
  
  rtn_y_pred <- predict(fit, newx = newX_mat, s = selected, type = "response")
  
  return(rtn_y_pred)
}