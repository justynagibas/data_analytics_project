data{
    int N;                          // Number of samples
    vector[N] distance;             // Distances
    vector[N] meal_preparation_time; // Meal preparation times
    vector[N] delivery_times;       // Delivery times
    array[N] int traffic_level;           // Traffic levels
}

parameters{
    real distance_coeff_raw;
    vector[4] traffic_level_coeff;
    real <lower=1>meal_prep_coeff;
    real<lower=0> sigma;
}

transformed parameters {
    real distance_coeff;
    distance_coeff = fabs(distance_coeff_raw);
    vector[N] mu;
    for(i in 1:N){
        mu[i] = exp(distance_coeff * distance[i] + traffic_level_coeff[traffic_level[i]]) + meal_prep_coeff * meal_preparation_time[i];
    }

}

model{
    distance_coeff_raw ~ normal(3,0.2);
    meal_prep_coeff ~ normal(1.2,0.3);
    sigma ~ exponential(2);
    delivery_times ~ inv_gamma(pow(mu, 2) / pow(sigma, 2), mu / pow(sigma, 2));
    // delivery_times ~ normal(mu, sigma);
    traffic_level_coeff[1] ~ normal(1.5, 0.3);
    traffic_level_coeff[2] ~ normal(1.0, 0.2);
    traffic_level_coeff[3] ~ normal(0.5, 0.1);
    traffic_level_coeff[4] ~ normal(0.3, 0.05);
}

generated quantities {
    vector[N] delivery_time;
    vector[N] exp_argument;
    vector[N] exp_argument_withMeal;
    for (i in 1:N){
        delivery_time[i] = inv_gamma_rng(pow(mu[i], 2) / pow(sigma, 2), mu[i] / pow(sigma, 2));
        // delivery_time[i] = normal_rng(mu[i], sigma);
        exp_argument_withMeal[i] = distance_coeff * distance[i] + traffic_level_coeff[traffic_level[i]] + meal_prep_coeff * meal_preparation_time[i];
        exp_argument[i] = distance_coeff * distance[i] + traffic_level_coeff[traffic_level[i]];
    }
}