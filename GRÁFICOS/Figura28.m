%% =====================================================
% FIGURA – Resposta em frequência NUMÉRICA (MEF)
% Baseada na Tabela 33 – Seleção numérica do ADV ideal
% Salvamento automático em alta resolução
%% =====================================================

clear; clc;
set(groot,'defaultAxesColorOrder',[0 1 0])   % verde primário

%% -----------------------------------------------------
% DADOS NUMÉRICOS – TABELA 33
%% -----------------------------------------------------
l_mm = [170 190 210 240 280 320 360];

m1 = [0.2224 0.2560 0.2593 0.2491 0.2414 0.2771 0.2836];
k1 = [2106.7 1505.5 1113.4 674.0 467.9 312.9 219.5];

ADV = {'B2','A1','A1','A1','D1','A1','A1'};

m2 = [0.03374 0.08622 0.08622 0.08622 0.05248 0.08622 0.08622];
k2 = [196.0 7737.6 7737.6 7737.6 67.6 7737.6 7737.6];

F0 = [5.25 3.65 2.88 42.86 1.31 42.86 32.81];

%% -----------------------------------------------------
% PARÂMETROS DE AMORTECIMENTO
%% -----------------------------------------------------
zeta1 = 0.03;
zeta2 = 0.05;

corVerde = [0 1 0];

labels = {'a','b','c','d','e','f','g'};

%% -----------------------------------------------------
% LOOP – GERA E SALVA AS FIGURAS
%% -----------------------------------------------------
for i = 1:length(l_mm)

    % Sistema primário
    w1 = sqrt(k1(i)/m1(i));
    c1 = 2*zeta1*m1(i)*w1;

    % Absorvedor
    w2 = sqrt(k2(i)/m2(i));
    c2 = 2*zeta2*m2(i)*w2;

    % Faixa de frequência
    w = linspace(0.6*w1, 1.6*w1, 4000);

    % Resposta SEM ADV
    X1_sem = F0(i) ./ sqrt((k1(i) - m1(i)*w.^2).^2 + (c1*w).^2);

    % Resposta COM ADV
    X1_com = zeros(size(w));
    for j = 1:length(w)
        W = w(j);

        Kd = [k1(i)+k2(i)-m1(i)*W^2+1i*W*(c1+c2), -k2(i)-1i*W*c2;
              -k2(i)-1i*W*c2,                   k2(i)-m2(i)*W^2+1i*W*c2];

        X = Kd\[F0(i); 0];
        X1_com(j) = abs(X(1));
    end

    %% -------------------------------
    % GRÁFICO
    %% -------------------------------
    fig = figure;

    plot(w, X1_sem, '-', 'Color', corVerde, 'LineWidth', 1.8); hold on
    plot(w, X1_com, ':', 'Color', corVerde, 'LineWidth', 2.0);

    xlabel('\omega [rad/s]', 'FontSize', 12);
    ylabel('X_1 [m]', 'FontSize', 12);

    legend([num2str(l_mm(i)), ' mm'], ...
           ['Com ', ADV{i}], ...
           'Location','northwest');

    grid on;
    box on;

    %% -------------------------------
    % SALVAMENTO EM ALTA RESOLUÇÃO
    %% -------------------------------
    set(fig,'Units','centimeters');
    set(fig,'Position',[5 5 16 12]);   % padrão TCC

    nome_fig = ['Figura_28', labels{i}, '_l', num2str(l_mm(i)), 'mm'];

    print(fig, nome_fig, '-dpng', '-r300');   % PNG 300 dpi
    % print(fig, nome_fig, '-djpeg', '-r300'); % JPEG opcional

    close(fig);   % fecha a figura
end
