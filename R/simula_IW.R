#' Generates random draws from inverse-Wishart distribution
#' @usage simula_IW(n, d, R)
#' @export
#' @param n number of observations
#' @param nu degrees of freedom 
#' @param R positive definite matrix
#' 
simula_IW <- function(n, nu=3, R=diag(2) ) { 
  rstan::sampling(object = stanmodels$IWprSim, data = list(nu = nu, R=R, d = ncol(R)), iter = n, chains = 1)
  
   }

