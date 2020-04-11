% Perceptron para resolver treinar portas lógicas
% laranjas e tangerinas
clear;close all;clc;

% Padrão de entradas
bias = -1;
x = [0 0 bias; ...
     0 1 bias; ...
     1 0 bias; ...
     1 1 bias]; 
 
% Desejado
d = [0 ... % Teste com AND
     0 ... % 
     0 ... % 
     1];   % 

eta = 0.05;
w = rand(3,1);
u = zeros(4,1);
erro = 1;
epoca = 1;
while(erro ~= 0)
    erro = 0; % erro inesistente
    for i  = 1 : 4
        u(i) = w' * x(i,:)';
        
        if (u(i)> 0) % Função de ativação
            y = 1;
        else
            y = 0;
        end
        
        if y ~= d(i)
            w = w + eta * (d(i) - y) * x(i,:)';
            erro = 1;            % Existe erro
        end
    end
    epoca = epoca + 1;
    fprintf('Época: %d\n',epoca);
end

% Teste padrão
for i = 1: 4
    u(i) = w' * x(i,:)';
    if (u(i)> 0) % Função de ativação
            y(i) = 1;
    else
            y(i) = 0;
    end
end
disp(y);
