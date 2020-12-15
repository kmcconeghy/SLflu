SL.steplm <- function(train, test) {

  X_trn_df <- train %>%
    select(-year, -season, -starts_with('outc_'), -starts_with('y'), outc_dth_tot)
  
  full_mod <- lm(outc_dth_tot ~ ., data=X_trn_df)
  step.model <- MASS::stepAIC(full_mod, direction = "backward", trace = FALSE)
  
  new_fit <- predict(step.model, newdata=test) %>% vctrs::vec_c(.)
  
  return(new_fit)
}