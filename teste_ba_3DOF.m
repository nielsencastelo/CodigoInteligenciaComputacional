%function [Kp,Ki,ISTSE] = BA(it,pop,C,Gs)
clear; clc; close all;
    it = 500;
    pop = 80;
    % Fator de ponderação
    w1 = 0.12;
    w2 = 0.88;
    
    % Posição final do manipulador
%     pfinal = [20 10];
%     pfinal = [-10 15];
    pfinal = [60 10];

    % Parâmetros do manipulador
    L1 = 10;
    L2 = 10;
    L3 = 10;
    
    % -------------- INÍCIO DO CÓDIGO --------------

    % ======================================================= %
    % Os parâmetros internos do Bat Algorithm encontram-se    %
    % definidos nesta seção, esses podem ser modificados para %
    % garantir o melhor desempenho.                           %
    % ======================================================= %
    % População inicial de morcegos
    n = pop;
    % Número de gerações
    N_gen = it;
    % Valores iniciais de amplitude(A) e Frequencia(r)
    A = 0.5;
    r = 0.5;

    % Esta é a faixa de frequência, ela determina as escalas
    % Os valores podem ser alterados conforme necessário
    Qmin = 0;         % Frequência mínima
    Qmax = 100;         % Frequência máxima
    % ======================================================= %
    % Fim dos parametros internos do Bat Algorithm            %
    % ======================================================= %

    % ======================================================= %
    % Os parâmetros do sistema de controle do trocador de     %
    % calor encontram-se definidos nesta seção, para maiores  %
    % informações consultar (De Paula; Damasceno, 2014).      %
    % ======================================================= %
    % Função de Transferência do Processo
    
    % ======================================================= %
    % Fim dos parametros do sistema de controle               %
    % ======================================================= %
    
    % ======================================================= %
    % Início das iterações do Bat Algorithm                   %
    % ======================================================= %
    % Inicia com em graus
    C = rad2deg([0.0307 1.8449 1.5691]);
    
    ctype = length(C);
    dim = ctype;      
    % Limite inferior de Busca 
    Lb = 0*ones(1,dim);
    % Limite superior de Busca
    Ub = 360*ones(1,dim);
    % Inicializando vetores
    Q = zeros(n,1);   % Frequencia
    v = zeros(n,dim); % Velocidade
    Fitness = zeros(1,n);
    Sol = zeros(n,dim);
    % Inicializando a população de morcegos
    for i = 1:n
        Sol(i,:)= Lb+(Ub-Lb).*rand(1,dim);
        
        theta1 = Sol(i,1);
        theta2 = Sol(i,2);
        theta3 = Sol(i,3);
        
        ep1 = L1 * cos(theta1) + L2 * cos(theta1 + theta2) + L3 * cos(theta1 + theta2 + theta3);
        ep2 = L1 * sin(theta1) + L2 * sin(theta1 + theta2) + L3 * sin(theta1 + theta2 + theta3);
        ep = sqrt((ep1 - pfinal(1))^2 + (ep2 - pfinal(2))^2);
        %ea = sqrt(( C(1) - theta1)^2 + (C(2) - theta2)^2 + (C(3) - theta3)^2);
        Fitness(i) = ep;
    end
    % Encontra a melhor solução inicial
    [fmin,I] = min(Fitness);
    best = Sol(I,:);
    % Início do Laço Principal
    for t1 = 1 : N_gen,
        % Laço de iteração sobre todos os vetores (soluções candidatas)
        for i = 1:n,

            % Atualiza posição do morcego
            Q(i) = Qmin + (Qmin - Qmax)*rand;
            v(i,:) = v(i,:)+(Sol(i,:)- best)*Q(i);
            S(i,:) = Sol(i,:)+v(i,:);

            % Aplica limites
            Sol(i,:) = simplebounds(Sol(i,:),Lb,Ub);

            % Taxa de Pulsos
            if rand > r
                % O fator 0.1 limita o tamanho do passo nos voos aleatorios
                S(i,:) = best + 0.1*randn(1,dim);
            end
            % Avalia nova solução
            theta1 = S(i,1);
            theta2 = S(i,2);
            theta3 = S(i,3);
        
            ep1 = L1 * cos(theta1) + L2 * cos(theta1 + theta2) + L3 * cos(theta1 + theta2 + theta3);
            ep2 = L1 * sin(theta1) + L2 * sin(theta1 + theta2) + L3 * sin(theta1 + theta2 + theta3);
            ep = sqrt((ep1 - pfinal(1))^2 + (ep1 - pfinal(2))^2);
            %ea = sqrt(( C(1) - theta1)^2 + (C(2) - theta2)^2 + (C(3) - theta3)^2);
                                   
            Fnew = ep;

            if (Fnew<=Fitness(i)) & (rand<A)
                Sol(i,:) = S(i,:);
                Fitness(i)=Fnew;
            end
            % Atualiza a melhor solução atual
            if Fnew <= fmin
                best = S(i,:);
                fmin = Fnew;
            end
        end
        %N_iter = N_iter + n;
        fprintf('IT: %d\n',t1);
        fprintf('Erro: %2.10f\n',fmin);
    end % Fim do Laço Principal
    theta = best;
   
    px = L1 * cos(theta(1)) + L2 * cos(theta(1) + theta(2)) + L3 * cos(theta(1) + theta(2) + theta(3));
    py = L1 * sin(theta(1)) + L2 * sin(theta(1) + theta(2)) + L3 * sin(theta(1) + theta(2) + theta(3));
    
% end
disp([px py]);