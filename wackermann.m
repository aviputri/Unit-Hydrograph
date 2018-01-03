% I have edited the script so that we can change the duration easily and
% labels and title have been added automatically

% size of the catchment
ac=72.1;
% length of the main river
l=19.276571;
% total river length in 1 catchment area
lt=86.081;
% lowest point of the river
gs=350.5;
% highest point of the river
he=787.521973;

% slope
Dh=he-gs;
J=Dh/(l*10^3);
% river density
D=lt/ac;
% hydrographic factor
hf=l/J^(0.5);

% constants and weighting factor
k1=4.38-2.25*D;
k2=(0.0168*hf) + 2.5 ;
beta=0.323*(exp(-0.00765*hf));

% time interval
dt=1; %1 hour
% duration of the rain
T_tot=48; % <--after calculating the T_tot > 48 hrs, it shows that the distribution stops at 48

% substitutions
a1=dt/k1;
a2=dt/k2;

% recursive formula
for i=1:T_tot
    if i==1
        
    h(i)= 1 -(beta*(exp(-a1*i))*(a1*i+1)+(1-beta)*(exp(-a2*i))*(a2*i+1));
    
    end
    
    if i>1
        h(i)= 1 - sum(h(1:i-1)) - (beta*(exp(-a1*i))*(a1*i+1)+(1-beta)*(exp(-a2*i))*(a2*i+1));
    if sum(h)>1
        break
    end 
    end
end

check=sum(h);

ht = transpose(h);

bar(1:length(h),h, 0.4);
title('Unit Hydropgraph'); % insert the graph title
xlabel('time (h)'); % insert x-axis label
ylabel('UH (/m^3/s/mm)'); % insert y-axis label
