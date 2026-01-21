%% =========================================================
% Efeito do Absorvedor Dinâmico na Resposta do Sistema
%% =========================================================

% Limpar ambiente
clear; clc; close all;

% -------------------------
% Parâmetros do sistema
% -------------------------
k1 = 1;            % Rigidez do sistema principal
m1 = 1;            % Massa principal
k2_k1 = 0.05;      % Relação k2/k1
m2_m1 = 0.05;      % Relação m2/m1

% -------------------------
% Frequências naturais
% -------------------------
omega1 = sqrt(k1 / m1);                          
omega2 = sqrt((k2_k1 * k1) / (m2_m1 * m1));      

% -------------------------
% Faixa de frequências
% -------------------------
r = linspace(0.6, 1.3, 1000);     % r = w / w1
omega = r * omega1;

% -------------------------
% Resposta com absorvedor
% -------------------------
X1_delta_st = zeros(size(r));

for i = 1:length(r)
    w = omega(i);
    
    den = (1 + k2_k1 - (w / omega1)^2) * ...
          (1 - (w / omega2)^2) - k2_k1;
    
    X1_delta_st(i) = abs((1 - (w / omega2)^2) / den);
end

% -------------------------
% Resposta sem absorvedor
% -------------------------
X1_no_absorber = 1 ./ abs(1 - r.^2);

% -------------------------
% Plot do gráfico
% -------------------------
figure; hold on; box on;

plot(r, X1_delta_st, ...
    'b-', ...                 % Azul sólido – com ADV
    'LineWidth', 1.8);

plot(r, X1_no_absorber, ...
    'r--', ...                % Vermelho tracejado – sem ADV
    'LineWidth', 1.8);

grid on;

xlabel('\omega / \omega_1', 'FontSize', 13);
ylabel('X_1 / \delta_{st}', 'FontSize', 13);

legend('Com ADV', ...
       'Sem ADV', ...
       'Location', 'northwest');

xlim([0.6 1.3]);
ylim([0 16]);

set(gca, ...
    'FontSize', 12, ...
    'LineWidth', 1.1);

set(gcf, 'Color', 'w');   % Fundo branco

% =========================================================
% AJUSTE DE TAMANHO – PADRÃO ABNT
% =========================================================
set(gcf, 'Units', 'centimeters');
set(gcf, 'Position', [5 5 16 12]);   % [x y largura altura]

% =========================================================
% SALVAMENTO AUTOMÁTICO – ALTA QUALIDADE
% =========================================================

% Nome igual ao arquivo .m
nome_arquivo = mfilename;

% PDF vetorial (qualidade máxima)
print(gcf, nome_arquivo, '-dpdf', '-painters');

% PNG 600 dpi (Word / apresentações)
print(gcf, nome_arquivo, '-dpng', '-r600');
