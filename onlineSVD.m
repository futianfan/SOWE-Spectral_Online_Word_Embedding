function [U1,D1,V1] = onlineSVD(U,D,V,a)
% S = U D V^T   [S,a] = U1 D1 V1^T
    b = U' * a;
    Vp = ([D * V',b])';
%    [Q,R] = qr(Vp,0);
%    S = D * R';
    dim = size(D,1);
    [Vs,Ds,Us] = svds(Vp,dim);
    U1 = U * Us;
    D1 = Ds;
    V1 = Vs;
end