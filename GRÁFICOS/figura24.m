%% ===============================
%  DADOS – NUMÉRICO (MEF)
%% ===============================
l = [170 190 210 240 280 320 360]; % Comprimentos (mm)

% Verde padrão MATLAB ('g')
green_print = [0 1 0];

%% ===============================
%  GRÁFICO 1 – RIGIDEZ × COMPRIMENTO (NUMÉRICO)
%% ===============================
k1_num = [2106.91 1527.52 1113.43 711.28 467.87 331.84 219.54]; % N/m

figure;
plot(l, k1_num, '^', ...
    'LineWidth', 1.8, ...
    'MarkerSize', 8, ...
    'MarkerFaceColor', green_print, ...
    'MarkerEdgeColor', green_print);

xlabel('l [mm]', 'FontSize', 12);
ylabel('k_1 [N/m]', 'FontSize', 12);
title('', 'FontSize', 14);

grid on;
set(gca, 'FontSize', 12);

% ---- CORREÇÃO DO PROBLEMA DO TEXTO FORA ----
offset = 0.08*k1_num + 40;
ylim([0 max(k1_num + offset)*1.05]);

for i = 1:length(l)
    text(l(i), k1_num(i) + offset(i), sprintf('%.2f', k1_num(i)), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'FontSize', 10, ...
        'Color', 'k');
end

% Tamanho fixo
set(gcf, 'Units', 'centimeters');
set(gcf, 'Position', [5 5 16 12]);

% SALVAMENTO EM ALTA RESOLUÇÃO
exportgraphics(gcf, 'Figura_24a.png', 'Resolution', 600);

%% ===============================
%  GRÁFICO 2 – FREQUÊNCIA × COMPRIMENTO (NUMÉRICO)
%% ===============================
wn_num = [96.98 80.91 69.50 54.80 43.61 35.30 29.19]; % rad/s

figure;
plot(l, wn_num, '^', ...
    'LineWidth', 1.8, ...
    'MarkerSize', 8, ...
    'MarkerFaceColor', green_print, ...
    'MarkerEdgeColor', green_print);

xlabel('l [mm]', 'FontSize', 12);
ylabel('\omega_n [rad/s]', 'FontSize', 12);
title('', 'FontSize', 14);

grid on;
set(gca, 'FontSize', 12);

% ---- AJUSTE DE ESCALA PARA TEXTO ----
offset = 0.08*wn_num;
ylim([0 max(wn_num + offset)*1.05]);

for i = 1:length(l)
    text(l(i), wn_num(i) + offset(i), sprintf('%.2f', wn_num(i)), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'bottom', ...
        'FontSize', 10, ...
        'Color', 'k');
end

% Tamanho fixo
set(gcf, 'Units', 'centimeters');
set(gcf, 'Position', [5 5 16 12]);

% SALVAMENTO EM ALTA RESOLUÇÃO
exportgraphics(gcf, 'Figura_24b.png', 'Resolution', 600);
