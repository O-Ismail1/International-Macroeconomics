clear  
load Data.mat  

[T,K]=size(id_gdp);  % Get the dimensions of 'id_gdp' matrix

Trend = 1:11;       % Create a trend vector from 1 to 11
t = 6;               % mid year of the trend
Trend = Trend - t; 
Trend = repmat(Trend, 24, 1);  % Repeat the trend vector for 24 times (rows)

% controlling for country fixed effects
id_cons = FE_function(id_cons, 0, 1);  
id_gdp = FE_function(id_gdp, 0, 1);  
id_gni = FE_function(id_gni, 0, 1);  
E = FE_function(E, 0, 1);  
D = FE_function(D, 0, 1);  
FDI = FE_function(FDI, 0, 1);  
Debt_Equity = FE_function(Debt_Equity, 0, 1);  
Total_assets = FE_function(Total_assets, 0, 1);  

% Income risk sharing - Equity
Intterm1 = Trend'.*id_gdp;  % Interaction term between trend and GDP
Intterm2 = (E.*id_gdp')';  % Interaction term between equity and GDP

result_e = OLSReg(id_gni(:), [ones(K*T, 1), id_gdp(:), Intterm1(:), Intterm2(:)]);  

uI = result_e.u(:, 1);  % Extract residuals
uIm = vec2mat(uI, T, K)';  % Reshape residuals into a matrix

varuI = std(uIm);  % Compute standard deviation of residuals
varuIm = ones(T, 1) * varuI;  % Create a matrix of standard deviations

% Standardize variables by their standard deviations
id_gni_e = id_gni ./ varuIm;
id_gdp_e = id_gdp ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_e = OLSReg(id_gni_e(:), [ones(K*T, 1), id_gdp_e(:), Intterm1(:), Intterm2(:)]);  

IntTermReg_e.b  
IntTermReg_e.tstat  

% Income risk sharing - Debt
Intterm1 = Trend'.*id_gdp;  % Interaction term between trend and GDP
Intterm2 = (D.*id_gdp')';  % Interaction term between debt and GDP

result_d = OLSReg(id_gni(:), [ones(K*T, 1), id_gdp(:), Intterm1(:), Intterm2(:)]); 

uI = result_d.u(:, 1); 
uIm = vec2mat(uI, T, K)'; 

varuI = std(uIm);  
varuIm = ones(T, 1) * varuI;  

id_gni_d = id_gni ./ varuIm;
id_gdp_d = id_gdp ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_d = OLSReg(id_gni_d(:), [ones(K*T, 1), id_gdp_d(:), Intterm1(:), Intterm2(:)]);  

IntTermReg_d.b  % Display regression coefficients
IntTermReg_d.tstat  % Display t-statistics

% Income risk sharing - FDI
Intterm1 = Trend'.*id_gdp;  % Interaction term between trend and GDP
Intterm2 = (FDI.*id_gdp')';  % Interaction term between FDI and GDP

result_fdi = OLSReg(id_gni(:), [ones(K*T, 1), id_gdp(:), Intterm1(:), Intterm2(:)]);

uI = result_fdi.u(:, 1);  
uIm = vec2mat(uI, T, K)'; 

varuI = std(uIm); 
varuIm = ones(T, 1) * varuI; 

id_gni_fdi = id_gni ./ varuIm;
id_gdp_fdi = id_gdp ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_fdi = OLSReg(id_gni_fdi(:), [ones(K*T, 1), id_gdp_fdi(:), Intterm1(:), Intterm2(:)]);  

IntTermReg_fdi.b 
IntTermReg_fdi.tstat  

% Income risk sharing - Debt and Equity
Intterm1 = Trend'.*id_gdp;  % Interaction term between trend and GDP
Intterm2 = (Debt_Equity.*id_gdp')';  % Interaction term between debt and equity and GDP

result_debt_equity = OLSReg(id_gni(:), [ones(K*T, 1), id_gdp(:), Intterm1(:), Intterm2(:)]);  

uI = result_debt_equity.u(:, 1); 
uIm = vec2mat(uI, T, K)';  

varuI = std(uIm); 
varuIm = ones(T, 1) * varuI; 

id_gni_debt_equity = id_gni ./ varuIm;
id_gdp_debt_equity = id_gdp ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_debt_equity = OLSReg(id_gni_debt_equity(:), [ones(K*T, 1), id_gdp_debt_equity(:), Intterm1(:), Intterm2(:)]);  

IntTermReg_debt_equity.b  
IntTermReg_debt_equity.tstat  

% Income risk sharing - Total Assets
Intterm1 = Trend'.*id_gdp;  % Interaction term between trend and GDP
Intterm2 = (Total_assets.*id_gdp')';  % Interaction term between total assets and GDP

result_total_assets = OLSReg(id_gni(:), [ones(K*T, 1), id_gdp(:), Intterm1(:), Intterm2(:)]);  

uI = result_total_assets.u(:, 1);  
uIm = vec2mat(uI, T, K)'; 

varuI = std(uIm);  
varuIm = ones(T, 1) * varuI; 

id_gni_assets = id_gni ./ varuIm;
id_gdp_assets = id_gdp ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_total_assets = OLSReg(id_gni_assets(:), [ones(K*T, 1), id_gdp_assets(:), Intterm1(:), Intterm2(:)]);  

IntTermReg_total_assets.b  
IntTermReg_total_assets.tstat  

% Consumption risk sharing - Equity
Intterm1 = Trend'.*id_gdp;  % Interaction term between trend and GDP
Intterm2 = (E.*id_gdp')';  % Interaction term between equity and GDP

result_E = OLSReg(id_cons(:), [ones(K*T, 1), id_gdp(:), Intterm1(:), Intterm2(:)]);  

uI = result_E.u(:, 1);  
uIm = vec2mat(uI, T, K)'; 

varuI = std(uIm); 
varuIm = ones(T, 1) * varuI;  

id_cons_E = id_cons ./ varuIm;
id_gdp_E = id_gdp ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_E = OLSReg(id_cons_E(:), [ones(K*T, 1), id_gdp_E(:), Intterm1(:), Intterm2(:)]);

IntTermReg_E.b  
IntTermReg_E.tstat  

% Consumption risk sharing - Debt
Intterm1 = Trend'.*id_gdp;  % Interaction term between trend and GDP
Intterm2 = (D.*id_gdp')';  % Interaction term between debt and GDP

result_D = OLSReg(id_cons(:), [ones(K*T, 1), id_gdp(:), Intterm1(:), Intterm2(:)]); 

uI = result_D.u(:, 1);
uIm = vec2mat(uI, T, K)';  

varuI = std(uIm); 
varuIm = ones(T, 1) * varuI;  

id_cons_D = id_cons ./ varuIm;
id_gdp_D = id_gdp ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_D = OLSReg(id_cons_D(:), [ones(K*T, 1), id_gdp_D(:), Intterm1(:), Intterm2(:)]);  

IntTermReg_D.b  
IntTermReg_D.tstat 

% Consumption risk sharing - FDI
Intterm1 = Trend'.*id_gdp;  % Interaction term between trend and GDP
Intterm2 = (FDI.*id_gdp')';  % Interaction term between FDI and GDP

result_FDI = OLSReg(id_cons(:), [ones(K*T, 1), id_gdp(:), Intterm1(:), Intterm2(:)]);  

uI = result_FDI.u(:, 1); 
uIm = vec2mat(uI, T, K)'; 

varuI = std(uIm); 
varuIm = ones(T, 1) * varuI; 

id_cons_FDI = id_cons ./ varuIm;
id_gdp_FDI = id_gdp ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_FDI = OLSReg(id_cons_FDI(:), [ones(K*T, 1), id_gdp_FDI(:), Intterm1(:), Intterm2(:)]);  
IntTermReg_FDI.b 
IntTermReg_FDI.tstat  

% Consumption risk sharing - Debt and Equity
Intterm1 = Trend'.*id_gdp;  % Interaction term between trend and GDP
Intterm2 = (Debt_Equity.*id_gdp')';  % Interaction term between debt and equity and GDP

result_Debt_Equity = OLSReg(id_cons(:), [ones(K*T, 1), id_gdp(:), Intterm1(:), Intterm2(:)]);  

uI = result_Debt_Equity.u(:, 1);
uIm = vec2mat(uI, T, K)';  

varuI = std(uIm);  
varuIm = ones(T, 1) * varuI;  

id_cons_Debt_Equity = id_cons ./ varuIm;
id_gdp_Debt_Equity = id_gdp ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_Debt_Equity = OLSReg(id_cons_Debt_Equity(:), [ones(K*T, 1), id_gdp_Debt_Equity(:), Intterm1(:), Intterm2(:)]); 

IntTermReg_Debt_Equity.b  
IntTermReg_Debt_Equity.tstat  

% Consumption risk sharing - Total Assets
Intterm1 = Trend'.*id_gdp;  % Interaction term between trend and GDP
Intterm2 = (Total_assets.*id_gdp')';  % Interaction term between total assets and GDP

result_Total_Assets = OLSReg(id_cons(:), [ones(K*T, 1), id_gdp(:), Intterm1(:), Intterm2(:)]);  

uI = result_Total_Assets.u(:, 1); 
uIm = vec2mat(uI, T, K)'; 

varuI = std(uIm); 
varuIm = ones(T, 1) * varuI;  

id_cons_Assets = id_cons ./ varuIm;
id_gdp_Assets = id_gdp ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_Total_Assets = OLSReg(id_cons_Assets(:), [ones(K*T, 1), id_gdp_Assets(:), Intterm1(:), Intterm2(:)]);  

IntTermReg_Total_Assets.b 
IntTermReg_Total_Assets.tstat 
