function out = bipolar_sig(in)
%%%%%%%%%%%%%%%%%%%%%%%%%%% Sig.m %%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose   : to implement Sigmoidal function
%
%
% Last modified 02/02/04 by Yul Young Park
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
out= 2 ./(1 + exp(-in)) - 1;