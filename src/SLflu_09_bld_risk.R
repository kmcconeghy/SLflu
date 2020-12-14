
d_preds <- readRDS(here::here('prj_dbdf', dta.names$f_cpt[4])) 

d_preds_2 <- d_preds %>%
  select(set, outc_dth_tot, starts_with('SL')) %>%
  group_by(set) %>%
  unnest(cols = everything())

mse_mods <-  d_preds_2 %>%
  mutate_at(vars(starts_with('SL')), list(~(outc_dth_tot - .)^2)) %>%
  group_by(set) %>%
  summarize_all(mean) %>%
  ungroup() %>%
  select(-set, -outc_dth_tot) %>%
  summarize_all(mean)

saveRDS(mse_mods, here::here('prj_dbdf', dta.names$f_cpt[5])) 