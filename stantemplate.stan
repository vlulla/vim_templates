functions {
  // ... function declarations and definitions ...
}
data {
  int<lower=0> N; // num data items
  int<lower=0> K; // num predictors
  matrix[N, K] x; // predictor matrix
  vector[N] y;    // outcome/targeg
}
transformed data {
  // ... delcarations ... statements ...
}
parameters {
  real alpha;  // intercept
  vector[K] beta; // coefficients for predictors
  real<lower=0> sigma; // error scale
}
transformed parameters {
  // ... delcarations ... statements ...
}
model {
  y ~ normal(alpha + beta * x, sigma); // likelihood
}
generated quantities {
  // ... declarations ... statements ...
}

