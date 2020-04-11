% enter the two matrix (slide 3 Inteligência computacional)
u=input('enter the ﬁrst matrix');
v=input('enter the second matrix');
option=input(‘enter the option’);
%option 1 u | v
%option 2 v | u
%to ﬁnd diﬀerence of u and v
if option==1
	%to ﬁnd v complement
	[m,n]=size(v);
	vcomp=ones(m)-v;
	r=min(u,vcomp);
end
%to ﬁnd diﬀerence v and u
if option==2
	%to ﬁnd u complement
	[m,n] = size(u);
	ucomp = ones(m)-u;
	r = min(ucomp,v);
end
fprintf('output result');
printf(r);