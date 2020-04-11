% Gera o conjunto de dados

x = [ 1 2; 2 1; 3  2; -5 4; -1 4; -3 3];
classes = [1 1 1 1 1 1];
k = 2;

c = [0.4538    0.0835    0.3909
    0.4324    0.1332    0.8314
    0.8253    0.1734    0.8034];

centros = [-3 3;2 1];
axis square;
grid on;
plota(x,classes,c);
plotaCentroide(centros);
[classes,centros, it] = km(x,2,10,centros);

plotaCentroide(centros);
plota(x,classes,c);
