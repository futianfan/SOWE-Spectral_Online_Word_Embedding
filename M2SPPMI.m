function [S] = M2SPPMI(M,k)
    n1 = size(M,1);
    n2 = size(M,2);
    Wv = sum(M,2);  % n times 1
    Cv = sum(M,1);  % 1 times n
    num_all = sum(Cv);
    %M2 = M * num_all  ./ Wv ./ Cv;
    M2 = inv(diag(Wv)) * M * num_all;
    M2 =  M2 * inv(diag(Cv));
    S = PPMI(M2,k); %% PPMI

end