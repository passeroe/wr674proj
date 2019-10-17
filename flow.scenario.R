# This function generates flow scenarios from historic flow record
# Last edited by Elaina Passero on 10/17/19

flow.scenario <- function(hydrograph,enforce_med,per_red,median_q,withdrawal){
  if(withdrawal > 0){ # fixed withdrawal
    if(enforceMed == "Yes"){
      for(r in 1:length(hydrograph$date)){
        if(hydrograph$discharge[[r]] > medianQ){
          hydrograph$medERevQ[[r]] <- hydrograph$discharge[[r]]-withdrawal
        } else{
          hydrograph$medERevQ[[r]] <- hydrograph$discharge[[r]]
        }
      }
    } else{
      hydrograph$subQ <- hydrograph$discharge-withdrawal
    }
  }
  
  if(per_red > 0){ # percent withdrawal
    if(enforceMed == "Yes"){
      for(s in 1:length(hydrograph$date)){
        if(hydrograph$discharge[[s]] > medianQ){
          hydrograph$revisedQ[[s]] <- hydrograph$discharge[[s]]*(1-perRed)
        } else{
          hydrograph$revisedQ[[s]] <- hydrograph$discharge[[s]]
        }
      }
    } else{
      hydrograph$revisedQ <- hydrograph$discharge*(1-perRed)
    }
  }
  
}



