function [U,D,V] = block_onlineSVD(U,D,V,M12,M2)
[U,D,V] = onlineSVD(U,D,V,M12);
[V,D,U] = onlineSVD(V,D,U,M2'); 


