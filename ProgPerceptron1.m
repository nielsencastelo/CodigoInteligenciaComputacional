%eta=0.4
close; clear; clc;
eta=0.01;   % antes 1
% Padrões de Treinamento
x = [1 0 0;1 0 1;1 1 0;1 1 1];
yd =[0 0 0 1];
[padroes,entradas] = size(x);

fprintf('Treinamento do perceptron %d\n');
fprintf('\nNumero de entradas(x): %d Numero de padroes: %d\n',entradas,padroes) 
%winicial = [0 3 3];
winicial = randn(1,3);
w = winicial;
fprintf('Pesos iniciais: ');       disp(w)  
errodes=0; EMQ=1; j=1;
while (EMQ > errodes)
    for i=1:padroes
        fprintf('\nCiclo: %d Padrao: %d\n',j,i) 
        s = w*x(i,:)';
        if (s < 0) y=0;  else y=1; end
           fprintf('Somatorio(s): %.1f\n',s); 
           fprintf('Saida desejada(yd): %d Saida calculada(y): %d\n',yd(i),y);   
           e(i) = yd(i) - y;
           eq(i)= e(i)^2;      %Calculo do erro quadrático
           if (e(i) ~= 0)
              w = w + eta*x(i,:)*e(i);
           end
           fprintf('erro(e): %d\n',e(i));  
           fprintf('Pesos: ');
           disp(w)     
    end
    %Calculo do erro medio quadrático
    somaeq = 0;
    for i = 1:padroes
        somaeq = somaeq + eq(i);
    end
    EMQ = somaeq/padroes;
    fprintf('EMQ: %.2f\n',EMQ) 
    EMQG(j)=EMQ;
    j = j + 1;
end
ciclos = 1:1:j-1
% plot(x,sin(x))
EMQG
plot (ciclos,EMQG)
title('Evolução do Erro Médio Quadrático(EMQ)')
xlabel('Ciclos')
ylabel('EMQ')
grid

% Padrões de Teste
xt = [1 0 0;1 0 1;1 1 0;1 1 1];
[padroest,entradast] = size(xt);
for i=1:padroest
    fprintf('\nPadrao: %d',i) 
    s=w*xt(i,:)';
    if (s < 0) y=0;  else y=1; end
    % fprintf('Somatorio(s): %.1f\n',s); 
    fprintf('\nSaida calculada(y): %d\n',y);           
end
