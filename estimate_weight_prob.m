function [weight_prob] = estimate_weight_prob(c_marginal)
len = length(c_marginal);  % c_marginal(i) is count for i-th word.
weight_prob = zeros(len,1);
weight_prob(len) = 10;
for i = 2:len
    j = len - i + 1;  ## from bottom to top
    weight_prob(j) = max(weight_prob(j+1),c_marginal(j)) ;
### make it at least >= its right neibours
end
weight_prob = weight_prob / sum(weight_prob);  %% sum to 1

