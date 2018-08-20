function [W,C] = UDV2WC(U,D,V)
W = U * sqrt(D);
C = V * sqrt(D);
