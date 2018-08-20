function [x] = find_NN_euclid(W, k, top_n)

N = size(W,1);
W_k = W(k,:);

W_dif = W - ones(N,1) * W_k;

dif = sum(W_dif.^2 , 2);

[~,index] = sort(dif);
x = index(1:top_n);


