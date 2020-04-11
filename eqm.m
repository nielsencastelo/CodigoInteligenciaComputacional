function err = eqm(x,w,d,tam)
    err = 0;
    u = zeros(tam,1);
    for i  = 1 : tam
       u(i) = w' * x(i,:)';
       err = err + (d(i) - u(i)).^2;
    end
    err = err/tam;
end