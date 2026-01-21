%% =========================================================
%  COMPARAÇÃO DOS ADV – RIGIDEZ E FREQUÊNCIA NATURAL
%  Padding visual | Legenda interna | Alta resolução
%% =========================================================

clear; clc; close all;

%% ===============================
% CORES PADRÃO (TCC) – PURAS
%% ===============================
red     = [1 0 0];   % Experimental
blue    = [0 0 1];   % Teórica
green   = [0 1 0];   % Numérica (MEF)
purple  = [1 0 1];   % Arruda (2017)

%% ===============================
% DADOS COMUNS – ADV
%% ===============================
ADV = categorical({'A1','A2','A3','A4','B1','B2','B3','C1','C2','C3','D1'});
ADV = reordercats(ADV, categories(ADV));

%% =========================================================
% GRÁFICO 1 – RIGIDEZ DOS ADV (Tabela 25)
%% =========================================================
k_exp = [3667 2699 21848 350 1585 94 671 145 85 19 21];
k_teo = [3397 2248 17298 352 1267 94 506 145 60 49 32];
k_num = [3869 2360 18109 359 1349 98 53 124 50 41 34];
k_arr = [13986 17157 NaN 2151 NaN NaN NaN 896 503 319 271];

figure; hold on; box on; grid on;

plot(ADV,k_exp,'o','MarkerSize',8,'MarkerFaceColor',red,'MarkerEdgeColor',red);
plot(ADV,k_teo,'s','MarkerSize',8,'MarkerFaceColor',blue,'MarkerEdgeColor',blue);
plot(ADV,k_num,'^','MarkerSize',9,'MarkerFaceColor',green,'MarkerEdgeColor',green);
plot(ADV,k_arr,'s','MarkerSize',8,'MarkerFaceColor',purple,'MarkerEdgeColor',purple);

xlabel('ADV');
ylabel('k_2 [N/m]');
title('');

legend('Exp','Teo','MEF','Arruda (2017)', ...
       'Location','northeast','Box','off');

set(gca,'FontSize',12);

% ===== PADDING VISUAL NO EIXO Y (SEGURO) =====
all_k = [k_exp k_teo k_num k_arr];
all_k = all_k(~isnan(all_k));
ymin = min(all_k);
ymax = max(all_k);
dy   = ymax - ymin;
ylim([ymin - 0.05*dy, ymax + 0.05*dy]);

% ===== AJUSTE AUTOMÁTICO PARA EVITAR CORTE =====
ax = gca;
ti = ax.TightInset;
ax.Position = [ti(1) ti(2) 1-ti(1)-ti(3) 1-ti(2)-ti(4)];

% Tamanho e salvamento
set(gcf,'Units','centimeters');
set(gcf,'Position',[5 5 16 12]);
exportgraphics(gcf,'Figura 26a.png','Resolution',600);

hold off;

%% =========================================================
% GRÁFICO 2 – FREQUÊNCIA NATURAL DOS ADV (Tabela 27)
%% =========================================================
w_exp = [148.00 157.20 659.31 53.95 213.99 38.00 235.17 52.07 49.21 32.65 14.20];
w_teo = [157.09 158.67 920.66 69.80 216.28 43.16 376.33 50.64 49.21 87.72 19.12];
w_num = [299.57 287.34 1125.32 105.64 373.43 76.22 385.84 93.11 80.48 92.00 35.89];
w_arr = [189.08 257.19 NaN 89.60 NaN NaN NaN 84.06 76.63 86.14 34.51];

figure; hold on; box on; grid on;

plot(ADV,w_exp,'o','MarkerSize',8,'MarkerFaceColor',red,'MarkerEdgeColor',red);
plot(ADV,w_teo,'s','MarkerSize',8,'MarkerFaceColor',blue,'MarkerEdgeColor',blue);
plot(ADV,w_num,'^','MarkerSize',9,'MarkerFaceColor',green,'MarkerEdgeColor',green);
plot(ADV,w_arr,'s','MarkerSize',8,'MarkerFaceColor',purple,'MarkerEdgeColor',purple);

xlabel('ADV');
ylabel('\omega_2 [rad/s]');
title('');

legend('Exp','Teo','MEF','Arruda (2017)', ...
       'Location','northeast','Box','off');

set(gca,'FontSize',12);

% ===== PADDING VISUAL NO EIXO Y (SEGURO) =====
all_w = [w_exp w_teo w_num w_arr];
all_w = all_w(~isnan(all_w));
ymin = min(all_w);
ymax = max(all_w);
dy   = ymax - ymin;
ylim([ymin - 0.05*dy, ymax + 0.05*dy]);

% ===== AJUSTE AUTOMÁTICO PARA EVITAR CORTE =====
ax = gca;
ti = ax.TightInset;
ax.Position = [ti(1) ti(2) 1-ti(1)-ti(3) 1-ti(2)-ti(4)];

% Tamanho e salvamento
set(gcf,'Units','centimeters');
set(gcf,'Position',[5 5 16 12]);
exportgraphics(gcf,'Figura 26b.png','Resolution',600);

hold off;
