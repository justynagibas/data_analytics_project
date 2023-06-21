data{
    int N; // no of samples
    array[N] real distance;   // distances
    array[N] real meal_preparation_time;
    array[N] int traffic_level;
}

generated quantities {
   real distance_coeff = fabs(normal_rng(3,0.2));
   array[4] real traffic_level_coeff;
   traffic_level_coeff[1] = normal_rng(1.5, 0.3);
   traffic_level_coeff[2] = normal_rng(1.0, 0.2);
   traffic_level_coeff[3] = normal_rng(0.5, 0.1);
   traffic_level_coeff[4] = normal_rng(0.3, 0.05);
   real meal_prep_coeff = normal_rng(1.2,0.3);

   array[N] real mu;
   real sigma = exponential_rng(2);
   array[N] real delivery_times;
   array[N] real temp1;
   array[N] real gamma_alpha;
   array[N] real gamma_beta;
   array[N] real temp2;

   for (i in 1:N){
      temp1[i] = distance_coeff*distance[i] + traffic_level_coeff[traffic_level[i]]+meal_prep_coeff*meal_preparation_time[i];
      temp2[i] = exp(distance_coeff*distance[i] + traffic_level_coeff[traffic_level[i]]);
      mu[i] = exp(distance_coeff*distance[i] + traffic_level_coeff[traffic_level[i]])+meal_prep_coeff*meal_preparation_time[i];
      gamma_alpha[i] = pow(mu[i],2)/pow(sigma,2);
      gamma_beta[i] = mu[i]/pow(sigma,2);
      delivery_times[i] = gamma_rng(gamma_alpha[i], gamma_beta[i]);
   }
}