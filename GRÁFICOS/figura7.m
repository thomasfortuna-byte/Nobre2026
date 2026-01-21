%% =========================================================
% FIGURA 7 – Amplitudes do sistema com diferentes fatores
% de amortecimento (Rao, 2017; Inman, 2018)
%% =========================================================

clear; clc; close all;

%% -------------------------
% Parâmetros adimensionais
%% -------------------------
mu   = 0.05;                 % razão de massas
beta = 1.0;                  % absorvedor sintonizado
r    = linspace(0.8, 1.2, 4000);  % razão de frequência

% Fatores de amortecimento (inclui ζ → ∞)
zeta_vals = [0 0.01 0.05 0.1 0.4 100];  % 100 → aproxima ζ → ∞

% Cores puras e bem contrastantes
cores = [
    0   0   0 ;    % preto
    1   0   0 ;    % vermelho
    0   0   1 ;    % azul
    0   0.6 0 ;    % verde escuro
    0.6 0   0.6 ;  % roxo
    0.5 0.5 0.5    % cinza (ζ → ∞)
];

%% -------------------------
% Gráfico
%% -------------------------
figure; hold on; box on; grid on;

for i = 1:length(zeta_vals)
    zeta = zeta_vals(i);

    % Equação adimensional da amplitude (Eq. 17)
    num = (2*zeta*r).^2 + (r.^2 - beta^2).^2;

    den = (2*zeta*r).^2 .* (r.^2 - 1 + mu*r.^2).^2 + ...
          (mu*beta^2*r.^2 - (r.^2 - 1).*(r.^2 - beta^2)).^2;

    X = sqrt(num ./ den);

    plot(r, X, ...
        'LineWidth', 1.2, ...
        'Color', cores(i,:));
end

%% -------------------------
% Formatação
%% -------------------------
xlabel('\omega / \omega_n','FontSize',12);
ylabel('X_1 / \delta_{st}','FontSize',12);

legend('\zeta = 0', ...
       '\zeta = 0.01', ...
       '\zeta = 0.05', ...
       '\zeta = 0.1', ...
       '\zeta = 0.4', ...
       '\zeta \rightarrow \infty', ...
       'Location','northeast','Box','off');

xlim([0.82 1.18]);
ylim([0 55]);

set(gca,'FontSize',12);

%% -------------------------
% Ajuste automático (evita corte)
%% -------------------------
ax = gca;
ti = ax.TightInset;
ax.Position = [ ...
    ti(1), ...
    ti(2), ...
    1 - ti(1) - ti(3), ...
    1 - ti(2) - ti(4) ];

%% -------------------------
% Salvamento em alta resolução
%% -------------------------
set(gcf,'Units','centimeters');
set(gcf,'Position',[5 5 16 12]);

exportgraphics(gcf,'Figura_7_amplitudes_vs_frequencia.png','Resolution',600);
