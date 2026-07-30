clear 
load Data.mat 

[T,K]=size(id_gdp_EU_5); % Get dimensions of the GDP data for EU_8 (T: time periods, K: countries)

Trend = 1:11;               % Create a trend vector from 1 to 11
t = 6;                     % Define the middle year of the trend
Trend = Trend - t; 
Trend = repmat(Trend, 14, 1); 

% Apply fixed effects function to each variable
id_cons_EU_5 = FE_function(id_cons_EU_5, 0, 1);
id_gdp_EU_5 = FE_function(id_gdp_EU_5, 0, 1);
id_gni_EU_5 = FE_function(id_gni_EU_5, 0, 1);
E_EU_5 = FE_function(E_EU_5, 0, 1);
D_EU_5 = FE_function(D_EU_5, 0, 1);
FDI_EU_5 = FE_function(FDI_EU_5, 0, 1);
Debt_Equity_EU_5 = FE_function(Debt_Equity_EU_5, 0, 1);
Total_assets_EU_5 = FE_function(Total_assets_EU_5, 0, 1);

% Income risk sharing with Equity
Intterm1 = Trend' .* id_gdp_EU_5; % Interaction term: trend and GDP
Intterm2 = (E_EU_5 .* id_gdp_EU_5')'; % Interaction term: equity and GDP

result_e = OLSReg(id_gni_EU_5(:), [ones(K*T, 1), id_gdp_EU_5(:), Intterm1(:), Intterm2(:)]); % OLS regression

uI = result_e.u(:, 1); % Extract residuals
uIm = vec2mat(uI, T, K)'; % Reshape residuals to a matrix

varuI = std(uIm); % Compute standard deviation of residuals
varuIm = ones(T, 1) * varuI; % Create matrix of standard deviations

id_gni_e_EU_5 = id_gni_EU_5 ./ varuIm;
id_gdp_e_EU_5 = id_gdp_EU_5 ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_e = OLSReg(id_gni_e_EU_5(:), [ones(K*T, 1), id_gdp_e_EU_5(:), Intterm1(:), Intterm2(:)]); % Standardized regression

IntTermReg_e.b 
IntTermReg_e.tstat 

% Income risk sharing with Debt
Intterm1 = Trend' .* id_gdp_EU_5;
Intterm2 = (D_EU_5 .* id_gdp_EU_5')';

result_d = OLSReg(id_gni_EU_5(:), [ones(K*T, 1), id_gdp_EU_5(:), Intterm1(:), Intterm2(:)]);

uI = result_e.u(:, 1);
uIm = vec2mat(uI, T, K)';

varuI = std(uIm);
varuIm = ones(T, 1) * varuI;

id_gni_d_EU_5 = id_gni_EU_5 ./ varuIm;
id_gdp_d_EU_5 = id_gdp_EU_5 ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_d = OLSReg(id_gni_d_EU_5(:), [ones(K*T, 1), id_gdp_d_EU_5(:), Intterm1(:), Intterm2(:)]);

IntTermReg_d.b
IntTermReg_d.tstat

% Income risk sharing with FDI
Intterm1 = Trend' .* id_gdp_EU_5;
Intterm2 = (FDI_EU_5 .* id_gdp_EU_5')';

result_fdi = OLSReg(id_gni_EU_5(:), [ones(K*T, 1), id_gdp_EU_5(:), Intterm1(:), Intterm2(:)]);

uI = result_fdi.u(:, 1);
uIm = vec2mat(uI, T, K)';

varuI = std(uIm);
varuIm = ones(T, 1) * varuI;

id_gni_fdi_EU_5 = id_gni_EU_5 ./ varuIm;
id_gdp_fdi_EU_5 = id_gdp_EU_5 ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_fdi = OLSReg(id_gni_fdi_EU_5(:), [ones(K*T, 1), id_gdp_fdi_EU_5(:), Intterm1(:), Intterm2(:)]);

IntTermReg_fdi.b
IntTermReg_fdi.tstat

% Income risk sharing with Debt and Equity
Intterm1 = Trend' .* id_gdp_EU_5;
Intterm2 = (Debt_Equity_EU_5 .* id_gdp_EU_5')';

result_debt_equity = OLSReg(id_gni_EU_5(:), [ones(K*T, 1), id_gdp_EU_5(:), Intterm1(:), Intterm2(:)]);

uI = result_debt_equity.u(:, 1);
uIm = vec2mat(uI, T, K)';

varuI = std(uIm);
varuIm = ones(T, 1) * varuI;

id_gni_debt_equity_EU_5 = id_gni_EU_5 ./ varuIm;
id_gdp_debt_equity_EU_5 = id_gdp_EU_5 ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_debt_equity = OLSReg(id_gni_debt_equity_EU_5(:), [ones(K*T, 1), id_gdp_debt_equity_EU_5(:), Intterm1(:), Intterm2(:)]);

IntTermReg_debt_equity.b
IntTermReg_debt_equity.tstat

% Income risk sharing with All Assets
Intterm1 = Trend' .* id_gdp_EU_5;
Intterm2 = (Total_assets_EU_5 .* id_gdp_EU_5')';

result_total_assets = OLSReg(id_gni_EU_5(:), [ones(K*T, 1), id_gdp_EU_5(:), Intterm1(:), Intterm2(:)]);

uI = result_total_assets.u(:, 1);
uIm = vec2mat(uI, T, K)';

varuI = std(uIm);
varuIm = ones(T, 1) * varuI;

id_gni_assets_EU_5 = id_gni_EU_5 ./ varuIm;
id_gdp_assets_EU_5 = id_gdp_EU_5 ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_total_assets = OLSReg(id_gni_assets_EU_5(:), [ones(K*T, 1), id_gdp_assets_EU_5(:), Intterm1(:), Intterm2(:)]);

IntTermReg_total_assets.b
IntTermReg_total_assets.tstat

% Consumption risk sharing with Equity
Intterm1 = Trend' .* id_gdp_EU_5;
Intterm2 = (E_EU_5 .* id_gdp_EU_5')';

result_E = OLSReg(id_cons_EU_5(:), [ones(K*T, 1), id_gdp_EU_5(:), Intterm1(:), Intterm2(:)]);

uI = result_E.u(:, 1);
uIm = vec2mat(uI, T, K)';

varuI = std(uIm);
varuIm = ones(T, 1) * varuI;

id_cons_E_EU_5 = id_cons_EU_5 ./ varuIm;
id_gdp_E_EU_5 = id_gdp_EU_5 ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_E = OLSReg(id_cons_E_EU_5(:), [ones(K*T, 1), id_gdp_E_EU_5(:), Intterm1(:), Intterm2(:)]);

IntTermReg_E.b
IntTermReg_E.tstat

% Consumption risk sharing with Debt
Intterm1 = Trend' .* id_gdp_EU_5;
Intterm2 = (D_EU_5 .* id_gdp_EU_5')';

result_D = OLSReg(id_cons_EU_5(:), [ones(K*T, 1), id_gdp_EU_5(:), Intterm1(:), Intterm2(:)]);

uI = result_E.u(:, 1);
uIm = vec2mat(uI, T, K)';

varuI = std(uIm);
varuIm = ones(T, 1) * varuI;

id_cons_D_EU_5 = id_cons_EU_5 ./ varuIm;
id_gdp_D_EU_5 = id_gdp_EU_5 ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_D = OLSReg(id_cons_D_EU_5(:), [ones(K*T, 1), id_gdp_D_EU_5(:), Intterm1(:), Intterm2(:)]);

IntTermReg_D.b
IntTermReg_D.tstat

% Consumption risk sharing with FDI
Intterm1 = Trend' .* id_gdp_EU_5;
Intterm2 = (FDI_EU_5 .* id_gdp_EU_5')';

result_FDI = OLSReg(id_cons_EU_5(:), [ones(K*T, 1), id_gdp_EU_5(:), Intterm1(:), Intterm2(:)]);

uI = result_FDI.u(:, 1);
uIm = vec2mat(uI, T, K)';

varuI = std(uIm);
varuIm = ones(T, 1) * varuI;

id_cons_FDI_EU_5 = id_cons_EU_5 ./ varuIm;
id_gdp_FDI_EU_5 = id_gdp_EU_5 ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_FDI = OLSReg(id_cons_FDI_EU_5(:), [ones(K*T, 1), id_gdp_FDI_EU_5(:), Intterm1(:), Intterm2(:)]);

IntTermReg_FDI.b
IntTermReg_FDI.tstat

% Consumption risk sharing with Debt and Equity
Intterm1 = Trend' .* id_gdp_EU_5;
Intterm2 = (Debt_Equity_EU_5 .* id_gdp_EU_5')';

result_Debt_Equity = OLSReg(id_cons_EU_5(:), [ones(K*T, 1), id_gdp_EU_5(:), Intterm1(:), Intterm2(:)]);

uI = result_Debt_Equity.u(:, 1);
uIm = vec2mat(uI, T, K)';

varuI = std(uIm);
varuIm = ones(T, 1) * varuI;

id_cons_Debt_Equity_EU_5 = id_cons_EU_5 ./ varuIm;
id_gdp_Debt_Equity_EU_5 = id_gdp_EU_5 ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_Debt_Equity = OLSReg(id_cons_Debt_Equity_EU_5(:), [ones(K*T, 1), id_gdp_Debt_Equity_EU_5(:), Intterm1(:), Intterm2(:)]);

IntTermReg_Debt_Equity.b
IntTermReg_Debt_Equity.tstat

% Consumption risk sharing with All Assets
Intterm1 = Trend' .* id_gdp_EU_5;
Intterm2 = (Total_assets_EU_5 .* id_gdp_EU_5')';

result_Total_Assets = OLSReg(id_cons_EU_5(:), [ones(K*T, 1), id_gdp_EU_5(:), Intterm1(:), Intterm2(:)]);

uI = result_Total_Assets.u(:, 1);
uIm = vec2mat(uI, T, K)';

varuI = std(uIm);
varuIm = ones(T, 1) * varuI;

id_cons_Assets_EU_5 = id_cons_EU_5 ./ varuIm;
id_gdp_Assets_EU_5 = id_gdp_EU_5 ./ varuIm;
Intterm1 = Intterm1 ./ varuIm;
Intterm2 = Intterm2 ./ varuIm;

IntTermReg_Total_Assets = OLSReg(id_cons_Assets_EU_5(:), [ones(K*T, 1), id_gdp_Assets_EU_5(:), Intterm1(:), Intterm2(:)]);

IntTermReg_Total_Assets.b
IntTermReg_Total_Assets.tstat
