clear  
load Data.mat  

[T,K]=size(id_gdpwo);  % Get the number of time periods (rows) and countries (columns) in id_gdpwo

Trend = 1:11;         % Define a trend for 11 periods
t = 6;                % Define a middle year for the trend
Trend = Trend-t;  
Trend = repmat(Trend, 22, 1);  % Repeat the trend for 22 countries

% controlling for country fixed effects
id_conswo=FE_function(id_conswo,0,1);
id_gdpwo=FE_function(id_gdpwo,0,1);
id_gniwo=FE_function(id_gniwo,0,1);
EHB=FE_function(EHB,0,1);
DHB=FE_function(DHB,0,1);
EHB_EU=FE_function(EHB_EU,0,1);
DHB_EU=FE_function(DHB_EU,0,1);

% Income risk sharing
% Equity Home Bias

Intterm1 = Trend'.*id_gdpwo;          % Interaction term between trend and GDP
Intterm2= EHB'.*id_gdpwo;             % Interaction term between Equity Home Bias and GDP

result_e = OLSReg(id_gniwo(:),[ones(K*T,1),id_gdpwo(:),Intterm1(:),Intterm2(:)]);  % Run OLS regression

uI=result_e.u(:,1);  % Get residuals from the regression
uIm=vec2mat(uI,T,K)';  % Reshape residuals into a matrix

varuI=std(uIm);  % Compute standard deviation of residuals
varuIm=ones(T,1)*varuI;  % Create a matrix of standard deviations

id_gniwo_e=id_gniwo./varuIm;
id_gdpwo_e=id_gdpwo./varuIm;
Intterm1=Intterm1./ varuIm;
Intterm2=Intterm2./ varuIm;

IntTermReg_e=OLSReg(id_gniwo_e(:),[ones(K*T,1),id_gdpwo_e(:),Intterm1(:),Intterm2(:)]);

IntTermReg_e.b  
IntTermReg_e.tstat

% Debt Home Bias

Intterm1 = Trend'.*id_gdpwo;        % Interaction term between trend and GDP
Intterm2= DHB'.*id_gdpwo;           % Interaction term between Debt Home Bias and GDP

result_d = OLSReg(id_gniwo(:),[ones(K*T,1),id_gdpwo(:),Intterm1(:),Intterm2(:)]);  % Run OLS regression

uI=result_d.u(:,1);  
uIm=vec2mat(uI,T,K)';  

varuI=std(uIm); 
varuIm=ones(T,1)*varuI;  

id_gniwo_d=id_gniwo./varuIm;
id_gdpwo_d=id_gdpwo./varuIm;
Intterm1=Intterm1./ varuIm;
Intterm2=Intterm2./ varuIm;

IntTermReg_d=OLSReg(id_gniwo_d(:),[ones(K*T,1),id_gdpwo_d(:),Intterm1(:),Intterm2(:)]);

IntTermReg_d.b  
IntTermReg_d.tstat  

% Consumption risk sharing
% Equity Home Bias

Intterm1 = Trend'.*id_gdpwo;          % Interaction term between trend and GDP
Intterm2= EHB'.*id_gdpwo;             % Interaction term between Equity Home Bias and GDP

result_E = OLSReg(id_conswo(:),[ones(K*T,1),id_gdpwo(:),Intterm1(:),Intterm2(:)]);  % Run OLS regression

uI=result_E.u(:,1);  
uIm=vec2mat(uI,T,K)';  

varuI=std(uIm);  
varuIm=ones(T,1)*varuI;  

id_conswo_E=id_conswo./varuIm;
id_gdpwo_E=id_gdpwo./varuIm;
Intterm1=Intterm1./ varuIm;
Intterm2=Intterm2./ varuIm;

IntTermReg_E=OLSReg(id_conswo_E(:),[ones(K*T,1),id_gdpwo_E(:),Intterm1(:),Intterm2(:)]);

IntTermReg_E.b 
IntTermReg_E.tstat  

% Debt Home Bias

Intterm1 = Trend'.*id_gdpwo;               % Interaction term between trend and GDP
Intterm2= DHB'.*id_gdpwo;                  % Interaction term between Debt Home Bias and GDP

result_D = OLSReg(id_conswo(:),[ones(K*T,1),id_gdpwo(:),Intterm1(:),Intterm2(:)]);  % Run OLS regression

uI=result_D.u(:,1);  
uIm=vec2mat(uI,T,K)';  

varuI=std(uIm);  
varuIm=ones(T,1)*varuI;  

id_conswo_D=id_conswo./varuIm;
id_gdpwo_D=id_gdpwo./varuIm;
Intterm1=Intterm1./ varuIm;
Intterm2=Intterm2./ varuIm;

IntTermReg_D=OLSReg(id_conswo_D(:),[ones(K*T,1),id_gdpwo_D(:),Intterm1(:),Intterm2(:)]);

IntTermReg_D.b  
IntTermReg_D.tstat  

% Income risk sharing for EU
% Equity Home Bias

[T,K]=size(id_gdp_EU);  % Get the number of time periods and countries in id_gdp_EU

Trend = 1:11;  
t = 6;  
Trend = Trend-t;  
Trend = repmat(Trend, 13, 1); 

Intterm1 = Trend'.*id_gdp_EU;  % Interaction term between trend and GDP
Intterm2= EHB_EU'.*id_gdp_EU;  % Interaction term between Equity Home Bias and GDP

result_EU_e = OLSReg(id_gni_EU(:),[ones(K*T,1),id_gdp_EU(:),Intterm1(:),Intterm2(:)]);  % Run OLS regression

uI=result_EU_e.u(:,1); 
uIm=vec2mat(uI,T,K)';  

varuI=std(uIm);  
varuIm=ones(T,1)*varuI;  

id_gni_EU_e=id_gni_EU./varuIm;
id_gdp_EU_e=id_gdp_EU./varuIm;
Intterm1=Intterm1./ varuIm;
Intterm2=Intterm2./ varuIm;

IntTermReg_EU_e=OLSReg(id_gni_EU_e(:),[ones(K*T,1),id_gdp_EU_e(:),Intterm1(:),Intterm2(:)]);

IntTermReg_EU_e.b 
IntTermReg_EU_e.tstat  

% Debt Home Bias

Intterm1 = Trend'.*id_gdp_EU;  % Interaction term between trend and GDP
Intterm2= DHB_EU'.*id_gdp_EU;  % Interaction term between Debt Home Bias and GDP

result_EU_d = OLSReg(id_gni_EU(:),[ones(K*T,1),id_gdp_EU(:),Intterm1(:),Intterm2(:)]);  % Run OLS regression

uI=result_EU_d.u(:,1);  
uIm=vec2mat(uI,T,K)'; 

varuI=std(uIm);  
varuIm=ones(T,1)*varuI; 

id_gni_EU_d=id_gni_EU./varuIm;
id_gdp_EU_d=id_gdp_EU./varuIm;
Intterm1=Intterm1./ varuIm;
Intterm2=Intterm2./ varuIm;

IntTermReg_EU_d=OLSReg(id_gni_EU_d(:),[ones(K*T,1),id_gdp_EU_d(:),Intterm1(:),Intterm2(:)]);

IntTermReg_EU_d.b  
IntTermReg_EU_d.tstat 

% Consumption risk sharing for EU
% Equity Home Bias

Intterm1 = Trend'.*id_gdp_EU;  % Interaction term between trend and GDP
Intterm2= EHB_EU'.*id_gdp_EU;  % Interaction term between Equity Home Bias and GDP

result_EU_E = OLSReg(id_cons_EU(:),[ones(K*T,1),id_gdp_EU(:),Intterm1(:),Intterm2(:)]);  % Run OLS regression

uI=result_EU_E.u(:,1);  
uIm=vec2mat(uI,T,K)'; 

varuI=std(uIm); 
varuIm=ones(T,1)*varuI;  

id_cons_EU_E=id_cons_EU./varuIm;
id_gdp_EU_E=id_gdp_EU./varuIm;
Intterm1=Intterm1./ varuIm;
Intterm2=Intterm2./ varuIm;

IntTermReg_EU_E=OLSReg(id_cons_EU_E(:),[ones(K*T,1),id_gdp_EU_E(:),Intterm1(:),Intterm2(:)]);

IntTermReg_EU_E.b
IntTermReg_EU_E.tstat 

% Debt Home Bias

Intterm1 = Trend'.*id_gdp_EU;  % Interaction term between trend and GDP
Intterm2= DHB_EU'.*id_gdp_EU;  % Interaction term between Debt Home Bias and GDP

result_EU_D = OLSReg(id_cons_EU(:),[ones(K*T,1),id_gdp_EU(:),Intterm1(:),Intterm2(:)]);  % Run OLS regression

uI=result_EU_D.u(:,1);  
uIm=vec2mat(uI,T,K)'; 

varuI=std(uIm);  
varuIm=ones(T,1)*varuI;

id_cons_EU_D=id_cons_EU./varuIm;
id_gdp_EU_D=id_gdp_EU./varuIm;
Intterm1=Intterm1./ varuIm;
Intterm2=Intterm2./ varuIm;

IntTermReg_EU_D=OLSReg(id_cons_EU_D(:),[ones(K*T,1),id_gdp_EU_D(:),Intterm1(:),Intterm2(:)]);

IntTermReg_EU_D.b  
IntTermReg_EU_D.tstat  

Trend_EU = 1:11
t = 6
Trend_EU = Trend_EU-t
Trend_EU = repmat(Trend_EU, 13, 1); 

Intterm1 = Trend_EU'.*id_gdp_EU;          % Interaction term between trend and GDP
Intterm2= EHB_EU'.*id_gdp_EU;             % Interaction term between Equity Home Bias and GDP
Intterm3 = DHB_EU'.*id_gdp_EU

result_eEU = OLSReg(id_cons_EU(:),[ones(K*T,1),id_gdp_EU(:),Intterm1(:),Intterm2(:),Intterm3(:)]);  % Run OLS regression

uI=result_e.u(:,1);  % Get residuals from the regression
uIm=vec2mat(uI,T,K)';  % Reshape residuals into a matrix

varuI=std(uIm);  % Compute standard deviation of residuals
varuIm=ones(T,1)*varuI;  % Create a matrix of standard deviations

id_cons_e_EU=id_cons_EU./varuIm;
id_gdp_e_EU=id_gdp_EU./varuIm;
Intterm1=Intterm1./ varuIm;
Intterm2=Intterm2./ varuIm;
Intterm3=Intterm3./ varuIm;

IntTermReg_x_EU=OLSReg(id_cons_e_EU(:),[ones(K*T,1),id_gdp_e_EU(:),Intterm1(:),Intterm2(:),Intterm3(:)]);

IntTermReg_e.b  
IntTermReg_e.tstat


