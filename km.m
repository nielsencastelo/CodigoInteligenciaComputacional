% Implementa o k-means com animação simples
% Autor: Nielsen Castelo Damasceno
% Baseado no artigo original de J. MacQueen.  Some methods for classification and analysis of multivariate
% observations. In Proceedings of the Fifth Berkeley Symposium on Mathematics, Statistics and Probability, 
% Vol. 1, pages 281–296, 1967.
function [classe,centros,it,contadeg,maxdeg] = km(x,k,centros)
    maxdeg = 0;
    %disp('Iniciou KM');
    % Setando variáveis iniciais
    %low = 1;
    high = size(x,1);
    contadeg = 0;
    %centros = zeros(k,size(x,2));
    %indice = zeros(1,k);

    % Estabelecendo os centros (k) iniciais
    % for var = 1:k
    %     indice(var) = round(low + (high - low)*rand);
    %     centros(var,:) = x(indice(var),:);
    % end
    % save centros;

    % Estabelecendo laço
    classe = zeros(high,1);

    var_cond = 1;
    W = 1;
    while W
        contadeg = 0;
        % Calculando distância euclidiana entre os centroides e os dados
        dist = zeros(high,k);
        for var = 1:high
            for c = 1:k
                soma = 0;
                for s = 1:size(x,2)
                    soma = soma + (x(var,s) - centros(c,s)).^2;
                end
                dist(var,c) = sqrt(soma);
            end
        end
     
        % Guardando classes
        ant_classe = classe;
    
        % Atribuindo as classes para os valores
        for var = 1:high
            [~,indice] = min(dist(var,:));
            classe(var) = indice;
        end
    
        % Mostra resultados visuais iniciais
%         colors = rand(k,3);
        colors = [
            0.6596    0.8003    0.0835
            0.5186    0.4538    0.1332
            0.9730    0.4324    0.1734];
%             0.2490    0.2253    0.3909];
%         disp(centros);
        clf;
        plota(x,classe,colors);
        plotaCentroide(centros,'red');
        plota_linhas(x,classe,centros,'k--');
        teclar();
        
        % Guardando classes
        nov_classe = classe;
        
        % Calculando novos centroides
        
        % 1ª versão
%         for c = 1:k
%             y = x(classe == c,:);
%             if size(y,1) ~= 1
%                 centros(c,:) = sum(y)/size(y,1);
%             else
%                 centros(c,:) = y;
%             end
%         end
        % 2º versão
        for c = 1:k
            y = x(classe == c,:);
            if size(y,1) > 1
                centros(c,:) = sum(y)/size(y,1);
            elseif size(y,1) == 1
                centros(c,:) = y;
            elseif size(y,1) == 0
                contadeg = contadeg + 1;
%                 it=0;
%                 return;
            end
        end
        if contadeg > maxdeg
            maxdeg = contadeg;
        end
           
        %disp(centros);
        
        % Variavel de laço
        if ant_classe == nov_classe
            W = 0;
        end
    
       
        % Laço
        var_cond = var_cond + 1;
        %fprintf('it: %d\n', var_cond);
       
%         clf;
%         plota(x,classe,colors);
%         plotaCentroide(centros);
%         plota_linhas(x,classe,centros,'k--');
%         teclar();
    end

    % Finalizando
    classe = nov_classe;
    it = var_cond;
    
    %  ***DANIEL*** MUDEI AQUI ************************************
%     for c = 1:k
%         y = x(classe == c,:);
%         if size(y,1) ~= 1
%             centros(c,:) = sum(y)/size(y,1);
%         else
%             centros(c,:) = y;
%         end
%     end
    %  ***DANIEL*** MUDEI AQUI ************************************
    
    % Mostra resultados visuais
%     figure(2);
%     colors = rand(k,3);
%     colors = [
%             0.6596    0.8003    0.0835
%             0.5186    0.4538    0.1332
%             0.9730    0.4324    0.1734
%             0.2490    0.2253    0.3909];
%     
%     clf;
%     plota(x,classe,colors);
%     plotaCentroide(centros);
end