%%%%%%%%%%%%%%%%%%%%%%%%%%% adaline.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose   : to implement an adaptive linear element(Adaline) proposed by
%             Widrow. Classification is done by minimizing MSE instead of
%             the number of misclassified samples
%
% Assumption: number of output = 1
%
% Last modified 02/04/04 by Yul Young Park
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get training set data
trainingset;
testset;
% get parameters from the user
prompt={'Learning rate?','Number of Learning Trials?','Maximum MSE?','generating function?(stepgf,sigmoidgf,or lineargf)', ...
        'number of inputs?', 'training set?(OR,AND,XOR,linear,sigmoid1,sigmoid2,quadratic)','random weight range?(1 for [-1,1])'};
dlgTitle='Please, Enter the Parameters.(Enter for the default value';
lineNo=1;
defaultV={'0.1', '100','0.005','stepgf','2','OR','1'};
answer=inputdlg(prompt,dlgTitle,lineNo,defaultV);

eta = str2num(answer{1});       if isempty(eta), eta = str2num(defaultV{1}); end;
numtrial = str2num(answer{2});  if isempty(numtrial), numtrial = str2num(defaultV{2}); end;
maxMSE = str2num(answer{3});    if isempty(maxMSE), maxMSE = str2num(defaultV{3}); end;
genfunc = answer{4};            if isempty(genfunc), genfunc = defaultV{4}; end;
numinput = str2num(answer{5});  if isempty(numinput), numinput = str2num(defaultV{5}); end;
traindata = answer{6};          if isempty(traindata), traindata = defaultV{6}; end;
wrange = str2num(answer{7});    if isempty(wrange), numinput = str2num(defaultV{7}); end;

% to assign traindata
switch traindata
    case 'OR'
        inputpatterns = LogicInput; %4x2 matrix
        targetpatterns = ORTarget;  %4x1 matrix
        testpattern = test_LogicInput;
    case 'AND'
        inputpatterns = LogicInput;
        targetpatterns = ANDTarget;
        testpattern = test_LogicInput;
    case 'XOR'
        inputpatterns = LogicInput;
        targetpatterns = XORTarget;
        testpattern = test_LogicInput;
    case 'linear'
        inputpatterns = xValue;
        targetpatterns = ylin;
        testpattern = test_xValue;
    case 'sigmoid1'
        inputpatterns = xValue;
        targetpatterns = ysig1;
        testpattern = test_xValue;
    case 'sigmoid2'
        inputpatterns = xValue;
        targetpatterns = ysig2;
        testpattern = test_xValue;
    case 'quadratic'
        inputpatterns = xquad;
        targetpatterns = yquad;
        testpattern = test_xquad;
end
% [r c] = size(matrix)
[poutput,noutput] = size(targetpatterns);
[pinput, ninput] = size(inputpatterns);     % pinput = poutput

% Initialize several internal parameters
calcMSE = 100;      % initila MSE for LMS learning algorithm
plotMSE =[];
trial = 0;

% for debugging
debugnum = [];

% Initialize weights with random number
% Typically, the small initial weights are chosen(-1~1 or -0.5~0.5)
% Y = rand(m,n) or Y = rand([m n]) returns an m-by-n matrix of random entries.
Wi = 2*wrange*rand(1,ninput) - wrange;      %1x2 matrix = [w1,w2)
W0 = -1;                                    % bias (or threshold) 

%Begin learning part of program: by Backpropagation Algorithm 
while ((calcMSE > maxMSE) && (trial < numtrial))
    trial = trial + 1;
    
    % LMS learning rule for single perceptron)
        
    % select a input randomly from 'pinputs'
    %j = round(rand(1,1)*(pinput - 1) + 1);
    j = floor(rand(1,1)*pinput + 1); 
    Inp = inputpatterns(j,:);  % 1x2 matrix
    Targ = targetpatterns(j,:);  % 1x1 vector
    
    %Compute resoponse of network

    Outp_pre = Wi*Inp' + W0;
    eval_Outp = [genfunc,'(Outp_pre)'];
    Outp = eval(eval_Outp);
    % Take a Gradient Descent Step and update weights
    dEdw = -(Targ - Outp)*Inp;   % 1x2 matrix for dWi
    dEdb = -(Targ - Outp);       % 1x1 vector for dW0
    Wi = Wi - eta * dEdw;
    W0 = W0 - eta * dEdb;
    
    % Record error signal magnitude for that step
    errsig = (Targ - Outp)'*(Targ - Outp);
    
    % Record average error signal magnitude across all stimuli
    calcMSE = 0;
    for k = 1:pinput
        pink_pre = (Wi*inputpatterns(k,:)' + W0);
        eval_pink_pre = [genfunc,'(pink_pre)'];
        pink = eval(eval_pink_pre);
        ediff = targetpatterns(k,:) - pink;
        calcMSE = calcMSE + (1/pinput)*ediff'*ediff;
    end;
    plotMSE = [plotMSE; calcMSE];
    
    % If response of network has a different SIGN relative to desired response
    % then that is counted as an incorrect classification =>
    % counting the number of misclassification => for later improvement
    misclass = mean(sign(Outp) ~= sign(Targ));  % for Logic input, 1 or 0
    
    % DISPLAY OUTPUT
    disp(['Trial #',int2str(trial),':',...
      '  Stimulus #',int2str(j),',  MSE = ',num2str(calcMSE),...
      ',  error signal = ',num2str(errsig),',  # of misclassification = ',num2str(misclass)]);
    
end;
plot(plotMSE)
title('Convergence of MSE');
xlabel('trial number');
ylabel('MSE value');
disp('Training perceptron is completed. Now, the perceptron will be tested using test data set');

testoutput=testpattern;
for r = 1:length(testpattern)
    testoutput(r,:) = Wi*testpattern(r,:)' + W0;
end

test_pattern = num2str(testpattern)
eval_genfunc = [genfunc,'(testoutput(:,1))'];
test_output = num2str(eval(eval_genfunc))
