%% =====================================================
% FIGURA 29 – Resposta em frequência do sistema primário
% Abordagem EXPERIMENTAL – todos os comprimentos
% Salvamento automático em alta resolução
%% =====================================================

clear; clc;

%% -------------------------------
% DADOS EXPERIMENTAIS (Tabela 35)
%% -------------------------------
dados = [ ...
% l1  m1      k1    ADV  m2       k2     r_exp r_ideal  Xmin   F0
170  0.2179  3411  1    0.00904   38     1.046 0.990   0.43   5.25
190  0.2596  2432  2    0.08301   7334   1.127 0.929   1.45   3.65
210  0.2631  2009  2    0.08301   7334   1.110 0.929   1.59   2.88
240  0.2685  1301  2    0.08301   7334   5.373 0.931   0.02  42.86
280  0.2756   885  2    0.08301   7334   1.155 0.932   1.35   1.31
320  0.2827   588  2    0.08301   7334   8.200 0.934   0.01  42.86
360  0.2898   412  2    0.08301   7334   8.679 0.935   0.009 32.81 ];

ADV_nome = ["C3","A1"];

%% -------------------------------
% PARÂMETROS FIXOS
%% -------------------------------
zeta1 = 0.03;
zeta2 = 0.05;

cor_exp = [1 0 0];   % vermelho primário

labels = {'a','b','c','d','e','f','g'};

%% =====================================================
% LOOP – GERA E SALVA AS FIGURAS
%% =====================================================
for i = 1:size(dados,1)

    l1 = dados(i,1);
    m1 = dados(i,2);
    k1 = dados(i,3);
    adv_id = dados(i,4);
    m2 = dados(i,5);
    k2 = dados(i,6);
    F0 = dados(i,10);

    %% Sistema primário
    w1 = sqrt(k1/m1);
    c1 = 2*zeta1*m1*w1;

    %% Absorvedor
    w2 = sqrt(k2/m2);
    c2 = 2*zeta2*m2*w2;

    %% Frequência
    w = linspace(0.6*w1, 1.6*w1, 4000);

    %% Resposta SEM absorvedor
    X1_sem = F0 ./ sqrt((k1 - m1*w.^2).^2 + (c1*w).^2);

    %% Resposta COM absorvedor
    X1_com = zeros(size(w));
    for j = 1:length(w)
        W = w(j);
        Kd = [k1+k2 - m1*W^2 + 1i*W*(c1+c2),  -k2 - 1i*W*c2;
              -k2 - 1i*W*c2,                 k2 - m2*W^2 + 1i*W*c2];
        X = Kd\[F0; 0];
        X1_com(j) = abs(X(1));
    end

    %% -------------------------------
    % GRÁFICO
    %% -------------------------------
    fig = figure;

    plot(w, X1_sem, '-', 'Color', cor_exp, 'LineWidth', 1.8); hold on
    plot(w, X1_com, ':', 'Color', cor_exp, 'LineWidth', 2.0);

    xlabel('\omega [rad/s]', 'FontSize', 12);
    ylabel('X_1 [m]', 'FontSize', 12);

    legend([num2str(l1), ' mm'], ...
           ['Com ', char(ADV_nome(adv_id))], ...
           'Location','northwest');

    grid on;
    box on;

    %% -------------------------------
    % SALVAMENTO EM ALTA RESOLUÇÃO
    %% -------------------------------
    set(fig,'Units','centimeters');
    set(fig,'Position',[5 5 16 12]);   % padrão TCC

    nome_fig = ['Figura 29', labels{i}, '', num2str(l1), ''];

    print(fig, nome_fig, '-dpng', '-r300');   % PNG 300 dpi
    % print(fig, nome_fig, '-djpeg', '-r300'); % JPEG opcional

    close(fig);
end
