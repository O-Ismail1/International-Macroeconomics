clear 

filePath = 'C_GDP_GNI_WDI.xls'; % Specify the file path for the data file

gdp = readtable(filePath, 'Sheet', 'realGDPpc'); 
gni = readmatrix(filePath, 'Sheet', 'realGNIpc');
cons = readmatrix(filePath, 'Sheet', 'realCpc'); 

Years = gdp.Properties.VariableNames(17:28); % Extract the years from the first row of the GDP table
Years = str2double(cellfun(@(x) x(2:end), Years, 'UniformOutput', false)); % Remove the 'x' prefix and convert to numeric values

gdp = gdp{1:24,17:28}; % Extract rows and columns from the GDP table
gni = gni(1:24, 17:28); % Extract rows and columns from the GNI matrix
cons = cons(1:24, 17:28); % Extract rows and columns from the consumption matrix

GDP = sum(gdp); % Sum GDP for each year
Cons = sum(cons); % Sum consumption for each year
GNI = sum(gni); % Sum GNI for each year

GDP = repmat(GDP, 24, 1); % Repeat the summed GDP values for each row
GNI = repmat(GNI, 24, 1); % Repeat the summed GNI values for each row
Cons = repmat(Cons, 24, 1); % Repeat the summed consumption values for each row

dcons = diff(log(cons'))'; % Calculate the log difference for consumption
dgdp = diff(log(gdp'))'; % Calculate the log difference for GDP
dgni = diff(log(gni'))'; % Calculate the log difference for GNI

dGDP = diff(log(GDP'))'; % Calculate the log difference for the aggregate GDP
dGNI = diff(log(GNI'))'; % Calculate the log difference for the aggregate GNI
dCons = diff(log(Cons'))'; % Calculate the log difference for the aggregate consumption

id_gdp = (dgdp - dGDP)'; % Calculate the idiosyncratic component for GDP
id_gni = (dgni - dGNI)'; % Calculate the idiosyncratic component for GNI
id_cons = (dcons - dCons)'; % Calculate the idiosyncratic component for consumption

% Without Ireland and Iceland

gdpwo = gdp; 
gniwo = gni; 
conswo = cons; 

gdpwo([10, 11],: ) = []; % Remove Ireland and Iceland rows from GDP data
gniwo([10,11],:) = []; % Remove Ireland and Iceland rows from GNI data
conswo([10,11],:) = []; % Remove Ireland and Iceland rows from consumption data

GNIwo = sum(gniwo); 
GDPwo = sum(gdpwo); 
Conswo = sum(conswo); 

GDPwo = repmat(GDPwo, 22, 1);
GNIwo = repmat(GNIwo, 22, 1); 
Conswo = repmat(Conswo, 22, 1); 

dconswo = diff(log(conswo'))';
dgdpwo = diff(log(gdpwo'))'; 
dgniwo = diff(log(gniwo'))'; 

dGDPwo = diff(log(GDPwo'))'; 
dGNIwo = diff(log(GNIwo'))';
dConswo = diff(log(Conswo'))';

id_gdpwo = (dgdpwo - dGDPwo)'; 
id_gniwo = (dgniwo - dGNIwo)'; 
id_conswo = (dconswo - dConswo)'; 

% EU countries 13 Countries FOR TABLE 3

rows = [2,3,5,6,7,8,9,12,15,18,19,20,23]; % Indices of the selected EU countries

gdp_EU = gdp(rows,1:12); 
gni_EU = gni(rows,1:12); 
cons_EU = cons(rows,1:12);

GNI_EU = sum(gni_EU);
GDP_EU = sum(gdp_EU); 
Cons_EU = sum(cons_EU);

GDP_EU = repmat(GDP_EU, 13, 1); 
GNI_EU = repmat(GNI_EU, 13, 1); 
Cons_EU = repmat(Cons_EU, 13, 1); 

dcons_EU = diff(log(cons_EU'))'; 
dgdp_EU = diff(log(gdp_EU'))';
dgni_EU = diff(log(gni_EU'))'; 

dGDP_EU = diff(log(GDP_EU'))'; 
dGNI_EU = diff(log(GNI_EU'))';
dCons_EU = diff(log(Cons_EU'))';

id_gdp_EU = (dgdp_EU - dGDP_EU)';
id_gni_EU = (dgni_EU - dGNI_EU)'; 
id_cons_EU = (dcons_EU - dCons_EU)'; 

% EU countries (14) for TABLE 5

row = [2,3,5,6,7,8,9,11,12,15,18,19,20,23]; % Indices of the selected EU countries for Table 8

gdp_EU_5 = gdp(row,1:12);
gni_EU_5 = gni(row,1:12); 
cons_EU_5 = cons(row,1:12); 

GNI_EU_5 = sum(gni_EU_5); 
GDP_EU_5 = sum(gdp_EU_5); 
Cons_EU_5 = sum(cons_EU_5); 

GDP_EU_5 = repmat(GDP_EU_5, 14, 1);
GNI_EU_5 = repmat(GNI_EU_5, 14, 1);
Cons_EU_5= repmat(Cons_EU_5, 14, 1);

dcons_EU_5 = diff(log(cons_EU_5'))'; 
dgdp_EU_5 = diff(log(gdp_EU_5'))'; 
dgni_EU_5 = diff(log(gni_EU_5'))'; 

dGDP_EU_5 = diff(log(GDP_EU_5'))';
dGNI_EU_5 = diff(log(GNI_EU_5'))'; 
dCons_EU_5 = diff(log(Cons_EU_5'))'; 

id_gdp_EU_5 = (dgdp_EU_5 - dGDP_EU_5)'; 
id_gni_EU_5 = (dgni_EU_5 - dGNI_EU_5)';
id_cons_EU_5 = (dcons_EU_5 - dCons_EU_5)'; 

% Foreign assets in Portfolio

filePath = 'Portofolio_assets.xlsx'; % Specify the file path for the portfolio assets data

E = readmatrix(filePath, 'Sheet', 'Portfolio equity asset'); % Read the equity assets data
D = readmatrix(filePath, 'Sheet', 'Portfolio debt assets'); % Read the debt assets data
FDI = readmatrix(filePath, 'Sheet', 'FDI assets'); % Read the FDI assets data
GDP_L = readmatrix(filePath, 'Sheet', 'GDP'); % Read the GDP data

E = E(2:25,2:12);
D = D(2:25, 2:12); 
FDI = FDI(2:25, 2:12); 
GDP_L = GDP_L(2:25,2:12);

E_EU_5 = E(row,1:11);              % Extract equity assets data for the selected EU countries for Table 8
D_EU_5 = D(row, 1:11);             % Extract debt assets data for the selected EU countries for Table 8
FDI_EU_5 = FDI(row, 1:11);         % Extract FDI assets data for the selected EU countries for Table 8
GDP_L_EU_5 = GDP_L(row,1:11);      % Extract GDP data for the selected EU countries for Table 8

Total_assets = E + D + FDI;        % Calculate the total assets
Debt_Equity = E + D;               % Calculate the combined equity and debt assets

E = E ./ GDP_L;                    % Normalize equity assets by GDP
D = D ./ GDP_L;                    % Normalize debt assets by GDP
FDI = FDI ./ GDP_L;                 % Normalize FDI assets by GDP
Debt_Equity = Debt_Equity ./ GDP_L;        % Normalize combined equity and debt assets by GDP
Total_assets = Total_assets ./ GDP_L;      % Normalize total assets by GDP

E_mean = mean(E,1);                    % Calculate the mean of normalized equity assets
E_mean = repmat(E_mean, 24, 1);        % Repeat the mean equity assets values for each row
E = log(E);                            % Log-transform equity assets
E_mean = log(E_mean);                  % Log-transform mean equity assets
E = E - E_mean;                        % Center the equity assets data

D_mean = mean(D,1);                    % Calculate the mean of normalized debt assets
D_mean = repmat(D_mean, 24, 1); 
D = log(D); 
D_mean = log(D_mean);
D = D - D_mean;                        

FDI_mean = mean(FDI,1);                % Calculate the mean of normalized FDI assets
FDI_mean = repmat(FDI_mean, 24, 1); 
FDI = log(FDI); 
FDI_mean = log(FDI_mean);
FDI = FDI - FDI_mean;                  

Debt_Equity_mean = mean(Debt_Equity,1);                    % Calculate the mean of normalized combined equity and debt assets
Debt_Equity_mean = repmat(Debt_Equity_mean, 24, 1);
Debt_Equity = log(Debt_Equity); 
Debt_Equity_mean = log(Debt_Equity_mean); 
Debt_Equity = Debt_Equity - Debt_Equity_mean;              % Center the combined equity and debt assets data

Total_assets_mean = mean(Total_assets,1);                  % Calculate the mean of normalized total assets
Log_Total_assets_mean = log(Total_assets_mean); 
Total_assets_mean = repmat(Total_assets_mean, 24, 1); 
Log_Total_assets = log(Total_assets); 
Total_assets = Log_Total_assets - Total_assets_mean;       

% Foreign assets in Portfolio for EU 14 countries Table 5

Total_assets_EU_5 = E_EU_5 + D_EU_5 + FDI_EU_5;             % Calculate the total assets for the selected EU countries 
Debt_Equity_EU_5 = E_EU_5 + D_EU_5;                         % Calculate the combined equity and debt assets for the selected EU countries 

E_EU_5 = E_EU_5 ./ GDP_L_EU_5;                              % Normalize equity assets by GDP for the selected EU countries 
D_EU_5 = D_EU_5 ./ GDP_L_EU_5;                              % Normalize debt assets by GDP for the selected EU countries 
FDI_EU_5 = FDI_EU_5 ./ GDP_L_EU_5;                          % Normalize FDI assets by GDP for the selected EU countries 
Debt_Equity_EU_5 = Debt_Equity_EU_5 ./ GDP_L_EU_5;          % Normalize combined equity and debt assets by GDP for the selected EU countries 
Total_assets_EU_5 = Total_assets_EU_5 ./ GDP_L_EU_5;        % Normalize total assets by GDP for the selected EU countries 

E_mean_EU_5 = mean(E_EU_5, 1);                              % Calculate the mean of normalized equity assets for the selected EU countries 
E_mean_EU_5 = repmat(E_mean_EU_5, 14, 1); 
E_EU_5 = log(E_EU_5); 
E_mean_EU_5 = log(E_mean_EU_5);  
E_EU_5 = E_EU_5 - E_mean_EU_5;               

D_mean_EU_5 = mean(D_EU_5, 1);                              % Calculate the mean of normalized debt assets for the selected EU countries for Table 5
D_mean_EU_5 = repmat(D_mean_EU_5, 14, 1);
D_EU_5 = log(D_EU_5); 
D_mean_EU_5 = log(D_mean_EU_5); 
D_EU_5 = D_EU_5 - D_mean_EU_5; 

FDI_mean_EU_5 = mean(FDI_EU_5, 1);                          % Calculate the mean of normalized FDI assets for the selected EU countries for Table 8
FDI_mean_EU_5 = repmat(FDI_mean_EU_5, 14, 1);
FDI_EU_5 = log(FDI_EU_5); 
FDI_mean_EU_5 = log(FDI_mean_EU_5);
FDI_EU_5 = FDI_EU_5 - FDI_mean_EU_5; 

Debt_Equity_mean_EU_5 = mean(Debt_Equity_EU_5, 1);         % Calculate the mean of normalized combined equity and debt assets for the selected EU countries for Table 8
Debt_Equity_mean_EU_5 = repmat(Debt_Equity_mean_EU_5, 14, 1); 
Debt_Equity_EU_5 = log(Debt_Equity_EU_5); 
Debt_Equity_mean_EU_5 = log(Debt_Equity_mean_EU_5); 
Debt_Equity_EU_5 = Debt_Equity_EU_5 - Debt_Equity_mean_EU_5; 

Total_assets_mean_EU_5 = mean(Total_assets_EU_5, 1);        % Calculate the mean of normalized total assets for the selected EU countries for Table 8
Total_assets_mean_EU_5 = repmat(Total_assets_mean_EU_5, 14, 1); 
Log_Total_assets_EU_5 = log(Total_assets_EU_5); 
Log_Total_assets_mean_EU_5 = log(Total_assets_mean_EU_5); 
Total_assets_EU_5 = Log_Total_assets_EU_5 - Log_Total_assets_mean_EU_5;

% Equity & Debt home bias

filePath = 'Home_bias.xlsx'; 

EHB = readmatrix(filePath, 'Sheet', 'Equity_Home_Bias'); % Read the equity home bias data
EHB = EHB(2:25,2:12);                                    % Extract rows and columns for equity home bias
EHB_EU = EHB(rows,1:11);                          
EHB([10, 11],: ) = [];                                   % Remove data for Iceland and Ireland

EHB_mean = mean(EHB,1);                                  % Calculate the mean of equity home bias data
EHB_mean = repmat(EHB_mean, 22, 1);                      % Repeat the mean equity home bias values for each row
EHB = EHB - EHB_mean;                                    

EHB_EU_mean = mean(EHB_EU,1);                            % Calculate the mean of equity home bias data 
EHB_EU_mean = repmat(EHB_EU_mean, 13, 1);                % Repeat the mean equity home bias values for each rows
EHB_EU = EHB_EU - EHB_EU_mean; 

DHB = readmatrix(filePath, 'Sheet', 'Debt_Home_Bias');   % Read the debt home bias data
DHB = DHB(2:25,2:12);                                    % Extract rows and columns for debt home bias
DHB_EU = DHB(rows,1:11);                                 % Extract debt home bias data for the selected EU countries
DHB([10, 11],: ) = [];                                   % Remove data for Iceland and Ireland

DHB_mean = mean(DHB,1);                                  % Calculate the mean of debt home bias data
DHB_mean = repmat(DHB_mean, 22, 1);                      % Repeat the mean debt home bias values for each row
DHB = DHB - DHB_mean; 

DHB_EU_mean = mean(DHB_EU,1);                            % Calculate the mean of debt home bias data for the selected EU countries
DHB_EU_mean = repmat(DHB_EU_mean, 13, 1);                % Repeat the mean debt home bias values for each row for the selected EU countries
DHB_EU = DHB_EU - DHB_EU_mean; 
