function [x] = find_NN_cosine(W, k, top_n)

N = size(W,1);
dim = size(W,2);
W_k = W(k,:);

%W = W(1:NN,:);


W_norm = sqrt(sum(W.^2,2));
W0 = W ./ (W_norm * ones(1,dim));
% norm(W0(5,:),2)
W0 = W0 * diag(W_k);
W_norm = sum(W0,2);
W_norm = W_norm / norm(W_k,2);
max(W_norm)
[~,y] = sort(W_norm,'descend');
x = y(1:top_n);



