function [loss] = evaluate_sparse_loss(M1,W0,C0)

[n1,n2] = size(M1);
index = find(M1);
column = ceil(index/n1);
row = index - (column-1) * n1;
value = M1(index);
W2 = W0(row,:);
C2 = C0(column,:);
WdotC = sum(W2 .* C2, 2);
loss = sum(value .* log(sigmoid(WdotC)));
end

