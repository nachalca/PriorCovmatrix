#' Generates random draws from scaled inverse-Wishart distribution
#' @usage simula_SIW(n, d, R)
#' @export
#' @param n number of observations
#' @param nu degrees of freedom 
#' @param d matrix dimension
#' @param xi common standard deviation of marginal variances
#' @useDynLib PriorCovmatrix, .registration = TRUE 
#' 
simula_SIW <- function(n, d=2, nu=NULL, xi=1 ) { 
  if ( length(nu) ==0 ) nu <- d+1 
  rstan::sampling(object = stanmodels$sIWprSim, data = list(d=d, nu = nu,xi=xi, R=diag(d) ), pars='Sig_siw', iter = n, chains = 1)
}
