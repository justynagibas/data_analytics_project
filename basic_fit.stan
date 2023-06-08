data{
    int N; # no of samples
    real distance[N];   # distances
    real meal_preparation_time[N];
    real delivery_times[N];
    int traffic_level[N];
}

parameters{
    real<lower=1, upper=100> beta[N];
}

transformed parameters {
    real mean_speed[4] = {2.708, 3.218, 3.555, 4.007};
    real std_speed[4] = {0.4, 0.2, 0.2, 0.2};
    real sigma = 10;
    real<lower=1, upper=100> mu[N];

    for (i in 1:N){
        mu[i] = 60* distance[i] / beta[i] + meal_preparation_time[i];
    }
}

model{
    for (i in 1:N){
        meal_preparation_time[i] ~ normal(15,2);
        delivery_times[i] ~ gamma(pow(mu[i],2)/sigma, mu[i]/sigma);
        beta[i] ~ lognormal(mean_speed[traffic_level[i]], std_speed[traffic_level[i]]);
    }
    // meal_preparation_time ~ normal(15,2);
    // beta ~ lognormal(3.218, 0.2);
    // delivery_times ~ gamma(pow(mu,2)/sigma, mu/sigma);
//     for (i in 1:N){
//         target += gamma_lpdf(delivery_times[i] | distance[i], beta);
//         target += meal_preparation_time[i];
//     }
}

generated quantities {
    real delivery_time[N];
    for(i in 1:N){
        delivery_time[i] = gamma_rng(pow(mu[i],2)/sigma, mu[i]/sigma);
    }
}
