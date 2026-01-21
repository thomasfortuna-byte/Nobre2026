%% =====================================================
% FIGURA 27 (a–g) – Efeito do absorvedor TEÓRICO no sistema primário
% Exportação automática em alta resolução
%% =====================================================
set(groot,'defaultAxesColorOrder',[0 0.4470 0.7410])
clear; clc;

%% -----------------------------------------------------
% TABELA TEÓRICA (dados consolidados)
%% -----------------------------------------------------
l_mm = [170 190 210 240 280 320 360];

m1 = [0.225661474 0.259593152 0.263147145 0.268478136 ...
      0.253412246 0.282694111 0.28980];

k1 = [2057.1 1473.5 1091.3 731.1 460.4 308.4 216.6];

ADV = {'B2','A1','A1','A1','D1','A1','A1'};

m2 = [0.03219 0.08301 0.08301 0.08301 0.051020747 0.08301145 0.08301];

k2 = [187.6 6794.3 6794.3 6794.3 64.62834512 6794.255765 6794];

F0 = [5.25 3.65 2.88 42.86 1.31 42.86 32.81];

%% -----------------------------------------------------
% PARÂMETROS FIXOS
%% -----------------------------------------------------
zeta1 = 0.03;
zeta2 = 0.05;

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

    % Resposta SEM absorvedor
    X1_sem = F0(i) ./ sqrt((k1(i) - m1(i)*w.^2).^2 + (c1*w).^2);

    % Resposta COM absorvedor
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
    fig = figure('Units','centimeters','Position',[5 5 16 12]);

    plot(w, X1_sem, '-', 'LineWidth', 1.8); hold on;
    plot(w, X1_com, ':', 'LineWidth', 2.0);

    xlabel('\omega [rad/s]', 'FontSize', 12);
    ylabel('X_1 [m]', 'FontSize', 12);

    legend([num2str(l_mm(i)), ' mm'], ...
           ['Com ADV ', ADV{i}], ...
           'Location','northwest');

    grid on;
    box on;

    %% -------------------------------
    % EXPORTAÇÃO EM ALTA RESOLUÇÃO
    %% -------------------------------
    filename = ['Figura_28', labels{i}, '_l', num2str(l_mm(i)), 'mm'];

    print(fig, filename, '-dpng', '-r300');   % PNG 300 dpi
    % print(fig, filename, '-djpeg', '-r300'); % JPEG (se quiser)

    close(fig);
end
