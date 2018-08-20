function [weight_prob] = estimate_weight_power(c_marginal)
len = length(c_marginal);
alpha = 1e-6;
beta = alpha * (1:len);
weight_prob = exp(-1 * beta);
weight_prob = weight_prob / sum(weight_prob);

