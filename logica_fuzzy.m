% enter the two matrix (slide 3 Inteligência Computacional)
u = input('enter the ﬁrst matrix');
v = input('enter the second matrix');
option = input('enter the option');
%option 1 Union
%option 2 intersection
%option 3 complement
if (option==1)
	w = max(u,v);
end
if (option==2)
	p = min(u,v);
end
if (option==3)
	option1 = input('enter whether to ﬁnd complement for ﬁrst matrix or second matrix');
	if (option1==1)
		[m,n] = size(u);
		q = ones(m) - u;
	else
	q = ones(m)-v;
	end
end