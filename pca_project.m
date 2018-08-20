% pca

V = W;
[U_p, D_p, V_p] = svds(V,2);


V_2 = W2 * V_p;
V_3 = W3 * V_p;

for i = 1:5:N0 % N0-1000:N 
   plot(V_2(i,1),V_2(i,2),'bo','MarkerSize',8);
   hold on;

end

for i = N0+1:N % 1+N0:N0+1000
   plot(V_2(i,1),V_2(i,2),'ro','MarkerSize',6); 
   hold on;
   plot(V_3(i,1),V_3(i,2),'ko','MarkerSize',6);
   hold on;
   plot([V_2(i,1), V_3(i,1)], [V_2(i,2), V_3(i,2)],'c','LineWidth',1);
   hold on;
end


