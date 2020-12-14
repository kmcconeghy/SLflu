#--Project Set-up
  source(list.files(pattern='*cfg*'))

#-- Load data hierarchy  
  source(here::here('src', paste0(prj.specs$prj.prefix, '_lst_dtafiles.R')))

#-- dataset / munge  
  if (F) source(here::here('src', paste0(prj.specs$prj.prefix, '_01_inp_fludta.R')))
  if (F) source(here::here('src', paste0(prj.specs$prj.prefix, '_02_inp_labdta.R')))
  if (F) source(here::here('src', paste0(prj.specs$prj.prefix, '_03_bld_labdta.R')))
  if (F) source(here::here('src', paste0(prj.specs$prj.prefix, '_04_bld_simfile.R')))

#-- Analysis  
  if (T) source(here::here('src', paste0(prj.specs$prj.prefix, '_05_cpt_CV.R')))
  if (T) source(here::here('src', paste0(prj.specs$prj.prefix, '_06a_cpt_SL.lm.R')))
  if (T) source(here::here('src', paste0(prj.specs$prj.prefix, '_06b_cpt_SL.penal.R')))
  if (T) source(here::here('src', paste0(prj.specs$prj.prefix, '_06c_cpt_SL.rf.R')))
  if (T) source(here::here('src', paste0(prj.specs$prj.prefix, '_06d_cpt_SL.gam.R')))
  if (T) source(here::here('src', paste0(prj.specs$prj.prefix, '_07_cpt_lvl1SL.R')))
  if (T) source(here::here('src', paste0(prj.specs$prj.prefix, '_08_cpt_wtpreds.R')))
  if (T) source(here::here('src', paste0(prj.specs$prj.prefix, '_09_bld_risk.R')))
  
#-- Report
  if (T) render_one('10_rpt_manu1', here::here('src'), here::here('output'))
  

cat(paste0('Project Run: ', prj.RunTime %--% Sys.time()))

#End project