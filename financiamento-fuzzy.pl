%RENDA MENSAL
baixa(X,Y) :- X=<2500, Y is 1,!.
baixa(X,Y) :- X>=5000, Y is 0,!.
baixa(X,Y) :- Y is (-0.0004*X +2).

intermediaria(X,Y) :- X=5000, Y is 1, !.
intermediaria(X,Y) :- X>=2500,X<5000, Y is (0.0004*X -1), !.
intermediaria(X,Y) :- X>5000,X=<7500, Y is (-0.0004*X +3), !.
intermediaria(X,Y) :- (X<2500;X>7500), Y is 0.

alta(X,Y) :- X=<5000, Y is 0, !.
alta(X,Y) :- X>=7500, Y is 1,!.
alta(X,Y) :- Y is (0.0004*X -2).

%RENDA COMPROMETIDA
pequena(X,Y) :- X=<25, Y is 1,!.
pequena(X,Y) :- X>=50, Y is 0,!.
pequena(X,Y) :- Y is (-0.04*X +2).

media(X,Y) :- X=50, Y is 1, !.
media(X,Y) :- X>=25,X<50, Y is (0.04*X -1), !.
media(X,Y) :- X>50,X=<75, Y is (-0.04*X +3), !.
media(X,Y) :- (X<25;X>75), Y is 0.

grande(X,Y) :- X=<50, Y is 0, !.
grande(X,Y) :- X>=75, Y is 1,!.
grande(X,Y) :- Y is (0.04*X -2).

%HISTORICO DO CLIENTE
ruim(X,Y):- X=<25, Y is 1, !.
ruim(X,Y):- X>=75, Y is 0, !.
ruim(X,Y):- Y is (-0.02*X + 1.5).

bom(X,Y):- X=<25, Y is 0, !.
bom(X,Y):- X>=75, Y is 1, !.
bom(X,Y):- Y is (0.02*X - 0.5).

% Calculando o risco
% M = renda mensal, C = renda comprometida,  H = histórico, P = peso

%regra #1:
riscoBaixo(M,C,H,P):- alta(M,Ym), pequena(C,Yc), bom(H,Yh), Ym >= Yc, Ym >= Yh, P is Ym,  !.
riscoBaixo(M,C,H,P):- alta(M,Ym), pequena(C,Yc), bom(H,Yh), Yc >= Ym, Yc >= Yh, P is Yc,  !.
riscoBaixo(M,C,H,P):- alta(M,Ym), pequena(C,Yc), bom(H,Yh), Yc >= Yh, Yc >= Ym, P is Yh.
%regra #2:
riscoMedio(M,C,P):- intermediaria(M,Ym), media(C,Yc), Ym >= Yc, P is Ym, !.
riscoMedio(M,C,P):- intermediaria(M,Ym), media(C,Yc), Yc >= Ym, P is Yc.
%regra #3:
riscoAlto(M,C,H,P) :- baixa(M,Ym), grande(C,Yc), ruim(H,Yh), Ym >= Yc, Ym >= Yh, P is Ym,  !.
riscoAlto(M,C,H,P) :- baixa(M,Ym), grande(C,Yc), ruim(H,Yh), Yc >= Ym, Yc >= Yh, P is Yc,  !.
riscoAlto(M,C,H,P) :- baixa(M,Ym), grande(C,Yc), ruim(H,Yh), Yh >= Yc, Yh >= Ym, P is Yh.

%Desfuzzificando

risco(P) :- write('digite a renda mensal: '),read(M),nl,
	     write('digite a porcentagem de renda comprometida: '),read(C),nl,
         write('digite a qualidade do seu histórico (de 0 a 100):  '),read(H),nl,
	     riscoAlto(M,C,H,Pa),riscoMedio(M,C,Pm),riscoBaixo(M,C,H,Pb), P is (Pb*0.25 + Pm*0.5 + Pa*0.75)/1.5.

