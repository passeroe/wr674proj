# This function pulls riparian vegetation logistic regression equations for a single group
# Last edited by Elaina Passero on 12/11/19 - Adapted for WR 674 project

find.veg.logit <- function(logit_eqns,v){
  col_num <- grep(v,names(logit_eqns),ignore.case = TRUE)
  titles <- names(logit_eqns)
  one_veg_logit <- logit_eqns[col_num]
  return(one_veg_logit)
}
