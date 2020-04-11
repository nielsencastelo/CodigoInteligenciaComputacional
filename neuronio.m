x = [-2 6];
w = [-0.1 0.4];
limiar = -1;
net = 0;
for i = 1 : 2
    net = net + x(i) * w(i);
end
net = net - limiar;
if net > 0
    k = 1;
else
    k = 0;
end
disp(k);