function [net_out,Wkj,Wk0,Wji,Wj0] = nn_bp(data,eta,numtrial,maxMSE,genfunc,nhiddenunit,wrange,alpha)
%%%%%%%%%%%%%%%%%%%%%%%%%%% nn_bp.m %%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose   : to implement 2-Layer Backpropagation Network
%  
% Input Parameters :
%   process: 'Learing' or 'Test'
%   data: structure data -> data.input: Input Patterns, data.target: Output Patterns     
%   eta: Learning Rate
%   numtrial: total trial number
%   maxMSE: MSE threshold
%   genfunc: Activation Function
%   nhiddenunit: Number of Hidden Units
%   wrange: Randodm Weight Initialization Range
%   alpha: momentum
%
% Output Parameters
%   net_out: source location, ( [Left,Right,Middle] for ITD, 
%   Wkj: Weights b/w output and hidden layer
%   Wk0: bias b/w output and hidden layer
%   Wji: Weights b/w hidden and input layer
%   Wj0: bias b/w hidden and input layer
%
% Last modified 12/03/04 by Yul Young Park
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inputpatterns = data.input;
targetpatterns = data.target;

% [r c] = size(matrix)
[poutput,noutput] = size(targetpatterns);
[pinput, ninput] = size(inputpatterns); %257x217

% Initialize several internal parameters
calcMSE = 100;      % initila MSE for backpropation learning
plotMSE =[];
debugnum01 = [];
trial = 0;

% Initialize weights with random number
% Typically, the small initial weights are chosen(-1~1 or -0.5~0.5)
%Y = rand(m,n) or Y = rand([m n]) returns an m-by-n matrix of random entries.
Wji = 2*wrange*rand(nhiddenunit,ninput) - wrange;   % JxI matrix
Wkj = 2*wrange*rand(noutput,nhiddenunit) - wrange;  % KxJ matrix
Wj0 = 2*wrange*rand(nhiddenunit,1) - wrange;        % threshold(bias) at hidden layer, Jx1 matrix
Wk0 = 2*wrange*rand(noutput,1) - wrange;            % threshold(bias) at output layer, Kx1 vector
%  Wji = wrange*rand(nhiddenunit,ninput);  % JxI matrix 
%  Wkj = wrange*rand(noutput,nhiddenunit); % KxJ matrix
%  Wj0 = wrange*rand(nhiddenunit,1);       % threshold(bias) at hidden layer, Jx1 matrix
%  Wk0 = wrange*rand(noutput,1);           % threshold(bias) at output layer, Kx1 vector

[rWji cWji] = size(Wji); [rWkj cWkj]=size(Wkj);
dWji=zeros(rWji,cWji);
dWj0=zeros(rWji,1);
dWkj=zeros(rWkj,cWkj);
dWk0=zeros(rWkj,1);

%Begin learning part of program: by Backpropagation Algorithm 
while ((calcMSE > maxMSE) && (trial < numtrial))
    
    % backpropagation learning rule (cf: LMS learning rule for single perceptron)
    for niteraton = 1:pinput  % Select RANDOMLY a pattern 8 times among 1=< p <P to avoid the stuck on the local minimum
        trial = trial + 1;
        pattern = floor(rand(1,1)*pinput + 1);      %a randomly chosen pattern
        % Input = 1xI vector, Hidden Unit = JxI and KxJ matrix, Output = Kx1 vector
        %Compute hidden node inputs: net(1,p,j)
        net_1_p_j=Wji*inputpatterns(pattern,:)'+Wj0;    %Jx1 matrix,
        %Compute hidden node outputs: x(1,p,j)
        %x_1_p_j=sigmoidgf(net_1_p_j);                   %Jx1 matrix
        x_1_p_j=bipolar_sig(net_1_p_j);                   %Jx1 matrix
        
        %Compute input to the output node: net(2,p,k)
        net_2_p_k = Wkj*x_1_p_j + Wk0;                  %Kx1 vector
        %Compute network outputs: o(p,k)
        %o_p_k = sigmoidgf(net_2_p_k);                   %Kx1 vector
        o_p_k = bipolar_sig(net_2_p_k);                   %Kx1 vector
        
        debugnum01 = [debugnum01,o_p_k];
        
        %Compute the error between o(p,k) and desired output d(p,k)
        deltaError = targetpatterns(pattern,[1:noutput]) - o_p_k';   % 1xK vector
        errsig = deltaError*deltaError';                %if 1xn vector, transpose to get error signal
        
        
        
        %if errisg 
        
        %Error Backpropagation
        %Modify the weights between hidden and output nodes:
        % dW(2,1,k,j)=eta* (d(p,k)-o(p,k))*dS(net(2,p,k)) *x(1,p,j)
        %delta_p_k = deltaError'.*(o_p_k.*(1-o_p_k));         % Kx1vector, sigmoid
        delta_p_k = deltaError'.*((1+o_p_k).*(1-o_p_k))/2;    % Kx1 vector, bipolar sigmoid
        
        dWkj = eta.*delta_p_k*x_1_p_j' + alpha*dWkj;        % KxJ matrix, alpha*dWkj=momentum
        dWk0 = eta.*delta_p_k + alpha*dWk0;                  % Kx1 vector, alpha*dWk0=momentum
        
        %Modify the weights between input and hidden nodes:
        % dW(1,0,j,i)=eta*  sigma[k=1 to K, (d(p,k)-o(p,k))*dS(net(2,p,k))*W(2,1,k,j)]*dS(net(1,p,j)*x(0,p,i)
        % mu_p_j = (delta_p_k'.*Wkj)'.*(x_1_p_j.*(1-x_1_p_j));     % Jx1 vector   %??????????????????
        mu_p_j = ((delta_p_k')*Wkj)'.*((1+x_1_p_j).*(1-x_1_p_j))/2;     % Jx1 vector   %??????????????????
        
        dWji = eta*mu_p_j*inputpatterns(pattern,:)+alpha*dWji;     % [j x 1] x [1 x i] = [j x i], alpha*Wji=momentum
        dWj0 = eta*mu_p_j + alpha*dWj0;                            % 2x1 matrix, alpha*Wj0=momentum
        
        % 'pre-pattern' learning - update weights after every samplepresentation
        Wji = Wji + dWji;
        Wj0 = Wj0 + dWj0;
        
        Wkj = Wkj + dWkj;
        Wk0 = Wk0 + dWk0;
        
        % Record average error signal magnitude across all stimuli
        calcMSE = 0;
        for k = 1:pinput
            Inp = inputpatterns(k,:);                   %1xI
            %Hid = sigmoidgf(Wji*Inp' + Wj0);            %Jx1
            %Out = sigmoidgf(Wkj*Hid + Wk0);             %Kx1
            Hid = bipolar_sig(Wji*Inp' + Wj0);            %Jx1
            Out = bipolar_sig(Wkj*Hid + Wk0);             %Kx1
            
            Targ = targetpatterns(k,:);                 %1xK
            calcMSE = sum(sum((Targ'-Out).^2))/pinput;
            
        end;
        plotMSE = [plotMSE; calcMSE];
        
        % DISPLAY OUTPUT
        
        %disp(['Trial #',int2str(trial),':','  Stimulus #',int2str(pattern),',  MSE = ',num2str(calcMSE),...
        %        ',  error signal = ',num2str(errsig)]);
    end;
    
end;

disp(['Trial #',int2str(trial),':','  Stimulus #',int2str(pattern),',  MSE = ',num2str(calcMSE),...
        ',  error signal = ',num2str(errsig)]);

figure
plot(plotMSE)
title('Convergence of MSE');
xlabel('trial number');
ylabel('MSE value');

net_out = Out > 0; % >0 ; 1 for bipolar sigmoid


        

