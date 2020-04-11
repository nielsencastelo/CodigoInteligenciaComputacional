% Illustrates the movement of the particles and minimizes the function
% (x - 15)^2 + (y - 20)^2
% swarm(index, [location, velocity, best position,best
% value], [x, y components or the value component])

%% Inicialização
clear;clc;close all;
tic;
iterations = 37;
inertia = 1.0;
correction_factor = 2.0;
M = 12;
N = 12;
swarm_size = M*N;
% Initial position swarm
index = 1;
for i = 1 : M
    for j = 1 : N
        swarm(index, 1, 1) = i;
        swarm(index, 1, 2) = j;
        index = index + 1;
    end
end
swarm(:, 4, 1) = 1000; % best value to date
swarm(:, 2, :) = 0;    % initial speed
%% Iterações
for iter = 1 : iterations
% evaluating the position and quality
    for i = 1 : swarm_size
        swarm(i, 1, 1) = swarm(i, 1, 1) + swarm(i, 2, 1)/1.3;
        % atualiza a posição x
        swarm(i, 1, 2) = swarm(i, 1, 2) + swarm(i, 2, 2)/1.3;
        % atualiza a posição y
        x = swarm(i, 1, 1);
        y = swarm(i, 1, 2);
        
        val = (x - 15)^2 + (y - 20)^2; % Função custo
        
        if val < swarm(i, 4, 1) % if the new position is better
            swarm(i, 3, 1) = swarm(i, 1, 1); % updated best x,
            swarm(i, 3, 2) = swarm(i, 1, 2);% the best position y
            
            swarm(i, 4, 1) = val;   % and the best value
        end
    end
    [temp, gbest] = min(swarm(:, 4, 1)); % the global best position
    
    
    % upgrading the speed of vectors
    for i = 1 : swarm_size
        swarm(i, 2, 1) = rand*inertia*swarm(i, 2, 1) + correction_factor*rand ...
            *(swarm(i, 3, 1) - swarm(i, 1, 1)) + correction_factor*rand ...
            *(swarm(gbest, 3, 1) - swarm(i, 1, 1));
        % velocity component x
        swarm(i, 2, 2) = rand*inertia*swarm(i, 2, 2) + ...
            correction_factor*rand*(swarm(i, 3, 2) ...
            - swarm(i, 1, 2)) + correction_factor*rand*(swarm(gbest, 3, 2) ...
            - swarm(i, 1, 2));
        % velocity component y
    end
    
    %% Plotanto o enxame
    clf
    h = plot(swarm(:, 1, 1), swarm(:, 1, 2), '.');axis([-2 30 -2 30]);
    set(h, 'markersize', 16);
       
    title('Movimento do Swarm')
    xlabel('Variavel x')
    ylabel('Variável y')
    pause(0.5);
    %teclar;
    disp(iter);
end
toc