data{
    int N; // no of samples
    array[N] real distance;   // distances
    array[N] real meal_preparation_time;
    array[N] int traffic_level;
}

generated quantities {
   real distance_coeff = fabs(normal_rng(0.1,0.01));
   array[4] real traffic_level_coeff;
   traffic_level_coeff[1] = normal_rng(0.8,0.01);
   traffic_level_coeff[2] = normal_rng(0.5,0.01);
   traffic_level_coeff[3] = normal_rng(0.5,0.01);
   traffic_level_coeff[4] = normal_rng(0.8,0.01);
   real meal_prep_coeff = normal_rng(0.1,0.02);

   array[N] real mu;
   real sigma = exponential_rng(1);
   array[N] real delivery_times;
   array[N] real temp1;
   array[N] real gamma_alpha;
   array[N] real gamma_beta;
   array[N] real temp2;

   for (i in 1:N){
      temp1[i] = distance_coeff*distance[i] + traffic_level_coeff[traffic_level[i]];
      temp2[i] = exp(distance_coeff*distance[i] + traffic_level_coeff[traffic_level[i]]);
      mu[i] = exp(distance_coeff*distance[i] + traffic_level_coeff[traffic_level[i]]+meal_prep_coeff*meal_preparation_time[i]);
      gamma_alpha[i] = pow(mu[i],2)/pow(sigma,2);
      gamma_beta[i] = mu[i]/pow(sigma,2);
      delivery_times[i] = gamma_rng(gamma_alpha[i], gamma_beta[i]);
   }
}

// generated quantities {
// //    real mean_speed[4] = {0.166, 0.333, 0.583, 1};    // for normal distribution
// //    real std_speed[4] = {0.166, 0.166, 0.166, 0.33};
//    real mean_speed[4] = {2.708, 3.218, 3.555, 4.174};    // for lognormal distribution
//    real std_speed[4] = {0.4, 0.2, 0.2, 0.2};
//    real beta[N];
//    real mu[N];
//    real sigma = 10;
//    real delivery_times[N];
//    real meal_prep_time;
//    for (i in 1:N){
//       meal_prep_time = normal_rng(15,2);
//       beta[i] = lognormal_rng(mean_speed[traffic_level[i]], std_speed[traffic_level[i]]) / 60;
//       mu[i] = distance[i] / beta[i] + meal_prep_time/*meal_preparation_time[i]*/;
//       delivery_times[i] = gamma_rng(pow(mu[i],2)/sigma, mu[i]/sigma);
//    }
   
// }

// generated quantities {
//     real<lower=0, upper=1.7> beta = normal_rng(0.58,0.08);
// //    real meal_preparation_time;
//    real delivery_time[N];
//    for(i in 1:N){
//     // meal_preparation_time = normal_rng(10,2);
//     delivery_time[i] = gamma_rng(distance[i], beta)+meal_preparation_time[i];
//    }
// }

// generated quantities {
//     real<lower=0, upper=1.7> beta = normal_rng(0.58,0.08);
//     // real<lower=0, upper=1.7> beta = fabs(normal_rng(0.08,0.5));
//    real meal_preparation_time_1;
//    real delivery_time[N];
//    for(i in 1:N){
//     meal_preparation_time_1 = gamma_rng(10,1);
//     delivery_time[i] = gamma_rng(distance[i], beta)+meal_preparation_time_1;
//    }
// }