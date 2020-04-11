% Universidade Federal do Rio Grande do Norte
% P�s-gradua��o em Engenharia de Computa��o 2008.1
% Disciplina: Redes Neurais
% Prof.: Adri�o
% Aluno: Nielsen C. Damasceno
% Desc.: Problema de predi��o
% 
clear;clc;close all;
n = 0:799;                
%% Exemplos
xn = sin(n + sin(n.^2));
%% Dados de treinamento
xt = xn(1:300);           
[xt,xts] = mapminmax(xt);
xt = con2seq(xt);
 
%% criacao da rede neural
net = newfftd([-1 1],[1:20],[10 1],{'tansig' 'purelin'});
 
%% parametros de treinamento
net.trainParam.show = 5;
net.trainParam.lr = 0.01;
net.trainParam.goal = 1e-3;
net.trainParam.epochs = 500;
 
%% Conjuntos entradas e saidas 
p = xt(21:end);
t = xt(21:end);
%% condicoes iniciais
for i=1:20
  Pi{1,i} = xt{i};
end
%% treinamento da rede
[net] = train(net,p,t,Pi);  
 
%% validacao
pr = sim(net,p,Pi);   
pr = cell2mat(pr);
t = cell2mat(t);
e = t - pr;
 
%% Gr�ficos de resultados
subplot(2,1,1);
plot(t,'r');title('Conjunto de saidas');
subplot(2,1,1);
hold on;
plot(pr,'-k');title('Conjunto de valida��o');
legend('predi��o','original');
subplot(2,1,2);
plot(e);title('Erro');
