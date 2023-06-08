data{
    int N; # no of samples
    real distance[N];   # distances
    real meal_preparation_time[N];
    int traffic_level[N];
}

generated quantities {
//    real mean_speed[4] = {0.166, 0.333, 0.583, 1};    // for normal distribution
//    real std_speed[4] = {0.166, 0.166, 0.166, 0.33};
   real mean_speed[4] = {2.708, 3.218, 3.555, 4.174};    // for lognormal distribution
   real std_speed[4] = {0.4, 0.2, 0.2, 0.2};
   real beta[N];
   real mu[N];
   real sigma = 10;
   real delivery_times[N];
   real meal_prep_time;
   for (i in 1:N){
      meal_prep_time = normal_rng(15,2);
      beta[i] = lognormal_rng(mean_speed[traffic_level[i]], std_speed[traffic_level[i]]) / 60;
      mu[i] = distance[i] / beta[i] + meal_prep_time/*meal_preparation_time[i]*/;
      delivery_times[i] = gamma_rng(pow(mu[i],2)/sigma, mu[i]/sigma);
   }
   
}

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