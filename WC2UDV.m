function [U,D,V] = WC2UDV(W,C)

[U,R1] = qr(W,0);
[V,R2] = qr(C,0);
[U0,D0,V0] = svd(R1*R2');
U = U * U0;
V = V * V0;
D = D0;

