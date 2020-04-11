function f = plotaf(x)    
    %f = cos(20*x)- (norm(x)/2) + (x.^3/4);
    f = x + 10 * sin(5*x) + 7 * cos(4*x) + sin(x);
    plot(f);
end