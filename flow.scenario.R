# This function generates flow scenarios from historic flow record
# Last edited by Elaina Passero on 10/24/19

flow.scenario <- function(hydrograph,enforce_med,median_q,withdrawal,per_red){
  if(withdrawal > 0){ # fixed withdrawal
    if(enforce_med == "Yes"){
      for(r in 1:length(hydrograph$date)){
        if(hydrograph$discharge[[r]] > median_q){
          hydrograph$revised_q[[r]] <- hydrograph$discharge[[r]]-withdrawal
        } else{
          hydrograph$revised_q[[r]] <- hydrograph$discharge[[r]]
        }
      }
    } else{
      hydrograph$revised_q <- hydrograph$discharge-withdrawal
    }
  }
  
  if(per_red > 0){ # percent withdrawal
    if(enforce_med == "Yes"){
      for(s in 1:length(hydrograph$date)){
        if(hydrograph$discharge[[s]] > median_q){
          hydrograph$revised_q[[s]] <- hydrograph$discharge[[s]]*(1-per_red)
        } else{
          hydrograph$revised_q[[s]] <- hydrograph$discharge[[s]]
        }
      }
    } else{
      hydrograph$revised_q <- hydrograph$discharge*(1-per_red)
    }
  }
  
  hydrograph <- hydrograph %>%
    select(-discharge) %>%
    rename(discharge = revised_q)
  
return(hydrograph)
}



