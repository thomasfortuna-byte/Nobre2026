%% ===============================
%  DADOS COMUNS – TEÓRICO
%% ===============================
l = [170 190 210 240 280 320 360]; % Comprimentos (mm)

% Azul padrão MATLAB (teórico)
blue_print = [0 0.4470 0.7410];

%% ===============================
%  GRÁFICO 1 – RIGIDEZ × COMPRIMENTO (TEÓRICO)
%% ===============================
k1 = [2057 1473 1091 731 460 308 217]; % Rigidez teórica (N/m)

figure;
plot(l, k1, 's', ...
    'LineWidth', 1.8, ...
    'MarkerSize', 8, ...
    'MarkerFaceColor', blue_print, ...
    'MarkerEdgeColor', blue_print);

xlabel('l [mm]', 'FontSize', 12);
ylabel('k_1 [N/m]', 'FontSize', 12);
title('', 'FontSize', 14);

grid on;
set(gca, 'FontSize', 12);
hold on;

% Offset e limite correto do eixo Y
offset = 0.08 * k1;
ylim([0 max(k1 + offset) * 1.05]);

dx = 6;  % deslocamento horizontal do texto (mm)

for i = 1:length(l)
    text(l(i) + dx, k1(i) + offset(i), sprintf('%.0f', k1(i)), ...
        'HorizontalAlignment', 'left', ...
        'VerticalAlignment', 'bottom', ...
        'FontSize', 10, ...
        'Color', 'k');
end

% Tamanho fixo (padrão TCC)
set(gcf, 'Units', 'centimeters');
set(gcf, 'Position', [5 5 16 12]);

% Salvamento em alta resolução
exportgraphics(gcf, 'Figura_23a.png', 'Resolution', 600);

%% ===============================
%  GRÁFICO 2 – FREQUÊNCIA × COMPRIMENTO (TEÓRICO)
%% ===============================
wn = [98.23 82.45 70.38 56.92 44.47 35.86 29.62]; % Frequência natural teórica (rad/s)

figure;
plot(l, wn, 's', ...
    'LineWidth', 1.8, ...
    'MarkerSize', 8, ...
    'MarkerFaceColor', blue_print, ...
    'MarkerEdgeColor', blue_print);

xlabel('l [mm]', 'FontSize', 12);
ylabel('\omega_n [rad/s]', 'FontSize', 12);
title('', 'FontSize', 14);

grid on;
set(gca, 'FontSize', 12);
hold on;

% Offset e limite correto do eixo Y
offset = 0.08 * wn;
ylim([0 max(wn + offset) * 1.05]);

dx = 6;  % deslocamento horizontal do texto

for i = 1:length(l)
    text(l(i) + dx, wn(i) + offset(i), sprintf('%.2f', wn(i)), ...
        'HorizontalAlignment', 'left', ...
        'VerticalAlignment', 'bottom', ...
        'FontSize', 10, ...
        'Color', 'k');
end

% Tamanho fixo
set(gcf, 'Units', 'centimeters');
set(gcf, 'Position', [5 5 16 12]);

% Salvamento em alta resolução
exportgraphics(gcf, 'Figura_23b.png', 'Resolution', 600);
