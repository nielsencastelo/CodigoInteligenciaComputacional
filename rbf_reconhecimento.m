clc;
close all;
nCentros = 5;
% Geração do conjunto de treinamento
L1 = [ 
    1 1 1 1 1 1 1 % A
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 1 1 1 1 1
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
];

L2 = [
    1 1 1 1 1 1 1 % E
    1 1 0 0 0 0 0
    1 1 0 0 0 0 0
    1 1 1 1 1 1 1
    1 1 0 0 0 0 0
    1 1 0 0 0 0 0
    1 1 1 1 1 1 1
];

L3 = [
    1 1 1 1 1 1 1 % I
    0 0 1 1 1 0 0
    0 0 1 1 1 0 0
    0 0 1 1 1 0 0
    0 0 1 1 1 0 0
    0 0 1 1 1 0 0
    1 1 1 1 1 1 1
];

L4 = [
    1 1 1 1 1 1 1 % O
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 1 1 1 1 1
];

L5 = [
    1 1 0 0 0 1 1 % U
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 1 1 1 1 1
];
La = [
    0 0 0 0 0 0 0 % a
    0 0 0 0 0 0 0
    0 0 1 1 1 1 1
    0 0 0 0 0 0 1
    0 0 0 1 1 1 1
    0 0 1 0 0 0 1
    0 0 0 1 1 1 1
];

Le = [
    0 0 0 0 0 0 0 % e
    0 0 0 0 0 0 0
    0 0 0 1 1 1 0
    0 0 1 0 0 0 1
    0 0 1 1 1 1 1
    0 0 1 0 0 0 0
    0 0 1 1 1 1 1
];

Li = [
    0 0 0 0 0 0 0 % i
    0 0 0 0 0 0 0
    0 0 0 1 0 0 0
    0 0 0 1 0 0 0
    0 0 0 1 0 0 0
    0 0 0 1 0 0 0
    0 0 0 1 0 0 0
];

Lo = [
    0 0 0 0 0 0 0 % o
    0 0 0 0 0 0 0
    0 0 0 1 1 1 0
    0 0 1 0 0 0 1
    0 0 1 0 0 0 1
    0 0 1 0 0 0 1
    0 0 0 1 1 1 0
];

Lu = [
    0 0 0 0 0 0 0 % u
    0 0 0 0 0 0 0
    0 0 1 0 0 0 1
    0 0 1 0 0 0 1
    0 0 1 0 0 0 1
    0 0 1 0 0 0 1
    0 0 1 1 1 1 1
];

%Juntando o conjunto de treinamentos maiusculo e minusculo numa só matriz
cont=0;
for i=1:7
	for j=1:7
		cont=cont+1;
		entrada(cont,1)=L1(i,j);
		entrada(cont,2)=L2(i,j);
		entrada(cont,3)=L3(i,j);
		entrada(cont,4)=L4(i,j);
		entrada(cont,5)=L5(i,j);
		entrada(cont,6)=La(i,j);
		entrada(cont,7)=Le(i,j);
		entrada(cont,8)=Li(i,j);
		entrada(cont,9)=Lo(i,j);
		entrada(cont,10)=Lu(i,j);
	end
end

% Resposta desejada
saida = [
1 0 0 0 0;   % A
0 1 0 0 0;   % E
0 0 1 0 0;   % I
0 0 0 1 0;   % O
0 0 0 0 1 ]; % U

%Máquinas de comitê com dois especialistas
[E1,w1] = RBF_N(entrada(:,1:5),saida,nCentros); % Especialista 1 - MAIUSCULAS
[E2,w2] = RBF_N(entrada(:,6:10),saida,nCentros);% Especialista 2 - minusculas

E1*w1
E2*w2

% % Geração conjunto de VALIDACAO
vL1 = [
    0 1 1 0 1 1 0 % A
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 1 1 1 1 1
    0 1 0 0 0 1 0
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
];

vL2 = [
    1 1 1 0 1 1 1 % E
    1 1 0 0 0 0 0
    1 1 0 0 0 0 0
    1 0 1 1 1 1 1
    1 1 0 0 0 0 0
    1 1 0 0 0 0 0
    1 1 1 1 1 1 0
];

vL3 = [
    1 1 1 0 1 1 1 % I
    0 0 1 1 1 0 0
    0 0 1 1 1 0 0
    0 0 1 1 1 0 0
    0 0 1 1 1 0 0
    0 0 1 1 1 0 0
    1 1 1 0 1 1 1
];

vL4 = [
    1 1 1 1 1 1 1 % O
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 0 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 1 1 1 0 1
];

vL5 = [
    1 1 0 0 0 1 1 % U
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 0 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 0 0 0 1 1
    1 1 1 1 1 1 0
];
vLa = [
    0 0 0 0 0 0 0 % a
    0 0 0 0 0 0 0
    0 0 0 1 1 1 1
    0 0 0 0 0 0 1
    0 0 0 1 1 1 1
    0 0 1 0 0 0 1
    0 0 0 0 1 1 1
];

vLe = [
    0 0 0 0 0 0 0 % e
    0 0 0 0 0 0 0
    0 0 0 1 1 1 0
    0 0 1 0 0 0 1
    0 0 1 1 0 1 1
    0 0 1 0 0 0 0
    0 0 1 1 1 1 1
];

vLi = [
    0 0 0 0 0 0 0 % i
    0 0 0 0 0 0 0
    0 0 0 1 0 0 0
    0 0 0 0 0 0 0
    0 0 0 1 0 0 0
    0 0 0 1 0 0 0
    0 0 0 1 0 0 0
];

vLo = [
    0 0 0 0 0 0 0 % o
    0 0 0 0 0 0 0
    0 0 0 1 1 0 0
    0 0 1 0 0 0 1
    0 0 0 0 0 0 1
    0 0 1 0 0 0 1
    0 0 0 1 1 1 0
];

vLu = [
    0 0 0 0 0 0 0 % u
    0 0 0 0 0 0 0
    0 0 1 0 0 0 0
    0 0 1 0 0 0 1
    0 0 0 0 0 0 1
    0 0 1 0 0 0 1
    0 0 1 1 1 1 1
];
cont=0;
for i=1:7
	for j=1:7
		cont=cont+1;
		validacao(cont,1)=vL1(i,j);
		validacao(cont,2)=vL2(i,j);
		validacao(cont,3)=vL3(i,j);
		validacao(cont,4)=vL4(i,j);
		validacao(cont,5)=vL5(i,j);
		validacao(cont,6)=vLa(i,j);
		validacao(cont,7)=vLe(i,j);
		validacao(cont,8)=vLi(i,j);
		validacao(cont,9)=vLo(i,j);
		validacao(cont,10)=vLu(i,j);
	end
end

%Máquinas de comitê com dois especialistas
[V1,wv1] = RBF_N(validacao(:,1:5),saida,nCentros); %Especialista 1 - Maiusculas
[V2,wv2] = RBF_N(validacao(:,6:10),saida,nCentros);% Especialista 2 - Minusculas

V1* wv1
V2*wv2

%Rotação das matrizes
rL1 = L1';
rL2 = L2';
rL3 = L3';
rL4 = L4';
rL5 = L5';
rLa = La';
rLe = Le';
rLi = Li';
rLo = Lo';
rLu = Lu';

cont=0;
for i=1:7
	for j=1:7
		cont=cont+1;
		rotacao(cont,1)=rL1(i,j);
		rotacao(cont,2)=rL2(i,j);
		rotacao(cont,3)=rL3(i,j);
		rotacao(cont,4)=rL4(i,j);
		rotacao(cont,5)=rL5(i,j);
		rotacao(cont,6)=rLa(i,j);
		rotacao(cont,7)=rLe(i,j);
		rotacao(cont,8)=rLi(i,j);
		rotacao(cont,9)=rLo(i,j);
		rotacao(cont,10)=rLu(i,j);
	end
end
%Máquinas de comitê com dois especialistas
[R1,wr1] = RBF_N(rotacao(:,1:5),saida,nCentros); %Especialista 1 - Maiusculas
[R2,wr2] = RBF_N(rotacao(:,6:10),saida,nCentros);% Especialista 2 - Minusculas
R1*wr1
R2*wr2
%--------------------------------------------------------------------------------------------------
