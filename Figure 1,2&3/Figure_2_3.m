clear  

load Data.mat  

T=size(id_gdp,1);  % Get the number of time periods (rows) in id_gdp
K=size(id_gdp,2);  % Get the number of countries (columns) in id_gdp

% Perform OLS regression cross-sectionally year by year.
for t=1:T
    result_t=OLSReg(id_gni(t,:)',[ones(K,1),id_gdp(t,:)']);  % Run OLS regression of id_gni on id_gdp for year t
    beta(:,t)=result_t.b(2,1);                               % Store the slope coefficient (beta) for year t
end

beta = beta';                                           
mpc = (1-beta).*100;                                         % Calculate the risk sharing percentage (mpc)
lambda =10;                                                  % Set the smoothing parameter for the HP-filter
[g]=HPfilter(mpc,lambda);                                    % Apply the HP-filter to smooth mpc

Log_Total_assets_mean = Log_Total_assets_mean';  
lambda =0.5; 
[u]=HPfilter(Log_Total_assets_mean,lambda); 

y = Years(1, 1:11);  % Select the first 10 years

figure;  
yyaxis left;  
plot(y, g, 'bs-', 'MarkerFaceColor', 'b', 'DisplayName', 'Income Risk Sharing'); 
xlabel('Year');  
ylabel('Risk Sharing Percentage');  
ax = gca;  
ax.YColor = 'k';  


yyaxis right; 
plot(y, u, 'r^-', 'MarkerFaceColor', 'r', 'DisplayName', 'Log Assets'); 
ylabel('Log (Assets/GDP)');
ax.YColor = 'k'; 

% Add the legend
title('Figure 2');  
legend('Income Risk Sharing','mean of Log(Assets/GDP)');  

T=size(id_cons,1);  % Get the number of time periods (rows) in id_cons
K=size(id_cons,2);  % Get the number of countries (columns) in id_cons

% Calculate the Consumption risk sharing percentage
for t=1:T
    result_t1=OLSReg(id_cons(t,:)',[ones(K,1),id_gdp(t,:)']);  % Run OLS regression of id_cons on id_gdp for year t
    beta2(:,t)=result_t1.b(2,1);                               % Store the slope coefficient (beta2) for year t
end

beta2 = beta2';  
mpc2 = (1-beta2).*100; 
lambda = 20;  
[f]=HPfilter(mpc2,lambda);                                     % Apply the HP-filter to smooth mpc2

figure;  
yyaxis left; 
plot(y, f, 'bs-', 'MarkerFaceColor', 'b', 'DisplayName', 'Income Risk Sharing'); 
xlabel('Year');
ylabel('Risk Sharing Percentage'); 
ax = gca;
ax.YColor = 'k';  

yyaxis right;  
plot(y,u, 'r^-', 'MarkerFaceColor', 'r' ,'DisplayName',  'Log Assets');
ylabel('Log(Assets/GDP)'); 
ax.YColor = 'k'; 

title('Figure 3'); 
legend('Consumption Risk Sharing', 'mean of Log(Assets/GDP)'); 
