%%%%%%%%%%%%%%%%%%%%%%%%%%% trainingset.m %%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose   : to define training sets for neural network
%
% Last modified 02/03/04 by Yul Young Park
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% for better result, [+1,-1] are used instead of [1,0] ==> mainly for HW1a
LogicInput =  [ 1 1;1 -1;-1 1;-1 -1];   %4x2 matrix, 4-patterns, 2-inputs
ORTarget = [ 1;1;1;-1];                 %4x1 matrix, 4-patterns, 1-outputs
ANDTarget = [1;-1;-1;-1];               %4x1 matrix, 4-patterns, 1-outputs 
XORTarget = [-1;1;1;-1];                %4x1 matrix, 4-patterns, 1-outputs

% curve-fitting data for HW1b
xValue=[-1 -.9 -.8 -.7 -.6 -.5 -.4 -.3 -.2 -.1 0 .1 .2 .3 .4 .5 .6 .7 .8 .9 1]';
ylin= -0.5 + 2*xValue;
ysig1 = sigmoidgf(xValue);
ysig2 = sigmoidgf(xValue-0.5);
xquad = [0 .1 .2 .3 .4 .5 .6 .7 .8 .9 1]';
yquad = xValue.*(xValue-0.5);

% curve-fitting data for HW1c
xbp=[0 .1 .2 .3 .4 .5 .6 .7 .8 .9 1]';
ycurv = xbp.*(xbp-0.5);