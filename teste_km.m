% Resolver o problema de marketing
clear;close all; clc;
s1 = [1 2 2 3 3 3 3 3 3 3 4 4 4 4 4 4 5 5 5 5 5 5 5]';
s2 = [100.8 357.0 1488.7 522.50 649.0 1571.2 1719.1 1947.24 3172.16 5297.8 ...
    1402.95 1615.9 1992.05 2423.35 3361.0 3490.02 836.7 1467.29 1480.0 2844.1 ...
    3063.2 3460.2 3810.75]';
x = [s1 s2];
k = 3;

colors = rand(k,3);

centros = init_centros4(x,k);   % Método tradicional

[classes2,c2,itekm] = km(x,k,centros);

mssckm = MSSCKM(x,classes2,c2,k);

fprintf('MSSC KM: %2.4f\n',mssckm);


plota(x,classes2,colors);
plotaCentroide(c2,'r');

jorge = [4 3000];
% Testar o cliente Jorge baseado na distância euclidiana entre os centros
for c = 1:k
    soma = 0;
    for s = 1:size(jorge,2)
        soma = soma + (jorge(s) - centros(c,s)).^2;
    end
    dist(c) = sqrt(soma);
end

[~,posi] = min(dist);

 plotaCentroide(jorge,'black');