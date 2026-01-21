%% =====================================================
% FIGURA 31 – Comparação entre abordagens
% (a) l1 = 170 mm – ADV B2
% (b) l1 = 280 mm – ADV D1
% Teórica × Numérica (MEF) × Experimental
% Salvamento automático em alta resolução
%% =====================================================

clear; clc;

%% -------------------------------
% CORES (PRIMÁRIAS)
%% -------------------------------
cor_teo = [0 0 1];   % azul
cor_mef = [0 1 0];   % verde
cor_exp = [1 0 0];   % vermelho

%% -------------------------------
% AMORTECIMENTOS
%% -------------------------------
zeta1 = 0.03;
zeta2 = 0.05;

%% -------------------------------
% CASOS ANALISADOS
%% -------------------------------
labels = {'170 mm - B2','280 mm - D1'};
l1_vals = [170 280];
ADV_case = {'B2','D1'};

%% =====================================================
% LOOP DOS CASOS
%% =====================================================
for c = 1:2

    l1 = l1_vals(c);

    %% -------------------------------
    % DADOS POR CASO
    %% -------------------------------
    if l1 == 170   % ===== ADV B2 =====

        % TEÓRICO
        m1_teo = 0.22566; k1_teo = 2057.1;
        m2_teo = 0.03219; k2_teo = 187.6;
        F0_teo = 5.25;

        % MEF
        m1_mef = 0.2224;  k1_mef = 2106.7;
        m2_mef = 0.03374; k2_mef = 196.0;
        F0_mef = 5.25;

        % EXPERIMENTAL
        m1_exp = 0.2179;  k1_exp = 3411;
        m2_exp = 0.00904; k2_exp = 38;
        F0_exp = 5.25;

    elseif l1 == 280   % ===== ADV D1 =====

        % TEÓRICO
        m1_teo = 0.25341; k1_teo = 460.4;
        m2_teo = 0.05102; k2_teo = 64.6;
        F0_teo = 1.31;

        % MEF
        m1_mef = 0.2414;  k1_mef = 467.9;
        m2_mef = 0.05248; k2_mef = 67.6;
        F0_mef = 1.31;

        % EXPERIMENTAL
        m1_exp = 0.2756;  k1_exp = 885;
        m2_exp = 0.08301; k2_exp = 7334;
        F0_exp = 1.31;
    end

    %% -------------------------------
    % VETOR DE FREQUÊNCIA
    %% -------------------------------
    w1_ref = sqrt(k1_teo/m1_teo);
    w = linspace(0.6*w1_ref, 1.6*w1_ref, 4000);

    %% -------------------------------
    % FRFs
    %% -------------------------------
    [Xteo_sem, Xteo_com] = FRF(m1_teo,k1_teo,m2_teo,k2_teo,F0_teo,w,zeta1,zeta2);
    [Xmef_sem, Xmef_com] = FRF(m1_mef,k1_mef,m2_mef,k2_mef,F0_mef,w,zeta1,zeta2);
    [Xexp_sem, Xexp_com] = FRF(m1_exp,k1_exp,m2_exp,k2_exp,F0_exp,w,zeta1,zeta2);

    %% -------------------------------
    % GRÁFICO
    %% -------------------------------
    fig = figure; hold on;

    % TEÓRICO
    plot(w, Xteo_sem, '-',  'Color', cor_teo, 'LineWidth', 1.8);
    plot(w, Xteo_com, '--', 'Color', cor_teo, 'LineWidth', 2.2);

    % MEF
    plot(w, Xmef_sem, '-',  'Color', cor_mef, 'LineWidth', 1.8);
    plot(w, Xmef_com, '--', 'Color', cor_mef, 'LineWidth', 2.2);

    % EXPERIMENTAL
    plot(w, Xexp_sem, '-',  'Color', cor_exp, 'LineWidth', 1.8);
    plot(w, Xexp_com, '--', 'Color', cor_exp, 'LineWidth', 2.2);

    xlabel('\omega [rad/s]', 'FontSize', 12);
    ylabel('X_1 [m]', 'FontSize', 12);

    text(0.02,0.95,['',labels{c},''], ...
        'Units','normalized','FontSize',13,'FontWeight','bold');

    grid on; box on;

    %% -------------------------------
    % SALVAMENTO EM ALTA RESOLUÇÃO
    %% -------------------------------
    set(fig,'Units','centimeters');
    set(fig,'Position',[5 5 16 12]);   % padrão TCC

    nome_fig = ['Figura 31', labels{c}, '', num2str(l1), ''];

    print(fig, nome_fig, '-dpng', '-r300');    % PNG 300 dpi
    % print(fig, nome_fig, '-dpdf', '-painters'); % PDF vetorial (opcional)

    close(fig);
end

%% =====================================================
% FUNÇÃO LOCAL – FRF
%% =====================================================
function [X1_sem, X1_com] = FRF(m1,k1,m2,k2,F0,w,zeta1,zeta2)

    w1 = sqrt(k1/m1);
    w2 = sqrt(k2/m2);

    c1 = 2*zeta1*m1*w1;
    c2 = 2*zeta2*m2*w2;

    % SEM absorvedor
    X1_sem = F0 ./ sqrt((k1 - m1*w.^2).^2 + (c1*w).^2);

    % COM absorvedor
    X1_com = zeros(size(w));
    for i = 1:length(w)
        W = w(i);
        Kd = [k1+k2 - m1*W^2 + 1i*W*(c1+c2), -k2 - 1i*W*c2;
              -k2 - 1i*W*c2,                k2 - m2*W^2 + 1i*W*c2];
        X = Kd\[F0;0];
        X1_com(i) = abs(X(1));
    end
end
