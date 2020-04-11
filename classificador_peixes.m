% Adaline para resolver o problema de classificação de peixes
% Lambari e Tucunaré
clear;close all;clc;

% N = 5;
% a = 5 * [randn(N,1) + 5, randn(N,1) + 5];
% b = 5 * [randn(N,1) - 5, randn(N,1) - 5];
x = [

   28.0567   21.3844 ;
   25.5466   27.6327 ;
   34.0701   23.6987 ;
   26.5601   28.0007 ;
   34.0225   27.9697 ;
   35.9301   26.6341 ;
   31.6352   20.9384 ;
   32.2051   22.2723 ;
   22.9908   30.2582 ;
   17.6490   23.0127 ];
[n,dim] = size(x);
x = zscore(x);
bias = 1;
x = [x ones(n,1) * bias];
% Padrão de entradas
plot(x(:,1), x(:,2),'d','LineWidth',4);
% Desejado
d = [-1 ...% Tucunaré 
     1 ... % Lambari
    -1 ... % Tucunaré
     1 ... % Lambari 
    -1 ... % Tucunaré
    -1 ... % Tucunaré
    -1 ... % Tucunaré
    -1 ... % Tucunaré
    1 ...  % Lambari
    -1];    % Lambari

eta = 0.005;
w = rand(3,1);
u = zeros(n,1);
erro = 0.00001;
epoca = 1;
while(1)
    %disp(abs(eqm_ant - eqm_atual));
    eqm_ant = eqm(x,w,d,n);
    for i  = 1 : n
        u(i) = w' * x(i,:)';
        y = degrau(u(i));        % Função de ativação
        if y ~= d(i)
            w = w + eta * (d(i) - y) * x(i,:)';
        end
    end
    epoca = epoca + 1;
    eqm_atual = eqm(x,w,d,n);
    fprintf('Época: %d\n',epoca);
    if abs(eqm_atual - eqm_ant) <= erro
        break;
    end
    clf;
    %yy = -w(1) * x(:,1:2) - w(3)/ w(2);
    plot(x(:,1), x(:,2),'d','LineWidth',4);
    hold on
    plot([w(1) w(3)],[w(2) w(3)],'g','LineWidth',4);
    
    title('Classificação dos peixes')
    pause(0.25);
end

% Teste padrão
% for i = 1: n
%     u(i) = w' * x(i,:)';
%     y(i) = degrau(u(i));        % Função de ativação  
% end

x1 =[-1 1 bias]';
u = w' * x1;
y = degrau(u);
disp(y);
plot(x1(1), x1(2),'x','LineWidth',4);