SL.gam <- function(train, test) {
  main.form <- 'outc_dth_tot ~ s(prp_ah1n1) + s(prp_ah3) + s(prp_b) + s(prp_rsv) + prp_ili +
                               + s(week)'
  fit <- gam(as.formula(main.form), data = train)  
  y_pred <- predict(fit, newdata=test, type='response') %>% vctrs::vec_c(.)
  
  return(y_pred)
}