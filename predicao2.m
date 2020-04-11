% Predição série temporal
clc;clear;close all;
%DECLARACAO DE VARIAVEIS
Y1 = [-1];
vetor_erro = []; 
cont = [];
it=1;

%CONFIGURACAO DA REDE
entrada = 6;          % Neurônios na camada de entrada
treinamento = 1;      % Conjuntos de treinamento
camadas = 3;          % Número de camadas
oculta = 6;           % Neurônios na camada oculta
saida = 6;            % Neurônios na camada de saída
eta = 0.005;          % Coeficiente de aprendizagem
y=(2 * pi/9):(pi/9):(2*pi);

for k=1:9
  x(k)=sin(y(k)+sin(y(k))^2);
end
i=1;

s =[x(i+0) x(i+1) x(i+2) x(i+3);
    x(i+1) x(i+2) x(i+3) x(i+4);
    x(i+2) x(i+3) x(i+4) x(i+5);
    x(i+3) x(i+4) x(i+5) x(i+6);
    x(i+4) x(i+5) x(i+6) x(i+7);
    x(i+5) x(i+6) x(i+7) x(i+8)];

%CONJUNTO DE TREINAMENTO
Y0 = [-1;s(:,1)];

%DESEJADO
D = [-1 s(:,2)'];

%PESOS CAMADA OCULTA
for i = 1 : (entrada+1)
	for j = 1 : (oculta)
      	W10(i,j) = rand()*rand();
	end
end

%PESOS CAMADA DE SAIDA
for i = 1 : (oculta+1)
	for j = 1 : (saida)
		W21(i,j) = rand()*rand();
	end
end

while it <= 1000

	W10_T = W10';
	W21_T = W21';
	erro = 0;

	for i = 1 : treinamento	
		for j = 1 : oculta                        
			V10(j) = W10_T(j,:) * Y0(:,i);                 %Potencial de ativação
			Y1(j+1) = (1-exp(-V10(j)))./(1+exp(-V10(j)));  %Função de ativação tangente sigmóide
		end
		for k = 1 : saida                                  
			V21(k) = W21_T(k,:) * Y1(:,1);          
			Y2(k) = V21(k);
			e(k) = D(i,k)- Y2(k);                       
			Dt21(k) = e(k);
		end

		for l = 1 : saida 
			erro = erro + (e(l)^2) / 2;
		end
		for m = 1 : (oculta+1)                          
			for n = 1 : saida 
				W21(m,n) = W21(m,n) + eta * Dt21(n) * Y1(m);  %Atualização de W21
			end 
		end
		for k = 1 : oculta
			aux = 0;
			for p = 1 : saida
				aux = aux + (Dt21(p) * W21(k+1,p)); 
			end
			Dt10(k) = Y1(k+1) * ( 1 - Y1(k+1) ) * aux;
		end
		for p = 1 : (entrada+1)
			for q = 1 : oculta 
				W10(p,q) = W10(p,q) + eta * Dt10(q,1)* Y0(p,i); %Atualização de W10
			end 
		end
	end
	vetor_erro = [vetor_erro erro];
	printf('Erro = %f \n',erro);
	
	it=it+1;
	
	cont=[cont it];
	
	if erro<0.001 then
	 break
	end

end 

% VALIDACAO
val=s(:,2);

YV= [-1;s(:,1)];

W10_T = W10';

W21_T = W21';
[m,n] = size(YV);

for i = 1 : treinamento
	e_medio(i) = 0;
	for j = 1 : oculta                        
		V10(j) = W10_T(j,:) * YV(:,i);
		Y1(j+1) = (1-exp(-V10(j)))./(1+exp(-V10(j)));
	end
	for k = 1 : saida                                  
		V21(k) = W21_T(k,:) * Y1(:,1);          
		Y2(k) = V21(k);
	end
	for l = 1 : entrada
		e_medio(i) = e_medio(i) + YV(l,i)-Y2(l);
	end
end

teste=abs(val-Y2);

EAV=sum(teste.^2)./(2*length(teste));
plot2d(cont,vetor_erro);
