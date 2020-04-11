% Comparativo entre as metaeuristicas
clear;close all; clc;


Gs = tf(3.8,[192.5 1]); % Função de transferência

Cag = [40.7362 32.2688]; % AG
C = [25.0 16.0]; % SIMC
Crf = [2 20]; % RF

% Parâmetro dos algoritmos
it = 60;
pop = 10;

% Roda Bat Algoritm
tic;
[Kpb,Kib,ISTSE_B] = BA(it,pop,C,Gs);
tempoB = toc;

grid on;
hold on;

Cb = pid(Kpb,Kib);
step(feedback(Cb*Gs,1));

% Roda AG
CAG = pid(Cag(1),Cag(2));
step(feedback(CAG*Gs,1))

% Roda RF
CRF = pid(Crf(1),Crf(2));
step(feedback(CRF*Gs,1))

% Roda SIMC
CSIMC = pid(C(1),C(2));
step(feedback(CSIMC*Gs,1))

% Legendas do gráfico
legend({'BA','AG','RF','SIMC'});
hold off;

% Imprime resultados
fprintf('ISTSE BA: %f\n',ISTSE_B);
fprintf('    Tempo BA: %f\n',tempoB);
