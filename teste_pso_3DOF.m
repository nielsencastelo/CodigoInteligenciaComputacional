%function [Kp,Ki,ISTSE] = PSO(it,pop,C)
    % Função de Transferência do Processo
    clear; clc; close all;
    pfinal = [25 10];
    % Fator de ponderação
    w1 = 0.12;
    w2 = 0.88;
    % Parâmetros do manipulador
    L1 = 10;
    L2 = 10;
    L3 = 10;
    
    it = 5000;
    pop = 500;
    best = 0;
    n = pop; %Quantidade de particulas
    m = it; %Quantidade de iteracoes
    dimension = 3;
      
    c1 = 1.2;  %Constante do PSO
    c2 = 0.12; %Constante do PSO
    
    wheight = 0.9; %Peso de Momento de Inercia
    C = [0.0307 1.8449 1.5691];
    ctype = dimension;
    Lb = -pi*ones(1,ctype);
    Ub = pi*ones(1,ctype);
    
    position = 0.5*(rand(n, dimension)-.5); %Particulas Iniciais
    velocity = 0.3*randn(n, dimension);     %Velocidades Iniciais
    
    localBestPosition = position;
    currentFitness = zeros(1,n);
    globalBestPosition = zeros(n,dimension);
    
    for i = 1: n
        position(i,:) = Lb+(Ub-Lb).*rand(1,ctype);
        theta1 = rad2deg(position(i,1));
        theta2 = rad2deg(position(i,2));
        theta3 = rad2deg(position(i,3));
        
        ep1 = L1 * cos(theta1) + L2 * cos(theta1 + theta2) + L3 * cos(theta1 + theta2 + theta3);
        ep2 = L1 * sin(theta1) + L2 * sin(theta1 + theta2) + L3 * sin(theta1 + theta2 + theta3);
        ep = sqrt((ep1 - pfinal(1))^2 + (ep2 - pfinal(2))^2);
        ea = sqrt(( C(1) - position(i,1))^2 + (C(2) - position(i,2))^2 + (C(3) - position(i,3))^2);
        currentFitness(i) = 1/(w1*ep + w2*ea);
    end
    localBestFitness = currentFitness;
    [globalBestFitness, x] = min(localBestFitness);
    
    for i = 1:n
        globalBestPosition(i,:) = localBestPosition(x,:);
    end
    
    velocity = wheight*velocity + c1*(randn(n, dimension).*(localBestPosition - position)) + c2*(randn(n, dimension).*(globalBestPosition - position));
    
    position = velocity + position;
    
    for i = 1: m
        for k = 1:n
            theta1 = rad2deg(position(i,1));
            theta2 = rad2deg(position(i,2));
            theta3 = rad2deg(position(i,3));
        
            ep1 = L1 * cos(theta1) + L2 * cos(theta1 + theta2) + L3 * cos(theta1 + theta2 + theta3);
            ep2 = L1 * sin(theta1) + L2 * sin(theta1 + theta2) + L3 * sin(theta1 + theta2 + theta3);
            ep = sqrt((ep1 - pfinal(1))^2 + (ep2 - pfinal(2))^2);
            ea = sqrt(( C(1) - position(i,1))^2 + (C(2) - position(i,2))^2 + (C(3) - position(i,3))^2);
            currentFitness(k) = 1/(w1*ep + w2*ea);
        end
        
        for k = 1:n
            if currentFitness(k) < localBestFitness(k)
                localBestFitness(k) = currentFitness(k);
                localBestPosition(k,:) = position(k,:);
            end
        end
        
        [currentBestGlobalFitness, x] = min(localBestFitness);
        
        if currentBestGlobalFitness < globalBestFitness
            globalBestFitness = currentBestGlobalFitness;
            
            for k = 1:n
                globalBestPosition(k,:) = localBestPosition(x,:);
            end            
        end
        
        velocity = wheight*velocity + c1*(rand(n, dimension).*(localBestPosition - position)) + c2*(rand(n, dimension).*(globalBestPosition - position));
        position = position + velocity;
        best = x;
        fprintf('IT: %d\n',i);
        fprintf('ISTSE: %2.10f\n',currentBestGlobalFitness);
    end
    
    theta = rad2deg(position(best,:));
    px = L1 * cos(theta(1)) + L2 * cos(theta(1) + theta(2)) + L3 * cos(theta(1) + theta(2) + theta(3));
    py = L1 * sin(theta(1)) + L2 * sin(theta(1) + theta(2)) + L3 * sin(theta(1) + theta(2) + theta(3));
    disp([px py]);
    erro = currentBestGlobalFitness;
%end