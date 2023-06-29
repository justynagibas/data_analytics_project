data{
    int N; // no of samples
    array[N] real distance;   // distances
    array[N] real meal_preparation_time;
    array[N] int traffic_level;
}

generated quantities {
   real distance_coeff = normal_rng(0, 0.3);
   array[4] real traffic_level_coeff;
   traffic_level_coeff[1] = normal_rng(0, 0.3);
   traffic_level_coeff[2] = normal_rng(0, 0.3);
   traffic_level_coeff[3] = normal_rng(0, 0.3);
   traffic_level_coeff[4] = normal_rng(0, 0.3);
   // traffic_level_coeff[1] = 0;
   // traffic_level_coeff[2] = 0;
   // traffic_level_coeff[3] = 0;
   // traffic_level_coeff[4] = 0;
   real meal_prep_coeff = normal_rng(0, 0.3);

   array[N] real mu;
   real sigma = exponential_rng(0.5);
   array[N] real delivery_times;
   array[N] real temp1;
   array[N] real gamma_alpha;
   array[N] real gamma_beta;
   array[N] real temp2;

   for (i in 1:N){
      temp1[i] = distance_coeff*distance[i] + traffic_level_coeff[traffic_level[i]]+meal_prep_coeff*meal_preparation_time[i]+3;
      // temp2[i] = exp(distance_coeff*distance[i] + traffic_level_coeff[traffic_level[i]]);
      mu[i] = exp(distance_coeff*distance[i] + traffic_level_coeff[traffic_level[i]]+meal_prep_coeff*meal_preparation_time[i]+3);
      gamma_alpha[i] = pow(mu[i], 2) / pow(sigma, 2) + 2;
      gamma_beta[i] = pow(mu[i],3) / pow(sigma, 2) + mu[i];
      delivery_times[i] = inv_gamma_rng(pow(mu[i], 2) / pow(sigma, 2) + 2, pow(mu[i],3) / pow(sigma, 2) + mu[i]);
   }
}