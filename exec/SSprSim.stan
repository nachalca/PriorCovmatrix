// SS: separation strategy with IW and logNormal, SS[IW(d, R) x LN(0, s0)];
data {
  int <lower=0> N;
  int <lower=0> k;
  real<lower=0> s0;
  matrix[k,k] R;
}
parameters {
//  vector[k] mu;
  cov_matrix[k] Q1;
  vector[k] xi;
}
transformed parameters {
// Rho is the correlation matrix prior, start with a Q1 ~ IW() and its transformed into
// a correlation matrix with D1*Q1*D1, wehre D1=diag(delta1), is done with for loops
  matrix[k,k] L;
  corr_matrix[k] Rho; 
  cov_matrix[k] Sigma;
  vector<lower=0>[k] delta;
  vector<lower=0>[k] delta1;

  for (i in 1:k) delta1[i] = 1/sqrt(Q1[i,i]);

  for (n in 1:k) {
    for (m in 1:n) {
      Rho[m,n] = delta1[m] * delta1[n] * Q1[m,n]; 
    }
  }

  for (n in 1:k) {
     for (m in (n+1):k) {
        Rho[m,n] = Rho[n,m];
     }
  } 

// compute covariance matrix as: Sigma = D*Q*D, where D = diag(delta) ;
  for (i in 1:k)  delta[i] = exp( xi[i] );
  for (n in 1:k) {
    for (m in 1:n) {
      Sigma[m,n] = delta[m] * delta[n] * Rho[m,n]; 
    }
  }
   for (n in 1:k) {
     for (m in (n+1):k) {
        Sigma[m,n] = Sigma[n,m];
     }
   }
}
model {
  Q1 ~ inv_wishart(k+1, R);
  for ( i in 1:k) {
      xi[i] ~ normal(0, log(s0) );
  }
}
