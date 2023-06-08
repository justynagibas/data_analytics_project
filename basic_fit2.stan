data{
    int N; # no of samples
    real distance[N];   # distances
    real delivery_times[N];
}

parameters{
    real<lower=0, upper=1.7> beta;
    real<lower=5, upper=15> meal_preparation_time;
}

model{
    meal_preparation_time ~ normal(10,2);
    beta ~ normal(0.58,0.08);
    for (i in 1:N){
        target += gamma_lpdf(delivery_times[i] | distance[i], beta);
        target += normal_lpdf(meal_preparation_time | 10, 2);
    }
}

generated quantities {
    real delivery_time[N];
   for(i in 1:N){
    delivery_time[i] = gamma_rng(distance[i], beta)+meal_preparation_time;
   }
}
