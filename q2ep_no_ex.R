# This function will calculate EP for modeled and historic flows. 
# This function cannot extrapolate EP values.

# load flow scenario
hydrograph <- flow.scenario(hydrograph,enforce_med,per_red,median_q,withdrawal) 


if(FlowScenario == "Yes"){
  hydrograph <- historic_q
} else{
  hydrograph <- scenario_q
}
  
# calculate exceedence probability
hydroEP <- data.frame(discharge = hydrograph$discharge,rank=rank(-hydrograph$discharge,ties.method = "min")) # ranks discharges; same values get same ranks
n <- as.numeric(length(hydroEP$discharge))
hydroEP$EP <- hydroEP$rank/(1+n)