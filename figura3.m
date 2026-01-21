%% =========================================================
% FRF – Sistema 1 GDL (forma adimensional)
%% =========================================================

% Limpar ambiente
clear; clc; close all;

% -------------------------
% Parâmetros do sistema
% -------------------------
wn   = 1;        % Frequência natural normalizada [rad/s]
zeta = 0.05;     % Fator de amortecimento (adimensional)

% Razão de frequências
r = linspace(0, 5, 500);   % r = w / wn

% -------------------------
% Função Resposta em Frequência (FRF)
% -------------------------
FRF = 1 ./ sqrt((1 - r.^2).^2 + (2*zeta*r).^2);

% -------------------------
% Plot do gráfico
% -------------------------
figure; hold on; box on;

plot(r, FRF, ...
    'b-', ...              % <<< LINHA AZUL
    'LineWidth', 1.6);

grid on;

xlabel('r = \omega / \omega_n', 'FontSize', 13);
ylabel('|X / F_0|', 'FontSize', 13);
title('', 'FontSize', 14);

xlim([0 5]);
ylim([0 8]);

set(gca, ...
    'FontSize', 12, ...
    'LineWidth', 1.1);

% =========================================================
% AJUSTE DE TAMANHO – PADRÃO ABNT
% =========================================================
set(gcf, 'Units', 'centimeters');
set(gcf, 'Position', [5 5 16 12]);   % [x y largura altura]

% =========================================================
% SALVAMENTO AUTOMÁTICO – ALTA QUALIDADE
% =========================================================

% Usa o mesmo nome do arquivo .m
nome_arquivo = mfilename;

% PDF vetorial (qualidade máxima)
print(gcf, nome_arquivo, '-dpdf', '-painters');

% PNG alta resolução (600 dpi – Word)
print(gcf, nome_arquivo, '-dpng', '-r600');
