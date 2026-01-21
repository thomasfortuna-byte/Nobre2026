% Caminho dos arquivos
pasta = 'C:\Users\Prefeitura\Desktop\TCC 2026\Nobre2026ADVabordagemteonumexp\Ensaio de Flexão\ENSAIOS\Curvas';

% Listar todos os arquivos .txt da pasta
arquivos = dir(fullfile(pasta, '*.txt'));

% Criar figura
figure;
hold on;

% Paleta de cores
cores = lines(10);

% Inicializar estrutura de agrupamento
milimetragens = {};
grupos = containers.Map;

% Agrupar arquivos por milimetragem
for k = 1:length(arquivos)
    nome = arquivos(k).name;
    expr = regexp(nome, '(\d+)\s*mm', 'tokens');
    if ~isempty(expr)
        mm = [expr{1}{1} ' mm'];
        if ~isKey(grupos, mm)
            grupos(mm) = {};
            milimetragens{end+1} = mm;
        end
        lista = grupos(mm);
        lista{end+1} = fullfile(pasta, nome);
        grupos(mm) = lista;
    end
end

% Vetor comum de deformação
x_padrao = linspace(0, 1.2, 300);

% Acumulador de todas as curvas interpoladas
todas_forcas_interp = [];

% Inicializador das médias de rigidez por grupo
media_rigidez_por_mm = zeros(1, length(milimetragens));

% Criar arquivo de saída da rigidez
arquivo_saida = fullfile(pasta, 'rigidez_resultado.txt');
fid = fopen(arquivo_saida, 'w');

% Loop por grupo
for i = 1:length(milimetragens)
    mm = milimetragens{i};
    arquivosDoGrupo = grupos(mm);

    forcas_interp = [];
    rigidezes_individuais = [];

    for j = 1:length(arquivosDoGrupo)
        % Ler dados
        opts = detectImportOptions(arquivosDoGrupo{j}, 'Delimiter', '\t');
        opts.VariableNames = {'Tempo', 'Deformacao', 'Forca'};
        dados = readtable(arquivosDoGrupo{j}, opts);

        % Plotar curva individual
        plot(dados.Deformacao, dados.Forca, ...
            'Color', cores(i,:), ...
            'LineWidth', 1.2, ...
            'DisplayName', sprintf('%s - medição %d', mm, j));

        % Interpolação com extrapolação
        y_interp = interp1(dados.Deformacao, dados.Forca, x_padrao, 'linear', 'extrap');
        forcas_interp(end+1, :) = y_interp;
        todas_forcas_interp(end+1, :) = y_interp;

        % Calcular rigidez com regressão linear
        mascara = dados.Deformacao > 0;
        x = dados.Deformacao(mascara);
        y = dados.Forca(mascara);
        coef = polyfit(x, y, 1);  % coef(1) é a rigidez
        rigidezes_individuais(end+1) = coef(1);
    end

    % Curva média do grupo
    media_grupo = mean(forcas_interp, 1);
    plot(x_padrao, media_grupo, '--', ...
        'Color', cores(i,:), 'LineWidth', 2.5, ...
        'DisplayName', sprintf('%s - média', mm));

    % Média de rigidez do grupo
    media_rigidez_por_mm(i) = mean(rigidezes_individuais);
    fprintf(fid, 'Milimetragem %s → Rigidez média (reta): %.3f N/mm\n', mm, media_rigidez_por_mm(i));
end

% Curva média geral (preta)
media_geral = mean(todas_forcas_interp, 1);
plot(x_padrao, media_geral, 'k-', 'LineWidth', 3, 'DisplayName', 'Média geral');

% Média geral da rigidez
media_geral_rigidez = mean(media_rigidez_por_mm);
fprintf(fid, '\nRigidez média geral (reta entre todos os grupos): %.3f N/mm\n', media_geral_rigidez);

% Fechar arquivo de texto
fclose(fid);

% Finalizar gráfico
xlabel('Deformação (mm)');
ylabel('Força (N)');
title('Curvas Força x Deformação com Médias e Rigidez Geral');
legend('show', 'Location', 'bestoutside');
grid on;
hold off;

% Salvar imagem
saveas(gcf, fullfile(pasta, 'curvas_rigidez.png'));

% Aviso final
fprintf('\n✅ Gráfico salvo como curvas_rigidez.png\n');
fprintf('✅ Rigidez salva em: rigidez_resultado.txt\n');