data {
  int<lower=0> N;  // Number of observations
  real<lower=0> distance[N];  // Delivery distance in km
  real<lower=0> meal_preparation_time[N];  // Meal preparation time in minutes
}

generated quantities {
  real mu_travel;  // Mean for travel time
  real<lower=0> mu_prep;  // Mean for meal preparation time
  real<lower=0> delivery_time[N];  // Predicted delivery time in minutes

  // Sampling from priors
  mu_travel = normal_rng(0, 0.5);
  mu_prep = gamma_rng(3, 1);

  // Generating predicted delivery time
  for (i in 1:N) {
    real travel_time = normal_rng(mu_travel*distance[i], 3);
    delivery_time[i] = travel_time + mu_prep + meal_preparation_time[i];
  }
}
