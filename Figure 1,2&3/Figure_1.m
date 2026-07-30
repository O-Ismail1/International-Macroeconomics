% Clear previous variables
clear;

% Define the file path
filePath = 'Equity_Home_Bias.xlsx';

% Read the data from the sheet 'Home_bias'
home_bias = readmatrix(filePath, 'Sheet', 'Equity Home Bias');

% Extract years (assuming they are in the first row, columns 2 to 19)
years = home_bias(1, 2:19)';

% Extract data for OECD_AVERAGE, Australia, UK, France, and US
OECD_AVERAGE = home_bias(25, 2:19)';
Australia = home_bias(2, 2:19)';
UK = home_bias(22, 2:19)';
France = home_bias(8, 2:19)';
US = home_bias(23, 2:19)';

mediumYellow = [1, 0.85, 0.1]; 
darkPurple = [0.5, 0, 0.5]; 

figure;
hold on;
plot(years, OECD_AVERAGE, 'bo-', 'MarkerFaceColor', 'b', 'DisplayName', 'OECD Average');
plot(years, Australia, 'ro-', 'MarkerFaceColor', 'r', 'DisplayName', 'Australia');
plot(years, UK, 'go-', 'MarkerFaceColor', 'g', 'DisplayName', 'UK');
plot(years, France, 'o-', 'Color', mediumYellow, 'MarkerFaceColor', mediumYellow, 'DisplayName', 'France');
plot(years, US, 'o-', 'Color', darkPurple, 'MarkerFaceColor', darkPurple, 'DisplayName', 'US');

% Add labels, title, legend, and grid
xlabel('Years');
ylabel('Equity Home Bias');
title('Figure 1');
legend('Location', 'best');
grid on;
hold off;
