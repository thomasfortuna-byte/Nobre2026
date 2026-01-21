%% ===============================
% CORES PADRÃO (TCC) – CORES PURAS
% ===============================
red     = [1 0 0];   % Experimental
blue    = [0 0 1];   % Teórica
green   = [0 1 0];   % Numérica (MEF)
purple  = [1 0 1];   % Arruda (2017)

%% ===============================
% DADOS – TABELA 19
%% ===============================
l = [170 190 210 240 280 320 360]; % [mm]

w_exp = [121.79 102.05 92.05 73.26 59.55 47.86 39.52];
w_teo = [94.51 79.38 67.78 54.84 42.90 34.62 28.85];
w_num = [96.98 80.91 69.50 54.80 43.61 35.30 29.19];
w_arr = [123.513 121.840 93.336 71.789 56.471 47.122 43.788];

%% ===============================
% GRÁFICO – FREQUÊNCIA × COMPRIMENTO
%% ===============================
figure; hold on;

plot(l, w_exp, 'o', 'MarkerSize',8, 'MarkerFaceColor',red,'MarkerEdgeColor',red);
plot(l, w_teo, 's', 'MarkerSize',8, 'MarkerFaceColor',blue,'MarkerEdgeColor',blue);
plot(l, w_num, '^', 'MarkerSize',9, 'MarkerFaceColor',green,'MarkerEdgeColor',green);
plot(l, w_arr, 's', 'MarkerSize',8, 'MarkerFaceColor',purple,'MarkerEdgeColor',purple);

xlabel(' l [mm]');
ylabel('\omega_1 [rad/s]');
title('');

legend('Exp','Teo','MEF','Arruda (2017)', ...
       'Location','northeast');

grid on;
set(gca,'FontSize',12);

% --- PADRÃO DE FIGURA ---
set(gcf,'Units','centimeters');
set(gcf,'Position',[5 5 16 12]);

% --- SALVAMENTO EM ALTA RESOLUÇÃO ---
exportgraphics(gcf,'Figura 25a.png','Resolution',600);

hold off;

%% ===============================
% DADOS – TABELA 17
%% ===============================
k_exp = [3411 2432 2009 1301 885 588 412];
k_teo = [2057.10 1473.47 1091.30 731.08 460.39 308.43 216.62];
k_num = [2106.91 1527.52 1113.43 711.28 467.87 331.84 219.54];
k_arr = [1969.46 1969.46 1186.86 729.72 474.30 346.10 312.55];

%% ===============================
% GRÁFICO – RIGIDEZ × COMPRIMENTO
%% ===============================
figure; hold on;

plot(l, k_exp, 'o', 'MarkerSize',8, 'MarkerFaceColor',red,'MarkerEdgeColor',red);
plot(l, k_teo, 's', 'MarkerSize',8, 'MarkerFaceColor',blue,'MarkerEdgeColor',blue);
plot(l, k_num, '^', 'MarkerSize',9, 'MarkerFaceColor',green,'MarkerEdgeColor',green);
plot(l, k_arr, 's', 'MarkerSize',8, 'MarkerFaceColor',purple,'MarkerEdgeColor',purple);

xlabel(' l [mm]');
ylabel(' k_1 [N/m]');
title('');

legend('Exp','Teo','MEF','Arruda (2017)', ...
       'Location','northeast');

grid on;
set(gca,'FontSize',12);

% --- PADRÃO DE FIGURA ---
set(gcf,'Units','centimeters');
set(gcf,'Position',[5 5 16 12]);

% --- SALVAMENTO EM ALTA RESOLUÇÃO ---
exportgraphics(gcf,'Figura 25b.png','Resolution',600);

hold off;
