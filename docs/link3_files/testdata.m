function test_signal = testdata()
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


% Source Location: Left, High, 1000Hz sine toneburst
load lh1000;
lh1k = []; lh1k.left = left ; lh1k.right = right; lh1k.target = [ 1,-1,-1,-1,-1, 1, 1, -1]; 
% Source Location: Left, High, 1500Hz sine toneburst
load lh1500;
lh1_5k = [];lh1_5k.left = left ; lh1_5k.right = right; lh1_5k.target = [ 1,-1,-1,-1,-1, 1, 1,-1]; 
% Source Location: Left, High, 2000Hz sine toneburst
load lh2000;
lh2k = []; lh2k.left = left ; lh2k.right = right; lh2k.target = [ 1,-1,-1,-1,-1, 1, 1,-1] ; 
% Source Location: Left, High, 2500Hz sine toneburst
load lh2500;
lh2_5k = []; lh2_5k.left = left ; lh2_5k.right = right; lh2_5k.target = [ 1,-1,-1,-1,-1, 1, 1,-1] ; 
% Source Location: Left, High, 3000Hz sine toneburst
load lh3000;
lh3k = [];lh3k.left = left ; lh3k.right = right; lh3k.target = [ 1,-1,-1,-1,-1, 1, 1,-1]; 
% Source Location: Left, High, 3500Hz sine toneburst
load lh3500;
lh3_5k = []; lh3_5k.left = left ; lh3_5k.right = right; lh3_5k.target = [ 1,-1,-1,-1,-1, 1, 1,-1]; 
% Source Location: Left, High, 4000Hz sine toneburst 
load lh4000;
lh4k = []; lh4k.left = left ; lh4k.right = right; lh4k.target = [ 1,-1,-1,-1,-1, 1, 1,-1]; 


% Source Location: Left, Low, 1000Hz sine toneburst
load ll1500;
ll1_5k = []; ll1_5k.left = left ; ll1_5k.right = right; ll1_5k.target = [ 1,-1,-1,-1,-1, 1,-1, 1]; 
% Source Location: Back, High, 1500Hz sine toneburst
load bh1500;
bh1_5k = []; bh1_5k.left = left ; bh1_5k.right = right; bh1_5k.target = [-1,-1, 1,-1, 1,-1, 1,-1]; 
% Source Location: Back, Low, 1500Hz sine toneburst
load bl1500;
bl1_5k = []; bl1_5k.left = left ; bl1_5k.right = right; bl1_5k.target = [-1,-1, 1,-1, 1,-1,-1, 1]; 
% Source Location: Front, High, 1500Hz sine toneburst
load fh1500;
fh1_5k = []; fh1_5k.left = left ; fh1_5k.right = right; fh1_5k.target = [-1,-1, 1, 1,-1,-1, 1,-1]; 
% Source Location: Front, Low, 1500Hz sine toneburst
load fl1500;
fl1_5k = []; fl1_5k.left = left ; fl1_5k.right = right; fl1_5k.target = [-1,-1, 1, 1,-1,-1,-1, 1]; 
% Source Location: Right, High, 1500Hz sine toneburst
load rh1500;
rh1_5k = []; rh1_5k.left = left ; rh1_5k.right = right; rh1_5k.target = [-1, 1,-1,-1,-1, 1, 1,-1]; 
% Source Location: Right, Low, 1500Hz sine toneburst 
load rl1500;
rl1_5k = []; rl1_5k.left = left ; rl1_5k.right = right; rl1_5k.target = [-1, 1,-1,-1,-1, 1,-1, 1]; 

% Source Location: Right, Low, 1500Hz sine toneburst 
load lhchir;
lhchir = []; lhchir.left = left ; lhchir.right = right; lhchir.target = [ 1,-1,-1,-1,-1, 1, 1,-1]; 



test_signal=[]; 
test_signal.lh1k=lh1k; test_signal.lh1_5k=lh1_5k; test_signal.lh2k=lh2k; test_signal.lh2_5k=lh2_5k; 
test_signal.lh3k=lh3k; test_signal.lh3_5k=lh3_5k; test_signal.lh4k=lh4k; 

test_signal.ll1_5k=ll1_5k; test_signal.bh1_5k=bh1_5k; test_signal.bl1_5k=bl1_5k; test_signal.fh1_5k=fh1_5k; 
test_signal.fl1_5k=fl1_5k; test_signal.rh1_5k=rh1_5k; test_signal.rl1_5k=rl1_5k; 

test_signal.lhchir=lhchir;