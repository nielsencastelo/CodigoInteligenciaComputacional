% Adaline para treinar uma porta lógica

clear;close all;clc;
bias = -1;
% Padrão de entradas
x = [0 0 bias; ...
     0 1 bias; ...
     1 0 bias; ...
     1 1 bias]; 
 
% Desejado
d = [0 ... % Porta AND
     0 ... % 
     0 ... % 
     1];   % 

eta = 0.05;
w = rand(3,1);
u = zeros(4,1);
erro = 0.00001;
epoca = 1;
while(1)
    %disp(abs(eqm_ant - eqm_atual));
    eqm_ant = eqm(x,w,d,4);
    for i  = 1 : 4
        u(i) = w' * x(i,:)';
        if (u(i)> 0) % Função de ativação
            y = 1;
        else
            y = 0;
        end
        
        if y ~= d(i)
            w = w + eta * (d(i) - y) * x(i,:)';
        end
    end
    epoca = epoca + 1;
    eqm_atual = eqm(x,w,d,4);
    eglobal = abs(eqm_atual - eqm_ant);
    fprintf('Erro: %f\n',eglobal);
    fprintf('Época: %d\n',epoca);
    if eglobal <= erro
        break;
    end
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