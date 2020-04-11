function z = pidFit(C,Gs)
    P = pid(C(1),C(2));
    [y,t] = step(feedback(P*Gs,1));
    dt = (t(2)-t(1))/2;
    % Estende o tempo de simula��o, para garantir a converg�ncia ao degrau
    % ao final do per�odo
    t = 0:dt:t(end)*2;
    e = step(feedback(P*Gs,1),t);
    z = sum(((t.'.^2).*(e.^2)*dt));
end