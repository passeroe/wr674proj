# This script will make maps of probability of occurrence of vegetation guilds/species
# Last edited by Elaina Passero on 12/11/19 - adapted for WR 674 project

make.veg.maps <- function(hydro_ep_prob,ep_map,v){
  
  # build matrix for reclassification
  rcl_ep <- data.frame(from = c(hydro_ep_prob$EP[-1],0),
                       to = hydro_ep_prob$EP,
                       becomes = hydro_ep_prob$prob_v) %>%
    as.matrix(.)
  
  # reclassify raster
  prob_veg_map <- reclassify(ep_map, rcl_ep, right = TRUE)
  
  
  return(prob_veg_map) 
}
