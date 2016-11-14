function [expected_output,test_output] = nn_test(test_d,Wkj,Wk0,Wji,Wj0)
% CS342 Neural Network Class Project: Sound Source Localization
% 
%
% last modified 12/02/04 by Yul Young Park 

Fs = 44100;         % data sampling frequency
N=512;              % num. points of FFT, Max FFT point of specgram
win_len = fix(N*0.1);      % STFT window size, should be smaller than FFT length(256)
win = hamming(win_len);
% time resolution=> k = fix(('inputsignal length'-num_overlap)/(length(win)-num_overlap)) 
num_overlap = fix(win_len*0.95); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Left High 4000Hz sine tone burst
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% freq.-time information of the input
[B_lh4k_l, F_lh4k_l, T_lh4k_l ] = specgram(test_d.lh4k.left,N,Fs,win,num_overlap);
[B_lh4k_r, F_lh4k_r, T_lh4k_r ] = specgram(test_d.lh4k.right,N,Fs,win,num_overlap);

% characteristics extraction and manipulation
% What if there is non-linear combination between them ?
% input signal
SO_LH4K_L = 20*log10(abs(B_lh4k_l)) - 20*log10(abs(B_lh4k_r)); % 257(freq.) x 217(time) matrix -> for network training
SO_LH4K_R = 20*log10(abs(B_lh4k_r)) - 20*log10(abs(B_lh4k_l)); % 257(freq.) x 217(time) matrix -> for visualization only
[r_data, c_data]=size(SO_LH4K_L);
sel_index=1:16:r_data;
SO_LH4K = SO_LH4K_L(sel_index,:);
[r_d, c_d]=size(SO_LH4K);
% target signal
EXP_LH4K=repmat(test_d.lh4k.target,r_d,1);


% Data visulization
text_str = 'Test:4k-sine tb,L/H';
nn_plot(test_d.lh4k.left, test_d.lh4k.right,B_lh4k_l,B_lh4k_r,T_lh4k_l,F_lh4k_l,SO_LH4K_L,SO_LH4K_R,text_str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Left High 2000Hz sine tone burst
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% freq.-time information of the input
[B_lh2k_l, F_lh2k_l, T_lh2k_l ] = specgram(test_d.lh2k.left,N,Fs,win,num_overlap);
[B_lh2k_r, F_lh2k_r, T_lh2k_r ] = specgram(test_d.lh2k.right,N,Fs,win,num_overlap);

% characteristics extraction and manipulation
% What if there is non-linear combination between them ?
% input signal
SO_LH2K_L = 20*log10(abs(B_lh2k_l)) - 20*log10(abs(B_lh2k_r)); % 257(freq.) x 217(time) matrix -> for network training
SO_LH2K_R = 20*log10(abs(B_lh2k_r)) - 20*log10(abs(B_lh2k_l)); % 257(freq.) x 217(time) matrix -> for visualization only
[r_data, c_data]=size(SO_LH2K_L);
sel_index=1:16:r_data;
SO_LH2K = SO_LH2K_L(sel_index,:);
[r_d, c_d]=size(SO_LH2K);
% target signal
EXP_LH2K=repmat(test_d.lh2k.target,r_d,1);

% Data visulization
text_str = 'Test:2k-sine tb,L/H';
nn_plot(test_d.lh2k.left, test_d.lh2k.right,B_lh2k_l,B_lh2k_r,T_lh2k_l,F_lh2k_l,SO_LH2K_L,SO_LH2K_R,text_str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Right High 1500Hz sine tone burst
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% freq.-time information of the input
[B_rh1_5k_l, F_rh1_5k_l, T_rh1_5k_l ] = specgram(test_d.rh1_5k.left,N,Fs,win,num_overlap);
[B_rh1_5k_r, F_rh1_5k_r, T_rh1_5k_r ] = specgram(test_d.rh1_5k.right,N,Fs,win,num_overlap);

% characteristics extraction and manipulation
% What if there is non-linear combination between them ?
% input signal
SO_RH1_5K_L = 20*log10(abs(B_rh1_5k_l)) - 20*log10(abs(B_rh1_5k_r)); % 257(freq.) x 217(time) matrix -> for network training
SO_RH1_5K_R = 20*log10(abs(B_rh1_5k_r)) - 20*log10(abs(B_rh1_5k_l)); % 257(freq.) x 217(time) matrix -> for visualization only
[r_data, c_data]=size(SO_RH1_5K_L);
sel_index=1:16:r_data;
SO_RH1_5K = SO_RH1_5K_L(sel_index,:);
[r_d, c_d]=size(SO_RH1_5K);
% target signal
EXP_RH1_5K=repmat(test_d.rh1_5k.target,r_d,1);

% Data visulization
text_str = 'Test:1.5k-sine tb,R/H';
nn_plot(test_d.rh1_5k.left, test_d.rh1_5k.right,B_rh1_5k_l,B_rh1_5k_r,T_rh1_5k_l,F_rh1_5k_l,SO_RH1_5K_L,SO_RH1_5K_R,text_str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Back High 1500Hz sine tone burst
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% freq.-time information of the input
[B_bh1_5k_l, F_bh1_5k_l, T_bh1_5k_l ] = specgram(test_d.bh1_5k.left,N,Fs,win,num_overlap);
[B_bh1_5k_r, F_bh1_5k_r, T_bh1_5k_r ] = specgram(test_d.bh1_5k.right,N,Fs,win,num_overlap);

% characteristics extraction and manipulation
% What if there is non-linear combination between them ?
% input signal
SO_BH1_5K_L = 20*log10(abs(B_bh1_5k_l)) - 20*log10(abs(B_bh1_5k_r)); % 257(freq.) x 217(time) matrix -> for network training
SO_BH1_5K_R = 20*log10(abs(B_bh1_5k_r)) - 20*log10(abs(B_bh1_5k_l)); % 257(freq.) x 217(time) matrix -> for visualization only
[r_data, c_data]=size(SO_BH1_5K_L);
sel_index=1:16:r_data;
SO_BH1_5K = SO_BH1_5K_L(sel_index,:);
[r_d, c_d]=size(SO_BH1_5K);
% target signal
EXP_BH1_5K=repmat(test_d.bh1_5k.target,r_d,1);

% Data visulization
text_str = 'Test:1.5k-sine tb,B/H';
nn_plot(test_d.bh1_5k.left, test_d.bh1_5k.right,B_bh1_5k_l,B_bh1_5k_r,T_bh1_5k_l,F_bh1_5k_l,SO_BH1_5K_L,SO_BH1_5K_R,text_str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Front High 1500Hz sine tone burst
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% freq.-time information of the input
[B_fh1_5k_l, F_fh1_5k_l, T_fh1_5k_l ] = specgram(test_d.fh1_5k.left,N,Fs,win,num_overlap);
[B_fh1_5k_r, F_fh1_5k_r, T_fh1_5k_r ] = specgram(test_d.fh1_5k.right,N,Fs,win,num_overlap);

% characteristics extraction and manipulation
% What if there is non-linear combination between them ?
% input signal
SO_FH1_5K_L = 20*log10(abs(B_fh1_5k_l)) - 20*log10(abs(B_fh1_5k_r)); % 257(freq.) x 217(time) matrix -> for network training
SO_FH1_5K_R = 20*log10(abs(B_fh1_5k_r)) - 20*log10(abs(B_fh1_5k_l)); % 257(freq.) x 217(time) matrix -> for visualization only
[r_data, c_data]=size(SO_FH1_5K_L);
sel_index=1:16:r_data;
SO_FH1_5K = SO_FH1_5K_L(sel_index,:);
[r_d, c_d]=size(SO_FH1_5K);
% target signal
EXP_FH1_5K=repmat(test_d.fh1_5k.target,r_d,1);

% Data visulization
text_str = 'Test:1.5k-sine tb,F/H';
nn_plot(test_d.fh1_5k.left, test_d.fh1_5k.right,B_fh1_5k_l,B_fh1_5k_r,T_fh1_5k_l,F_fh1_5k_l,SO_FH1_5K_L,SO_FH1_5K_R,text_str);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% expected outcom
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
expected_output=[];
expected_output=[EXP_LH4K; EXP_LH2K; EXP_RH1_5K; EXP_BH1_5K; EXP_FH1_5K]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% all test data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
testpattern = [SO_LH4K; SO_LH2K; SO_RH1_5K; SO_BH1_5K; SO_FH1_5K];


[row,col]=size(testpattern);
% calculate the test data set output
testoutput=[];
for r = 1:row
    %testHid = sigmoidgf(Wji*testpattern(r,:)' + Wj0);            %Jx1
    %testoutput(r,:) = sigmoidgf(Wkj*testHid + Wk0);              %Kx1
    testHid = bipolar_sig(Wji*testpattern(r,:)' + Wj0);            %Jx1
    testoutput(:,r) = bipolar_sig(Wkj*testHid + Wk0);              %Kx1

end

test_pattern = num2str(testpattern);
% genfunc='bipolar_sig';
% eval_genfunc = [genfunc,'(testoutput)'];
% test_output = eval(eval_genfunc)' > 0
% network output
test_output = testoutput'



