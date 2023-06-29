data{
    int N;                          // Number of samples
    vector[N] distance;             // Distances
    vector[N] meal_preparation_time; // Meal preparation times
    vector[N] delivery_times;       // Delivery times
    array[N] int traffic_level;           // Traffic levels
}

parameters{
    real distance_coeff;
    vector[4] traffic_level_coeff;
    real meal_prep_coeff;
    real<lower=0> sigma;
}

transformed parameters {
    vector[N] mu;
    for(i in 1:N){
        mu[i] = exp(distance_coeff * distance[i] + traffic_level_coeff[traffic_level[i]] + meal_prep_coeff * meal_preparation_time[i]+3);
    }

}

model{
    distance_coeff ~ normal(0,0.3);
    meal_prep_coeff ~ normal(0,0.3);
    sigma ~ exponential(0.5);
    delivery_times ~ inv_gamma(pow(mu, 2) / pow(sigma, 2) + 2, pow(mu,3) / pow(sigma, 2) + mu);
    // delivery_times ~ normal(mu, sigma);
    traffic_level_coeff[1] ~ normal(0, 0.3);
    traffic_level_coeff[2] ~ normal(0, 0.3);
    traffic_level_coeff[3] ~ normal(0, 0.3);
    traffic_level_coeff[4] ~ normal(0, 0.3);
}

generated quantities {
    vector[N] delivery_time;
    vector[N] exp_argument;
    vector[N] exp_argument_withMeal;
    vector[N] log_lik;
    for (i in 1:N){
        delivery_time[i] = inv_gamma_rng(pow(mu[i], 2) / pow(sigma, 2) + 2, pow(mu[i],3) / pow(sigma, 2) + mu[i]);
        log_lik[i] = inv_gamma_lpdf(delivery_times[i] | pow(mu[i], 2) / pow(sigma, 2) + 2, pow(mu[i],3) / pow(sigma, 2) + mu[i]);
        // delivery_time[i] = normal_rng(mu[i], sigma);
        exp_argument_withMeal[i] = distance_coeff * distance[i] + traffic_level_coeff[traffic_level[i]] + meal_prep_coeff * meal_preparation_time[i]+3;
        // exp_argument[i] = distance_coeff * distance[i] + traffic_level_coeff[traffic_level[i]];
    }
}