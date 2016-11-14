function d_all = trainingdata()
% CS342 Neural Network Class Project: Sound Source Localization
% 
% signal type: tone burst, 500hz 2cyles in 1500msec window
% data sampling frequency: 44100 Hz
% sample size: 700 samples (1/44100 = 15.87msec)
%
% output is [Left/Right, Front/Back, High/Low] (total 8 locations)
% bipolar data representation
%
% [Left, Right, Middle, Front, Back, Half, High, Low]
% Middle -> b/w Left&Right, Half -> b/w Front&Back
% 8 locations => 
% left,low  =  [ 1,-1,-1,-1,-l, 1,-l, 1] 
% left,high  = [ 1,-1,-1,-1,-l, 1, l,-1] 
% right,low =  [-1, 1,-1,-1,-l, 1,-l, 1]
% right,high = [-1, 1,-1,-1,-l, 1, l,-1]
% back,low  =  [-1,-1, 1,-1, l,-1,-l, 1]
% back,high  = [-1,-1, 1,-1, l,-1, l,-1]
% front,low =  [-1,-1, 1, 1,-l,-1,-l, 1]
% front,high = [-1,-1, 1, 1,-l,-1, l,-1]

% last modified 12/01/04 by Yul Young Park 

% Source Location: Left, Low
load ll_500;
ll = [];ll.left = left ; ll.right = right; ll.target = [ 1,-1,-1,-1,-1, 1,-1, 1]; 
% Source Location: Left, High
load lh_500;
lh = [];lh.left = left ; lh.right = right; lh.target = [ 1,-1,-1,-1,-1, 1, 1,-1]; 
% Source Location: Right, Low
load rl_500;
rl = [];rl.left = left ; rl.right = right; rl.target = [-1, 1,-1,-1,-1, 1,-1, 1]; 
% Source Location: Right, High
load rh_500;
rh = [];rh.left = left ; rh.right = right; rh.target = [-1, 1,-1,-1,-1, 1, 1,-1]; 
% Source Location: Back, Low
load bl_500;
bl = [];bl.left = left ; bl.right = right; bl.target = [-1,-1, 1,-1, 1,-1,-1, 1]; 
% Source Location: Back, High
load bh_500;
bh = [];bh.left = left ; bh.right = right; bh.target = [-1,-1, 1,-1, 1,-1, 1,-1]; 
% Source Location: Front, Low
load fl_500;
fl = [];fl.left = left ; fl.right = right; fl.target = [-1,-1, 1, 1,-1,-1,-1, 1]; 
% Source Location: Front, High
load fh_500;
fh = [];fh.left = left ; fh.right = right; fh.target = [-1,-1, 1, 1,-1,-1, 1,-1]; 

d_all=[];
d_all.ll =ll; d_all.lh=lh; d_all.rl=rl; d_all.rh=rh; d_all.bl=bl; d_all.bh=bh; d_all.fl=fl; d_all.fh=fh;