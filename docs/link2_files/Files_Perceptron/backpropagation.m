%%%%%%%%%%%%%%%%%%%%%%%%%%% TwoLN.m %%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose   : to implement 2-Layer Backpropagation Network
% Assumption: 2-layer network, 2 inputs, 1 output, 2 hidden units, 
%              
%
% Last modified 02/05/04 by Yul Young Park
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get training set data
trainingset;
testset;
% get parameters from the user
prompt={'Learning rate?','Number of Learning Trials?','Maximum MSE?','generating function?(stepgf,sigmoidgf,or lineargf)', ...
        'number of hidden units?', 'training set?(XOR,or CurveData)','random weight range?(1 for [-1,1])'};
dlgTitle='Please, Enter the Parameters.(Enter for the default value';
lineNo=1;
defaultV={'0.5', '5000','0.005','sigmoidgf','2','XOR','1'};
answer=inputdlg(prompt,dlgTitle,lineNo,defaultV);

eta = str2num(answer{1});       if isempty(eta), eta = str2num(defaultV{1}); end;
numtrial = str2num(answer{2});  if isempty(numtrial), numtrial = str2num(defaultV{2}); end;
maxMSE = str2num(answer{3});    if isempty(maxMSE), maxMSE = str2num(defaultV{3}); end;
genfunc = answer{4};            if isempty(genfunc), genfunc = defaultV{4}; end;
nhiddenunit = str2num(answer{5});if isempty(nhiddenunit), nhiddenunit = str2num(defaultV{5}); end;  % assume 2 hidden units --> # of elements in Wji, Wkj
traindata = answer{6};          if isempty(traindata), traindata = defaultV{6}; end;
wrange = str2num(answer{7});    if isempty(wrange), numinput = str2num(defaultV{7}); end;

% to assign traindata
switch traindata
    case 'XOR'
        inputpatterns = LogicInput;
        targetpatterns = XORTarget;
        testpattern = test_LogicInput;
    case 'CurveData'
        inputpatterns = xbp;
        targetpatterns = ycurv;
        testpattern = test_xbp;
end
% [r c] = size(matrix)
[poutput,noutput] = size(targetpatterns);
[pinput, ninput] = size(inputpatterns);

% Initialize several internal parameters
calcMSE = 100;      % initila MSE for backpropation learning
plotMSE =[];
debugnum01 = [];
trial = 0;
% Initialize weights with random number
% Typically, the small initial weights are chosen(-1~1 or -0.5~0.5)
%Y = rand(m,n) or Y = rand([m n]) returns an m-by-n matrix of random entries.
Wji = 2*wrange*rand(nhiddenunit,ninput) - wrange;   %2x2 matrix
Wkj = 2*wrange*rand(noutput,nhiddenunit) - wrange;  %1x2 matrix
Wj0 =  2*wrange*rand(nhiddenunit,1) - wrange; % threshold(bias) at hidden layer % 2x1 matrix
Wk0 =  2*wrange*rand(noutput,1) - wrange; % threshold(bias) at output layer        % 1x1 vector
alpha = 0; % momentum coefficient: to escape from the local minimum stuck. => for me, not effective


%Begin learning part of program: by Backpropagation Algorithm 
while ((calcMSE > maxMSE) && (trial < numtrial))
   
    % backpropagation learning rule (cf: LMS learning rule for single perceptron)
    for niteraton = 1:pinput  % Select RANDOMLY a pattern 8 times among 1=< p <P to avoid the stuck on the local minimum
        trial = trial + 1;
        pattern = floor(rand(1,1)*pinput + 1);      %a randomly chosen pattern
        %Compute hidden node inputs: net(1,p,j)
        net_1_p_j=Wji*inputpatterns(pattern,:)'+Wj0;    %2x1 matrix
        %Compute hidden node outputs: x(1,p,j)
        x_1_p_j=sigmoidgf(net_1_p_j);                   %2x1 matrix
        %Compute input to the output node: net(2,p,k)
        net_2_p_k = Wkj*x_1_p_j + Wk0;                  %1x1 vector
        %Compute network outputs: o(p,k)
        o_p_k = sigmoidgf(net_2_p_k);                   %1x1 vector
        debugnum01 = [debugnum01;o_p_k];
        
        %Compute the error between o(p,k) and desired output d(p,k)
        deltaError = targetpatterns(pattern,noutput) - o_p_k;   %1x1 vector
        errsig = deltaError*deltaError';                %if 1xn vector, transpose to get error signal
        
        % Record average error signal magnitude across all stimuli
        calcMSE = 0;
        for k = 1:pinput
            Inp = inputpatterns(k,:);                   %1x2
            Hid = sigmoidgf(Wji*Inp' + Wj0);            %2x1
            Out = sigmoidgf(Wkj*Hid + Wk0);             %1x1
            Targ = targetpatterns(k,:);                 %1x1
            ediff = (Targ-Out)'*(Targ-Out);             % if 1xn, then transpose
            calcMSE = calcMSE + (1/pinput)*ediff'*ediff;
        end;
        
        plotMSE = [plotMSE; calcMSE];
        
        %if (calcMSE < maxMSE)
        %    return;
        %end    
        
        %Error Backpropagation
        %Modify the weights between hidden and output nodes:
        % dW(2,1,k,j)=eta* (d(p,k)-o(p,k))*dS(net(2,p,k)) *x(1,p,j)
        delta_p_k = deltaError*o_p_k*(1-o_p_k);         %1x1 vector
        dWkj = eta.*delta_p_k.*x_1_p_j + alpha*Wkj';                 %2x1 matrix, alpha*Wkj=momentum
        dWk0 = eta.*delta_p_k + alpha*Wk0';                          %1x1 vector, alpha*Wk0=momentum

        %Modify the weights between input and hidden nodes:
        % dW(1,0,j,i)=eta*  sigma[k=1 to K, (d(p,k)-o(p,k))*dS(net(2,p,k))*W(2,1,k,j)]*dS(net(1,p,j)*x(0,p,i)
        mu_p_j = delta_p_k.*Wkj'.*x_1_p_j.*(1-x_1_p_j); % 2x1 matrix   %??????????????????
        dWji = eta*mu_p_j*inputpatterns(pattern,:)+alpha*Wji;     % [j x 1] x [1 x i] = [j x i], alpha*Wji=momentum
        dWj0 = eta*mu_p_j + alpha*Wj0;                            % 2x1 matrix, alpha*Wj0=momentum
 
        % 'pre-pattern' learning - update weights after every samplepresentation
        Wji = Wji + dWji;
        Wj0 = Wj0 + dWj0;
        Wkj = Wkj + dWkj';
        Wk0 = Wk0 + dWk0;
        % DISPLAY OUTPUT
        disp(['Trial #',int2str(trial),':','  Stimulus #',int2str(pattern),',  MSE = ',num2str(calcMSE),...
                ',  error signal = ',num2str(errsig)]);
    end;
end;

plot(plotMSE)
title('Convergence of MSE');
xlabel('trial number');
ylabel('MSE value');
disp('Training perceptron is completed. Now, the perceptron will be tested using test data set');

% calculate the test data set output
testoutput=testpattern;
for r = 1:length(testpattern)
    testHid = sigmoidgf(Wji*testpattern(r,:)' + Wj0);            %2x1
    testoutput(r,:) = sigmoidgf(Wkj*testHid + Wk0);
end

test_pattern = num2str(testpattern)
eval_genfunc = [genfunc,'(testoutput)'];
test_output = num2str(eval(eval_genfunc))
