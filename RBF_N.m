% Função RBF 
% Parametro da função(Padrão de treinamento, Saída desejada,Núméro de centros)
function [G,W] = RBF_N(entrada, saida,numcentros) 

    tamanho = size(entrada,1);
    centros = entrada;

    % Faz o calculo da distancia entre os centros

    soma  =  0;

    for i = 1 : numcentros
        distancias = zeros(tamanho,numcentros);
        for j = 1 : numcentros
            distancias(:,j) = centros(:,i) - centros(:,j);
        end
        for a = 1 : numcentros
            for b = 1 : tamanho
                soma = soma + distancias(b,a)^2;
            end
            aux(i)= sqrt(soma);
        end
        distanciamax(i) = max(aux);
    end

    dmax = max(distanciamax);

    sigma = (dmax/sqrt(2*numcentros))^2;

    if(sigma == 0)
        sigma = 1;
    end

    for j = 1 : numcentros
        for i = 1 : numcentros
            soma = 0;
            distancia = zeros(tamanho,numcentros);
            distancia(:,i) = entrada(:,i) - centros(:,j);
            for b = 1 : tamanho
                soma = soma + distancia(b,i)^2;
            end
            norma = sqrt(soma);
            G(i,j) = exp( (-1/2)*sigma*(norma^2) );
        end
    end
    W = inv(G'*G)*G' * saida;
    R = G * W;
end