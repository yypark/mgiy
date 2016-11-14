%%%%%%%%%%%%%%%%%%%%%%%%%%% testset.m %%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose   : to define test sets for the trained neural network
%
% Last modified 02/05/04 by Yul Young Park
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% for better result, [+1,-1] are used instead of [1,0]
% thus, 'testoutput < 0' means logical '0', 'testoutput > 0' means logical '1'

% for HW1a
test_LogicInput =  [ 1 1;1 -1;-1 1;-1 -1];   %4x2 matrix, 4-patterns, 2-inputs
% for HW1b
test_xValue = [-1 -.9 -.8 -.7 -.6 -.5 -.4 -.3 -.2 -.1 0 .1 .2 .3 .4 .5 .6 .7 .8 .9 1]';
test_xquad=[0 .1 .2 .3 .4 .5 .6 .7 .8 .9 1]';
% for HW1c
test_xbp = [0 .1 .2 .3 .4 .5 .6 .7 .8 .9 1]';
