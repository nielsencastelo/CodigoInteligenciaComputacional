%--------------------------------------------------------------------------
%
% Renato Dourado Maia
%
% Faculdade de Ci�ncia e Tecnologia de Montes Claros
%
% Intelig�ncia Computacional
%
% Aula 8: Adaline
%
% Demonstra��o do Adaline para Aproxima��o de uma Reta
%
% Testado no Matlab R2010a e no Octave 3.2.4
%
% �ltima Atualiza��o: 03/09/2011
%
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Limpeza...

clear all
close all
clc
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Cabe�alho e configura��o
 
disp(' ')
disp('__________________________________________________________________ ')
disp(' ')
disp('     Demonstra��o do Adaline para Aproxima��o de uma Reta.')
disp('              Intelig�ncia Computacional - Facit.')
disp('             Renato Dourado Maia - agosto de 2011')
disp('__________________________________________________________________ ')
disp(' ')
disp(' ')
disp('__________________________________________________________________ ')
disp(' Configura��es:')
disp(' ')
NumeroPadroes = input('   >>> N�mero de amostras: '); % 1000
Desvio = input('   >>> Desvio padr�o para o ru�do: '); % 0.4
a = input('   >>> Inclina��o da reta: '); % 3
b = input('   >>> Termo Independente da reta: '); % 5
Eta = input('   >>> Taxa de aprendizado: '); % 0.05;
MaxEpocas = input('   >>> N�mero m�ximo de �pocas de treinamento: ');
Tolerancia = input('   >>> Toler�ncia para a diferen�a de erros: ');
disp('__________________________________________________________________ ')
disp(' ')
disp(' ')
disp('   >>> PRESSIONE QUALQUER TECLA PARA PROCESSAR O TREINAMENTO...');
disp(' ')
pause
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Entradas e sa�das desejadas

% Entradas
X = linspace(-2,2,NumeroPadroes)';

% Sa�das desejadas - reta com ru�do
Ruido = Desvio*randn(NumeroPadroes,1);
Yd = a*X + b + Ruido;
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Inicializa��es

% Dimens�o dos padr�es de entrada
N = size(X,2); 

% Adicionando a entrada de bias
X_Bias = 1*ones(NumeroPadroes, 1);
X = [X X_Bias];

% Inicializando vetor de pesos (o �ltimo peso � o bias) aleatoriamente, com
% distribui��o normal de m�dia zero e desvio padr�o 1
W     = randn(1, N); 
Bias  = randn();

% Adicionando o bias � matriz de pesos
W = [W Bias]; 

Erro = 0;

Vetor_Erros = [];

Epoca = 1;
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Loop de treinamento

while (true)  

    % Erro quadr�tico para a �poca
    Erroq = 0;  

	% Para treinar com um padr�o aleat�rio, cria-se um vetor com �ndices
    % aleat�rios
    Idx = randperm(NumeroPadroes);
	
    %**********************************************************************
    % Cada ciclo completo do for representa uma �poca de treinamento: 
    % em cada �poca, todos os padr�es de treinamento s�o apresentados,
    % aleatoriamente, � rede
    
    for i = 1 : NumeroPadroes
        
        % Calcula sa�da
	    y = W*X(Idx(i), :)';
        
        % Calcula erro 
        Erro = (Yd(Idx(i)) - y)';
      
        % Calcula o vetor Delta_W
        Delta_W = Eta*Erro*X(Idx(i), :);
        
        % Atualiza vetor de pesos
        W = W + Delta_W;
        
        % Atualiza o erro quadr�tico da �poca
        Erroq = Erroq + Erro^2;
        
    end % for i = 1 : NumeroPadroes
    %**********************************************************************
	
	% Armazena erro quadr�tico acumulado para cada �poca
    Vetor_Erros = [Vetor_Erros; Erroq];

	%**********************************************************************
    % Visualiza��o gr�fica da evolu��o do treinamento.
    clf
    plot(X(:, 1), Yd,'r.')
	axis ([-2 2 min(Yd)-1 max(Yd)+1])
    grid on
    hold on
    
    % Reta aproximada pelo Adaline
    Reta = W(1)*X + W(2);
    plot(X,Reta,'k')
    title('Evolu��o da Aproxima��o Obtida')
    xlabel('x')
    ylabel('f(x)')
    
    legend('Amostras', 'Reta Obtida', 'Location', 'NorthWest')
	
	% Pausa para melhor vizualiza��o da evolu��o da reta (aproxima��o)
    pause(0.25)
    %**********************************************************************
	
	if (Epoca > 1)
	
		% Encerra treinamento se o crit�rio de erro foi alcan�ado
		Diferenca = abs(Vetor_Erros(Epoca - 1) - Erroq);
		
		if ((Diferenca < Tolerancia) || (Epoca > MaxEpocas))
        
			break;
        
		end % if ((Diferenca < Tolerancia) || (Epoca > MaxEpocas))
		
	end % if (Epoca > 1)

	Epoca = Epoca + 1;

end % while (true)      
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Evolu��o do erro quadr�tico acumulado por �poca

figure
plot(Vetor_Erros, '^-')
grid on
xlabel('�poca')
ylabel('Erro Quadr�tico')
title('Erro Quadr�tico M�dio por �poca de Treinamento')
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Resultados

disp('__________________________________________________________________ ')
disp(' Resultados:')
disp(' ')
fprintf('   >>> O valor obtido para o peso 1 foi: %f\n', W(1))
fprintf('   >>> O valor obtido para o bias foi: %f\n', W(2))
disp('__________________________________________________________________ ')
disp(' ')
%--------------------------------------------------------------------------