function [Y,Z] = fix_sgd(Y0,Z0,iter,...
    minibatch,stepsize0,Mss,N0,Cv,M0)
Y = Y0;
Z = Z0;
N = size(Y,1);
dim = size(Y,2)
leng = size(Mss,1);
sample_index_total = randsample(1:leng,...
    iter * minibatch,true,ones(leng,1));
% M11 = M0(1:N0,1:N);
M12 = M0(1:N0,N0+1:N);
M21 = M0(N0+1:N,1:N0);
M22 = M0(N0+1:N,N0+1:N);
Loss_record = [];
for i = 1:iter
    if ((mod(i,5) == 0))
        WW = Y;
        CC = Z;
        loss_12_p = evaluate_sparse_loss...
        (M12,WW(1:N0,:),CC(N0+1:N,:));
        loss_21_p = evaluate_sparse_loss...
        (M21,WW(N0+1:N,:),CC(1:N0,:));
        loss_22_p = evaluate_sparse_loss...
        (M22,WW(N0+1:N,:),CC(N0+1:N,:));
        loss_new = loss_12_p + loss_21_p + loss_22_p
        Loss_record = [Loss_record,loss_new]
    end
    tic;
    stepsize = stepsize0 / sqrt(i);
    grad_Y = zeros(N,dim);
    grad_Z = zeros(N,dim);       
    sample_index = sample_index_total((i-1)*minibatch+1:i*minibatch);    
    A = Mss(sample_index,1);
    B = Mss(sample_index,2);
    C = Mss(sample_index,3);
    len = length(sample_index);     
    D = randsample(1:N,len,true,full(Cv));
    
    AB = sum(Y(A,:) .* Z(B,:),2); % nn times 1
    AB_sig = (1 - sigmoid(AB)) .* C;% nn times 1    
    grad_Y(A,:) = grad_Y(A,:) + diag(AB_sig) * Z(B,:);   % grad_Y(A,:) = grad_Y(A,:) + AB_sig .* Z(B,:);
    grad_Z(B,:) = grad_Z(B,:) + diag(AB_sig) * Y(A,:);       %  grad_Z(B,:) = grad_Z(B,:) + AB_sig .* Y(A,:);
    AD = sum(-1 * Y(A,:) .* Z(D,:) ,2);
    AD_sig = (1 - sigmoid(AD)) .* (C);
    grad_Y(A,:) = grad_Y(A,:) + diag(AD_sig) * (-1 * Z(D,:));    %   grad_Y(A,:) = grad_Y(A,:) + AD_sig .* (-1 * Z(D,:));
    grad_Z(D,:) = grad_Z(D,:) + diag(AD_sig) * (-1 * Y(A,:));      % grad_Z(D,:) = grad_Z(D,:) + AD_sig .* (-1 * Y(A,:));
    Y = Y + stepsize * grad_Y;
    Z = Z + stepsize * grad_Z;
    Y(1:N0,:) = Y0(1:N0,:);
    Z(1:N0,:) = Z0(1:N0,:);
toc;
end
