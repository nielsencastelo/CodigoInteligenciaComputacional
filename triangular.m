% Função triangular
% Sequência no eixo x : a, c, b
% Autor: Nielsen C. Damasceno
% Data: 23/04/2014
% Entrada:
%         s é o tipo de triangulo
%         a b c são os pontos
% Saída:
%        r é o resultado
% 
% Exemplo x = 3.2 
%         triangular(0,3, 4, 5, x)
%         r = 0.2
function r = triangular(s, a, b, c, x)
    r = 0;
    if a > b,
        error('Condição parâmetro ilegal: a > b');
    elseif b > c,
        error('Condição parâmetro ilegal: b > c');
    elseif a > c,
        error('Condição parâmetro ilegal: a > c');
    end
    switch s
        case 0 % Triangulo retângulo com ângulo reto em b, c = 0
            if((x >= a) && (x <= b))
            %if (( a  < x) && (x < b))
                r = (x - a) / (b - a);
            elseif x > b
                r = 0;
            end
        case 1
            if((x >= a) && (x <= b)) 
                r = (b - x) / (b - a);
            elseif(x < a) 
                r = 0;
            end
        case 2
            if((x >= a) && (x <= c))
                r = (x - a) / (c - a);
            elseif((x > c) && (x <= b)) 
                r = (b - x) / (b - c);
            end
        otherwise
            disp('Parametro desconhecido');
    end
end