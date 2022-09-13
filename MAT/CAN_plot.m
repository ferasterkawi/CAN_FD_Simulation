 n = 7; % number of nodes
 l = length(D);
 C_=cell(1,7);
 Mx = 0;
 Mn = 0;
 for i = 1:n
     for j = 1:l
     if(ID(j) == i)
         C_{i} = [C_{i},D(j)];
     end
     end
     Mx = [Mx , max(C_{i})];
     Mn = [Mn , mean(C_{i})];
 end
 plot([0:7],Mx,'--ks','LineWidth',2,'MarkerFaceColor',[0,0,0])
 title('Time Delay')
 xlabel('Node Priority')
 ylabel('Msg Delay')
 hold on