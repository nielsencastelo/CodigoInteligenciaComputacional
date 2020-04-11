% Perceptron para resolver o problema de classificação de frutas
% laranjas e tangerinas
clear;close all;clc;

% Padrão de entradas
x = [0.1 0.4 0.7 -1; ...
     0.5 0.7 0.1 -1; ...
     0.6 0.9 0.8 -1; ...
     0.3 0.7 0.2 -1]; 
 
% Desejado
d = [1 ... % Laranjas
     1 ... % Laranjas
    -1 ... % Tanjerina
    -1];   % Tangerina

eta = 0.05;
w = rand(4,1);
u = zeros(4,1);
erro = 1;
epoca = 1;
while(erro ~= 0)
    erro = 0; % erro inesistente
    for i  = 1 : 4
        u(i) = w' * x(i,:)';
        y = degrau(u(i));        % Função de ativação

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
    y(i) = degrau(u(i));        % Função de ativação  
end
disp(y);
