function fav = avaliacao(pop,nbits,gene,xlo,xhi)
    
    fav = zeros(size(pop,1),1);
    for i = 1:size(pop,1)
        %p = xlo + (xhi - xlo) * ([2.^(-[1:nbits])]*reshape(pop(i,:),nbits,gene));
        p = codificacao(pop(i,:),xlo,xhi,nbits,gene);
        % Função básica
        %fav(i) = 2000 - ((sin(sqrt(p(1)^2 + p(2)^2)))^2 - 0.5)/(1 + 0.001*(p(1)^2 + p(2)^2))^2;
        % Função da apostila de oscar no [-2,2] (Tanomaru,1995)
        fav(i) = max(cos(20 * p) - (norm(p)/2) + (p.^3)/4);
        
        % outra função no intervalo [-1,2]
        %fav(i) = p * sin(10 * pi * p)+ 1;
        
        % Matlab outra função é 100 * (x1^2 - x2)^2 + (1 - x1)^2;
        %fav(i) = 100 * (p(1)^2 - p(2)) ^2 + (1 - p(1))^2;
        
        % Teste livro Colecion Algoritms x+10*sin (5*x) +7*cos (4*x)+sin(x)
        %fav(i) = p + 10 * sin(5*p) + 7 * cos(4*p) + sin(p);
        
        % Função que Allan pediu pra testar [-10,10]
        % f = exp(-x.^2+4*x-29-y.^2)./exp(10*y+z.^2)
        %fav(i) = exp(-p(1)^2 + 4 * p(1) - 29 - p(2)^2)/exp(10*p(2)+p(3).^2);
        
        % Função do livro Ricardo Linden (AG's); [-100,100]
        % f(x,y) = | x * y * sen(y pi/4)|
        %fav(i) = abs(p(1) * p(2) * sin((p(2) * pi)/4));
        
              
    end
end