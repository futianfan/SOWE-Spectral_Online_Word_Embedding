function [mu, Sigma] = estimate_mean_variance(W)
mu = mean(W,1);
N = size(W,1);
W0 = W - ones(N,1) * mu;
Sigma = W0' * W0 / N;

