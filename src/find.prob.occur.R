# This function will calculate probability of occurrence of vegetation guilds/species from EP
# Last edited by Elaina Passero on 12/11/19 - Adapted for WR 674 project

find.prob.occur <- function(hydro_ep,v,one_veg_logit){
  
  nums <- seq(1:(length(one_veg_logit[[1]])-1))
  vars <- paste("B",(nums-1),sep="")
  for(i in 1:length(nums)){
    assign(vars[i],as.numeric(one_veg_logit[i+1,])) 
  }
  
  # create list of variables and their values
  var_vals <- list()
  for(i in 1:length(nums)){
    var_vals[[i]] <- as.numeric(one_veg_logit[i+1,]) # each variable becomes its own object
  }
  names(var_vals) <- vars
  
  eqn <- one_veg_logit[1,1] # extract equation from table
  for(i in 1:length(vars)){eqn <- gsub(vars[i],var_vals[i],eqn)} # add coefficients to eqn
  
  # evaluate the equation at each EP value
  for(i in 1:length(hydro_ep$EP)){
    x <- hydro_ep$EP[i]
    eqn_x <- gsub("*x",paste("*",x,sep=""),eqn,fixed=TRUE) # replaces x with EP value
    hydro_ep$prob_v[i] <- eval(parse(text=eqn_x))
  }
  return(hydro_ep)
}