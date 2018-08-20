%%%% Well-trained W/C matrix
load_data;

% output: W, C, P12, P2 , M12, M21, M22, N0, N, M0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% W, C => U,D,V

%%%% 11111111: online SVD
% tic;

%[U,D,V] = WC2UDV(W,C);
%[U1,D1,V1] = block_onlineSVD(U,D,V,P12,P2);
%[W1,C1] = UDV2WC(U1,D1,V1);


%%% NIPS + economy two-step
[U,D,V] = WC2UDV(W,C);
N_mid = 184976;
N_dif_1 = N_mid - N0;
N_dif_2 = N - N_mid; 
N_dif = N_dif_1 + N_dif_2; 
P12_1 = P12(:,1:N_dif_1);
P12_2 = [P12(:,N_dif_1+1:N_dif);P2(1:N_dif_1,N_mid+1:N)];
P2_1 = P2(1:N_dif_1,1:N_mid);
P2_2 = P2(N_dif_1+1:N_dif,:);
[U1,D1,V1] = block_onlineSVD(U,D,V,P12_1,P2_1);
[U1,D1,V1] = block_onlineSVD(U1,D1,V1,P12_2, P2_2);
[W1,C1] = UDV2WC(U1,D1,V1);

% toc;
%%%% 222222222: random init
% [mu_w, Sigma_w] = estimate_mean_variance(W);
% [mu_c, Sigma_c] = estimate_mean_variance(C);
% [U_sigmaw, D_sigmaw, V_sigmaw] = svd(Sigma_w);
% Q_w = U_sigmaw * sqrt(D_sigmaw);
% [U_sigmac, D_sigmac, V_sigmac] = svd(Sigma_c);
% Q_c = U_sigmac * sqrt(D_sigmac);
% W_init = ones(N-N0,1) * mu_w ...
%     + randn(N-N0,dim) * Q_w';
% C_init = ones(N-N0,1) * mu_c ...
%     + randn(N-N0,dim) * Q_c';
% W2 = [W;W_init];
% C2 = [C;C_init];
% % %%% 333333333: fix+SGD
% iter = 150; minibatch = 20000; 
% stepsize0 = 2e-1; %1e-2 is ok,  
% Cv = sum(M0,1); 
% set1 = find(sparse_M(:,1) > N0);
% set2 = find(sparse_M(:,2) > N0);
% Mss = sparse_M(union(set1,set2),:);
% %tic;
% [W3,C3] = fix_sgd(W2,C2,iter,...
%   minibatch,stepsize0,Mss,N0,Cv,M0);
% % toc;
% 
% % NN = 184718; % 184846;
% % x = find_NN_euclid(W2,NN,20);
% % save -ascii tmp x;
% % 
% NN = 184484; 
% % 184701,gdps; 184151,eurodollars; 
% %184484:reflation; 
% x = find_NN_cosine2(W3,NN,25,N0);
% save -ascii tmp x;
% % y = find_NN_euclid(W3,NN,10)
% % 
% % 
% % % 
% % WW = W2;
% % CC = C2;
% % %% loss_11_p = evaluate_sparse_loss...
% % %%  (M11,WW(1:N0,:),CC(1:N0,:));
% % loss_12_p = evaluate_sparse_loss...
% %     (M12,WW(1:N0,:),CC(N0+1:N,:));
% % loss_21_p = evaluate_sparse_loss...
% %     (M21,WW(N0+1:N,:),CC(1:N0,:));
% % loss_22_p = evaluate_sparse_loss...
% %     (M22,WW(N0+1:N,:),CC(N0+1:N,:));
% % loss_new = loss_12_p + loss_21_p + loss_22_p


% fix+SGD: loss_new: -1.7334e+05; time: xxx seconds; 1e3 iteration; 1e-3 stepsize
% online SVD:  loss_new:  -1.5276e+05; time: xxx seconds



% euclid
% submodular 
% 1. online SVD:   nonsmooth, cnns, svrg, 
% coreset, sublinear, denoising, ?, ?,
% 2. SGD: provident, dnc, schiavone, distanced, 
% neighbours, 





