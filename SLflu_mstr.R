#--Project Set-up
  source(list.files(pattern='*cfg*'))

#-- Load data hierarchy  
  source(here::here('src', paste0(prj.specs$prj.prefix, '_lst_dtafiles.R')))

#-- dataset / munge  
  if (F) source(here::here('src', paste0(prj.specs$prj.prefix, '_01_inp_fludta.R')))
  if (F) source(here::here('src', paste0(prj.specs$prj.prefix, '_02_inp_labdta.R')))
  if (F) source(here::here('src', paste0(prj.specs$prj.prefix, '_03_bld_labdta.R')))
  if (T) source(here::here('src', paste0(prj.specs$prj.prefix, '_04_bld_simfile.R')))

#-- Analysis  
  if (T) source(here::here('src', paste0(prj.specs$prj.prefix, '_05_cpt_benchmrks.R')))
  
  #-- Randomizations  
  if (T) source(here::here('src', paste0(prj.specs$prj.prefix, '_bld_01_dorandom.R')))
  

cat(paste0('Project Run: ', prj.RunTime %--% Sys.time()))

#End project