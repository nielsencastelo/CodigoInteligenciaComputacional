% Perceptron para resolver o problema de classifica��o de frutas
% laranjas e tangerinas
clear;close all;clc;

% Padr�o de entradas
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
        y = degrau(u(i));        % Fun��o de ativa��o

        if y ~= d(i)
            w = w + eta * (d(i) - y) * x(i,:)';
            erro = 1;            % Existe erro
        end
    end
    epoca = epoca + 1;
    fprintf('�poca: %d\n',epoca);
end

% Teste padr�o
for i = 1: 4
    u(i) = w' * x(i,:)';
    y(i) = degrau(u(i));        % Fun��o de ativa��o  
end
disp(y);
