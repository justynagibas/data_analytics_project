data{
    int N;                          // Number of samples
    vector[N] distance;             // Distances
    vector[N] meal_preparation_time; // Meal preparation times
    vector[N] delivery_times;       // Delivery times
    array[N] int traffic_level;           // Traffic levels
}

parameters{
    real<lower=-0.3, upper=0.3> distance_coeff_raw;
    vector<lower=0.01, upper=0.1>[4] traffic_level_coeff;
    real<lower=0.01, upper=0.08> meal_prep_coeff;
    real<lower=0, upper=1.5> sigma;
    // vector<lower=0, upper=40>[N] travel_time;
}

transformed parameters {
    real<lower=0, upper=0.3> distance_coeff;
    distance_coeff = fabs(distance_coeff_raw);
    vector<lower=0, upper=90>[N] mu;
    for(i in 1:N){
        mu[i] = exp(distance_coeff * distance[i] + traffic_level_coeff[traffic_level[i]] + meal_prep_coeff * meal_preparation_time[i]);
    }

}

model{
    distance_coeff_raw ~ normal(0.1,0.01);
    meal_prep_coeff ~ normal(0.05,0.002);
    sigma ~ exponential(1);
    delivery_times ~ gamma(pow(mu, 2) / pow(sigma, 2), mu / pow(sigma, 2));
    traffic_level_coeff[1] ~ normal(0.08, 0.01);
    traffic_level_coeff[2] ~ normal(0.05, 0.01);
    traffic_level_coeff[3] ~ normal(0.05, 0.01);
    traffic_level_coeff[4] ~ normal(0.08, 0.01);

    // travel_time ~ exponential(distance_coeff * distance + traffic_level_coeff[traffic_level]);
}

generated quantities {
    vector[N] delivery_time;
    vector[N] exp_argument;
    for (i in 1:N){
        delivery_time[i] = gamma_rng(pow(mu[i], 2) / pow(sigma, 2), mu[i] / pow(sigma, 2));
        exp_argument[i] = distance_coeff * distance[i] + traffic_level_coeff[traffic_level[i]] + meal_prep_coeff * meal_preparation_time[i];
    }
}


// data{
//     int N; # no of samples
//     real distance[N];   # distances
//     real meal_preparation_time[N];
//     real delivery_times[N];
//     int traffic_level[N];
// }

// parameters{
//     real<lower=0> distance_coeff;
//     real traffic_level_coeff[N];
//     real meal_prep_coeff;
//     real sigma;
//     real travel_time[N];
// }

// transformed parameters {
//     real mu[N];
//     for (i in 1:N){
//         mu[i] = travel_time[i]+meal_prep_coeff*meal_preparation_time[i];
//     }
// }

// model{
//     distance_coeff ~  normal(0,0.0005);
//     meal_prep_coeff ~ normal(1.2,0.05);
//     sigma ~ exponential(1);
//     delivery_times ~ gamma(pow(mu,2)/pow(sigma,2),mu/pow(sigma,2));
//     traffic_level_coeff[1] ~ normal(0.1,0.01);
//     traffic_level_coeff[2] ~ normal(0.15,0.01);
//     traffic_level_coeff[3] ~ normal(0.2,0.01);
//     traffic_level_coeff[4] ~ normal(0.25,0.01);

//     for(i in 1:N){
//         travel_time[i] ~ exponential(distance_coeff*distance[i] + traffic_level_coeff[traffic_level[i]]);
//     }

// }

// generated quantities {
//     real delivery_time[N];
//      for (i in 1:N){
//       delivery_time[i] = gamma_rng(pow(mu[i],2)/pow(sigma,2),mu[i]/pow(sigma,2));
//    }
   
// }
// generated quantities {
//    real speed = normal_rng(0,0.0005);
//    real traffic_level_coeff[N];
//    traffic_level_coeff[1] = normal_rng(0.1,0.01);
//    traffic_level_coeff[2] = normal_rng(0.15,0.01);
//    traffic_level_coeff[3] = normal_rng(0.2,0.01);
//    traffic_level_coeff[4] = normal_rng(0.25,0.01);
//    real meal_prep_coeff = normal_rng(1.5,0.05);

//    real mu[N];
//    real sigma = exponential_rng(1);
//    real delivery_times[N];
//    real temp[N];
//    real gamma_alpha[N];
//    real gamma_beta[N];

//    for (i in 1:N){
//       temp[i] = speed*distance[i] + traffic_level_coeff[traffic_level[i]];
//       mu[i] = exponential_rng(speed*distance[i] + traffic_level_coeff[traffic_level[i]])+meal_prep_coeff*meal_preparation_time[i];
//       gamma_alpha[i] = pow(mu[i],2)/pow(sigma,2);
//       gamma_beta[i] = mu[i]/pow(sigma,2);
//       delivery_times[i] =gamma_rng(gamma_alpha[i], gamma_beta[i]);
//    }
// }


// data{
//     int N;                          // Number of samples
//     vector[N] distance;             // Distances
//     vector[N] meal_preparation_time; // Meal preparation times
//     vector[N] delivery_times;       // Delivery times
//     int traffic_level[N];           // Traffic levels
// }


// parameters{
//     real<lower=1> beta[N];
// }

// transformed parameters {
//     real mean_speed[4] = {2.708, 3.218, 3.555, 4.007};
//     real std_speed[4] = {0.4, 0.2, 0.2, 0.2};
//     real sigma = 10;
//     real<lower=1> mu[N];

//     for (i in 1:N){
//         mu[i] = 60* distance[i] / beta[i] + meal_preparation_time[i];
//     }
// }

// model{
//     for (i in 1:N){
//         meal_preparation_time[i] ~ normal(15,2);
//         delivery_times[i] ~ gamma(pow(mu[i], 2) / pow(sigma, 2), mu[i] / pow(sigma, 2));
//         beta[i] ~ lognormal(mean_speed[traffic_level[i]], std_speed[traffic_level[i]]);
//     }
//     // meal_preparation_time ~ normal(15,2);
//     // beta ~ lognormal(3.218, 0.2);
//     // delivery_times ~ gamma(pow(mu,2)/sigma, mu/sigma);
// //     for (i in 1:N){
// //         target += gamma_lpdf(delivery_times[i] | distance[i], beta);
// //         target += meal_preparation_time[i];
// //     }
// }

// generated quantities {
//     real delivery_time[N];
//     for(i in 1:N){
//         delivery_time[i] = gamma_rng(pow(mu[i], 2) / pow(sigma, 2), mu[i] / pow(sigma, 2));
//     }
// }
