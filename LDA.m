clc;close all;clear;
x1 = [ 2.95 6.63; 2.53 7.79; 3.57 5.65; 3.16 5.47];
x2 = [2.58 4.46; 2.16 6.22; 3.27 3.52];


m1 = mean(x1);m2 = mean(x2);m = mean([x1;x2]);
S1 = (x1-repmat(m1,size(x1,1),1))'* ...
     (x1-repmat(m1,size(x1,1),1));
S2 = (x2-repmat(m2,size(x2,1),1))'* ...
     (x2-repmat(m2,size(x2,1),1));
S = S1 + S2;
w= inv(S)*(m1-m2)';
figure,hold on
axis([0 8 0 8]);
plot(x1(:,1),x1(:,2),'bx');
plot(m1(1),m1(2),'bd');
plot(x2(:,1),x2(:,2),'rx');
plot(m2(1),m2(2),'rd');
plot(m(1),m(2),'kd');
plot([w(1) 0],[w(2) 0],'g');
w = w/norm(w);
 
x1l=(x1*w)*w'; x2l=(x2*w)*w';
 
plot(x1l(:,1),x1l(:,2),'bo');
plot(x2l(:,1),x2l(:,2),'ro');

