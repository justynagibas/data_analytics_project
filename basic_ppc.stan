data{
    int N; # no of samples
    real distance[N];   # distances
    real meal_preparation_time[N];
}

generated quantities {
   real<lower=0, upper=1.7> beta;
    // real beta = normal_rng(0.55,0.07);
//    real meal_preparation_time;
   real delivery_time[N];
   for(i in 1:N){
    beta = gamma_rng(34,60);
    // meal_preparation_time = normal_rng(10,2);
    delivery_time[i] = gamma_rng(distance[i], beta)+meal_preparation_time[i];
   }
}