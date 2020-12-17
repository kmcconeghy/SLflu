
d_preds <- readRDS(here::here('prj_dbdf', dta.names$f_cpt[4])) 

mse_mods <-  d_preds %>%
  select(-y_sl, starts_with('mse'), -starts_with('SL')) %>%
  mutate_at(vars(starts_with('mse')), list(~(y_mse - .)^2)) %>%
  select(-y_mse) %>%
  summarize_all(mean) %>%
  pivot_longer(cols = everything(),
               names_to = 'learner',
               values_to = 'mse')

saveRDS(mse_mods, here::here('prj_dbdf', dta.names$f_cpt[5])) 

sl_mods <-  d_preds %>%
  select(-y_mse, starts_with('SL'), -starts_with('mse')) %>%
  mutate_at(vars(starts_with('SL')), list(~(y_sl - .)^2)) %>%
  select(-y_sl) %>%
  summarize_all(mean) %>%
  pivot_longer(cols = everything(),
               names_to = 'learner',
               values_to = 'mse')

saveRDS(mse_mods, here::here('prj_dbdf', dta.names$f_cpt[5])) 