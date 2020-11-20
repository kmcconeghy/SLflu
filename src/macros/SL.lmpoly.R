SL.lmpoly <- function(train, test) {
  main.form <- 'outc_dth_tot ~ prp_ah1n1 + prp_ah3 + prp_b + prp_rsv + prp_ili +
                               + week_2 + week_3 + week_4'
  fit <- lm(as.formula(main.form), data=train)
  new_fit <- predict(fit, newdata=test) %>% vctrs::vec_c(.)
  
  return(new_fit)
}