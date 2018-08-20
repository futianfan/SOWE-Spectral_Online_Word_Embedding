function [loss] = evaluate_loss(M, W, C, k)
    loss = 0;
    n = size(M,1);
    n2 = size(M,2);
    Wv = sum(M,2);  % n times 1
    Cv = sum(M,1);  % 1 times n
    block = 1000;
    Cv_norm = Cv / sum(Cv);
    for i = 1:block:n2
        strt = i;
        endd = i+block-1;
        if (endd > n2)
            endd = n2;
        end
        M_mask = M(:,strt:endd);
        M_flag = sparse(M_mask ~= 0);
        
        MM0 = W * (C(strt:endd,:))';        
        % positive loss
        MM = log_sigmoid(MM0);
        positive_loss = sum(sum(M_mask.*MM));
        
        
        % negative loss
        MM = log_sigmoid(-1 * MM0);
        negative_loss = sum(sum(diag(Wv) * ( MM * diag(Cv_norm(strt:endd)) ))) * k;   %    negative_loss = sum(sum(( MM .* Cv_norm(strt:endd) ) .* Wv)) * k;
        
        loss = loss + positive_loss + negative_loss;
        
    end
end