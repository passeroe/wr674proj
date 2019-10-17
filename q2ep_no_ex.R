# This function will calculate EP for modeled and historic flows. This function cannot extrapolate EP values.

enforce_med <- "Yes"
per_red <- 0.20 # percent flow reduction set to 0 if adding withdrawal
median_q <- 160 # median flow value - could use monthly or annual
withdrawal <- 5 # set to 0 if doing percent flow reduction


# read in historical flow record
historic_q <- na.omit(fread(paste(wd,reachName,"_hydrograph",".csv",sep=""),header=TRUE, sep = ",",data.table=FALSE))
historic_q$date <- as.Date(historic_q$date, format="%m/%d/%Y")

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