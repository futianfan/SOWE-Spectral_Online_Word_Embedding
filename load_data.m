windows = 5;
if (~exist('W'))
tic; W = load('bow5.words2');toc;
fprintf('%s ','loading W');
end
if (~exist('C'))
tic;C = load('bow5.contexts2');toc;
fprintf('%s ','loading W');
end
N0 = size(W,1);
dim = size(W,2);
%%%% Well-trained W/C matrix
sparse_M = load('sparse_matrix_nips_economy');
%sparse_M = load('sparse_matrix_nips');   %  sparse_M = load('sparse_matrix');
sparse_M(:,1) = sparse_M(:,1) + 1;
sparse_M(:,2) = sparse_M(:,2) + 1;
M0 = sparse(sparse_M(:,1),sparse_M(:,2),sparse_M(:,3));

N = max(sparse_M(:,1)); % 184976;
N_new = N - N0;  % e.g., 500 
c_marginal_2 = sum(M0(N0+1:N,:),2); % 500, 1

c_marginal_1 = sum(M0(1:N0,:),2); % N0, 1
weight_prob = estimate_weight_prob(c_marginal_1);

tic;
M11 = M0(1:N0,1:N);
M12 = M0(1:N0,N0+1:N);
M21 = M0(N0+1:N,1:N0);
M22 = M0(N0+1:N,N0+1:N);
S12 = sparse((((1./weight_prob) * ones(1,N-N0)) .* M12) * diag(1./c_marginal_2)); 
S21 = sparse(diag(1./c_marginal_2)  * (M21 .* (1./weight_prob * ones(1,N-N0))')); 
S22 = sparse(diag(1./c_marginal_2) * M22 * (1/weight_prob(N0)) * 0.01);
% output:   P12  P2
k_value = 1;
P12 = PPMI(S12,k_value);
P2 = PPMI([S21,S22],k_value);

