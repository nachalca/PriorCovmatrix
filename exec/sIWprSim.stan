// scaled IW: sIW(xi, d)
data {
  int <lower=0> d;
  real <lower=0> xi;
  real <lower=0> nu;
  matrix[d,d] R;
}
parameters {
  vector<lower=0>[d] delta;
  cov_matrix[d] sQ;
}
transformed parameters {
  matrix[d,d] D;
  matrix[d,d] Sig_siw; 

  for (i in 1:d) {
    D[i,i] =  sqrt( delta[i] );
  }

    Sig_siw = D * sQ * D;
}
model {
  for ( i in 1:d ) delta[i] ~ lognormal(0, pow(xi,2) ); // prior for sd on sIW prior
  sQ ~ inv_wishart(nu, .8*R); //   sIW prior
}
