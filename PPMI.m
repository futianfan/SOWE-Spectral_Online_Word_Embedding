function [sparse_matrix] = PPMI(M,k)

m = size(M,1);
n = size(M,2);
index = find(M);
column = ceil(index/m);
row = index - (column - 1) * m;


value = nonzeros(M);
value = log(value) - log(k);
value = max(0,value);
sparse_matrix = sparse(m,n);
sparse_matrix2 = sparse(row,column,value);
max_row = max(row);
max_column = max(column);
sparse_matrix(1:max_row,1:max_column) = sparse_matrix2;
end

