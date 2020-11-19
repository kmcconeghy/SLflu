

d_anls <- readRDS(here::here('prj_dbdf', dta.names$f_analysis[2])) 

## Split by seeson  

n_samps <- n_distinct(d_anls$season)
units <- unique(d_anls$season)

for (i in 1:n_samps) {
  assign(paste0('train_', i), d_anls[d_anls$season != units[i], ])
  assign(paste0('test_', i), d_anls[d_anls$season == units[i], ])
}

d_train <- bind_rows(train_1, train_2, train_3, train_4, train_5, .id='set') %>%
  group_by(set) %>%
  nest() %>%
  ungroup() %>%
  rename(train = data)

d_test <- bind_rows(test_1, test_2, test_3, test_4, test_5, .id='set') %>%
  group_by(set) %>%
  nest() %>%
  ungroup() %>%
  rename(test = data)

d_cv <- inner_join(d_train, d_test, by='set')

d_cv <- saveRDS(here::here('prj_dbdf', dta.names$f_cpt_list[1])) 

