% Função de Degrau bipolar
function y = degrau(u)
    if (u >= 0)
            y = 1;
    else
            y = -1;
    end
end