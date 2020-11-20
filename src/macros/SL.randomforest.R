SL.randomforest <- function(train, test) {
  X_trn_df <- train %>%
    select(-year, -season, -starts_with('outc_'), outc_dth_tot)
  
  X_tst_df <- test %>%
    select(-year, -season, -starts_with('outc_'), outc_dth_tot)
  
  X_mat <- model.matrix(outc_dth_tot ~ ., data=X_trn_df) %>% .[, -1]
  
  fit <- randomForest(
    outc_dth_tot ~ .,
    data=X_trn_df,
    ntree=2000,
  )
  
  y_pred <- predict(fit, newdata = X_tst_df, type = "response")
  
  return(y_pred)
}