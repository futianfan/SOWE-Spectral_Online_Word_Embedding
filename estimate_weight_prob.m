function [weight_prob] = estimate_weight_prob(c_marginal)
len = length(c_marginal);
weight_prob = zeros(len,1);
weight_prob(len) = 10;
for i = 2:len
    j = len - i + 1;
    weight_prob(j) = max(weight_prob(j+1),c_marginal(j)) ;
end
weight_prob = weight_prob / sum(weight_prob);

