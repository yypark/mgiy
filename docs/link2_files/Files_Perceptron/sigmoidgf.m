function out = sigmoidgf(in)
%%%%%%%%%%%%%%%%%%%%%%%%%%% Sig.m %%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose   : to implement Sigmoidal function
%
%
% Last modified 02/02/04 by Yul Young Park
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
out= 1 ./ (1 + exp(-in));