clear; clc;
x1 = 2 :.1:8;
x2 = 2 :.1:8;
 
P = [x1 x2];
D =((sin(pi.*P)./(pi.*P)));
hold on;

eg = 0.02; % sum-squared error goal
sc = 1;    % spread constant
net = newrb(P,D,eg,sc);
a = sim(net,D);
plot(P,zscore(D));
plot(P,zscore(a),'.','markersize',10,'color',[1 0 0]);

