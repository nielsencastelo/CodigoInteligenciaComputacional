% teste função triangular
clear; close all;clc; 

x = (0:0.2:10);
y = zeros(1,length(x));
y2 = trimf(x, [3 4 5]);
a = 3;
b = 4;
c = 5;
s = 0;
for i = 1 : length(x)
   y(i) = triangular(s,a,b,c,x(i));
end
plot(y);