function [Wkj,Wk0,Wji,Wj0] = nn_training(signal)
% CS342 Neural Network Class Project: Sound Source Localization
% 
% Sampling Frequency: 44100 Hz
% Test Signal: chirp, toneburst
% input parameters: 
%   signal: all training data, signal.left->left ear signal, signal.right->right ear signal
%
% output parameters: Network Weights
%   Wkj: Weights b/w output and hidden layer
%   Wk0: bias b/w output and hidden layer
%   Wji: Weights b/w hidden and input layer
%   Wj0: bias b/w hidden and input layer
%
% last modified 12/02/04 by Yul Young Park 

Fs = 44100;         % data sampling frequency
N=512;              % num. points of FFT, Max FFT point of specgram
win_len = fix(N*0.1);      % STFT window size, should be smaller than FFT length(256)
win = hamming(win_len);
% time resolution=> k = fix(('inputsignal length'-num_overlap)/(length(win)-num_overlap)) 
num_overlap = fix(win_len*0.95); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Left Low Source Location Signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% freq.-time information of the input
[B_ll_l, F_ll_l, T_ll_l ] = specgram(signal.ll.left,N,Fs,win,num_overlap);
[B_ll_r, F_ll_r, T_ll_r ] = specgram(signal.ll.right,N,Fs,win,num_overlap);

% characteristics extraction and manipulation
% What if there is non-linear combination between them ?
% input signal
MSO_LL_L = 20*log10(abs(B_ll_l)) - 20*log10(abs(B_ll_r)); % 257(freq.) x 217(time) matrix -> for network training
MSO_LL_R = 20*log10(abs(B_ll_r)) - 20*log10(abs(B_ll_l)); % 257(freq.) x 217(time) matrix -> for visualization only
[r_data, c_data]=size(MSO_LL_L);
sel_index=1:16:r_data;
MSO_LL=MSO_LL_L(sel_index,:);
[r_d, c_d]=size(MSO_LL);
% target signal
TAR_LL=repmat(signal.ll.target,r_d,1);

% Data visulization
text_str = 'left low';
nn_plot(signal.ll.left, signal.ll.right,B_ll_l,B_ll_r,T_ll_l,F_ll_l,MSO_LL_L,MSO_LL_R,text_str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Left High Source Location Signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% freq.-time information of the input
[B_lh_l, F_lh_l, T_lh_l ] = specgram(signal.lh.left,N,Fs,win,num_overlap);
[B_lh_r, F_lh_r, T_lh_r ] = specgram(signal.lh.right,N,Fs,win,num_overlap);

% characteristics extraction and manipulation
% input signal
MSO_LH_L = 20*log10(abs(B_lh_l)) - 20*log10(abs(B_lh_r)); % 257(freq.) x 217(time) matrix -> for network training
MSO_LH_R = 20*log10(abs(B_lh_r)) - 20*log10(abs(B_lh_l)); % 257(freq.) x 217(time) matrix -> for visualization only
[r_data, c_data]=size(MSO_LH_L);
sel_index=1:16:r_data;
MSO_LH=MSO_LH_L(sel_index,:);
[r_d, c_d]=size(MSO_LH);
% target signal
TAR_LH=repmat(signal.lh.target,r_d,1);

% Data visulization
text_str = 'left high';
nn_plot(signal.lh.left, signal.lh.right,B_lh_l,B_lh_r,T_lh_l,F_lh_l,MSO_LH_L,MSO_LH_R,text_str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Right Low Source Location Signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% freq.-time information of the input
[B_rl_l, F_rl_l, T_rl_l ] = specgram(signal.rl.left,N,Fs,win,num_overlap);
[B_rl_r, F_rl_r, T_rl_r ] = specgram(signal.rl.right,N,Fs,win,num_overlap);

% characteristics extraction and manipulation
% input signal
MSO_RL_L = 20*log10(abs(B_rl_l)) - 20*log10(abs(B_rl_r)); 
MSO_RL_R = 20*log10(abs(B_rl_r)) - 20*log10(abs(B_rl_l)); 
[r_data, c_data]=size(MSO_RL_L);
sel_index=1:16:r_data;
MSO_RL=MSO_RL_L(sel_index,:);
[r_d, c_d]=size(MSO_RL);
% target signal
TAR_RL=repmat(signal.rl.target,r_d,1);

% Data visulization
text_str = 'right low';
nn_plot(signal.rl.left, signal.rl.right,B_rl_l,B_rl_r,T_rl_l,F_rl_l,MSO_RL_L,MSO_RL_R,text_str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Right High Source Location Signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% freq.-time information of the input
[B_rh_l, F_rh_l, T_rh_l ] = specgram(signal.rh.left,N,Fs,win,num_overlap);
[B_rh_r, F_rh_r, T_rh_r ] = specgram(signal.rh.right,N,Fs,win,num_overlap);

% characteristics extraction and manipulation
% input signal
MSO_RH_L = 20*log10(abs(B_rh_l)) - 20*log10(abs(B_rh_r)); 
MSO_RH_R = 20*log10(abs(B_rh_r)) - 20*log10(abs(B_rh_l)); 
[r_data, c_data]=size(MSO_RH_L);
sel_index=1:16:r_data;
MSO_RH=MSO_RH_L(sel_index,:);
[r_d, c_d]=size(MSO_RH);
% target signal
TAR_RH=repmat(signal.rh.target,r_d,1);

% Data visulization
text_str = 'right high';
nn_plot(signal.rh.left, signal.rh.right,B_rh_l,B_rh_r,T_rh_l,F_rh_l,MSO_RH_L,MSO_RH_R,text_str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Back Low Source Location Signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% freq.-time information of the input
[B_bl_l, F_bl_l, T_bl_l ] = specgram(signal.bl.left,N,Fs,win,num_overlap);
[B_bl_r, F_bl_r, T_bl_r ] = specgram(signal.bl.right,N,Fs,win,num_overlap);

% characteristics extraction and manipulation
% input signal
MSO_BL_L = 20*log10(abs(B_bl_l)) - 20*log10(abs(B_bl_r)); 
MSO_BL_R = 20*log10(abs(B_bl_r)) - 20*log10(abs(B_bl_l)); 
[r_data, c_data]=size(MSO_BL_L);
sel_index=1:16:r_data;
MSO_BL=MSO_BL_L(sel_index,:);
[r_d, c_d]=size(MSO_BL);
% target signal
TAR_BL=repmat(signal.bl.target,r_d,1);

% Data visulization
text_str = 'back low';
nn_plot(signal.bl.left, signal.bl.right,B_bl_l,B_bl_r,T_bl_l,F_bl_l,MSO_BL_L,MSO_BL_R,text_str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Back High Source Location Signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% freq.-time information of the input
[B_bh_l, F_bh_l, T_bh_l ] = specgram(signal.bh.left,N,Fs,win,num_overlap);
[B_bh_r, F_bh_r, T_bh_r ] = specgram(signal.bh.right,N,Fs,win,num_overlap);

% characteristics extraction and manipulation
% input signal
MSO_BH_L = 20*log10(abs(B_bh_l)) - 20*log10(abs(B_bh_r)); 
MSO_BH_R = 20*log10(abs(B_bh_r)) - 20*log10(abs(B_bh_l)); 
[r_data, c_data]=size(MSO_BH_L);
sel_index=1:16:r_data;
MSO_BH=MSO_BH_L(sel_index,:);
[r_d, c_d]=size(MSO_BH);
% target signal
TAR_BH=repmat(signal.bh.target,r_d,1);

% Data visulization
text_str = 'back high';
nn_plot(signal.bh.left, signal.bh.right,B_bh_l,B_bh_r,T_bh_l,F_bh_l,MSO_BH_L,MSO_BH_R,text_str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Front Low Source Location Signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% freq.-time information of the input
[B_fl_l, F_fl_l, T_fl_l ] = specgram(signal.fl.left,N,Fs,win,num_overlap);
[B_fl_r, F_fl_r, T_fl_r ] = specgram(signal.fl.right,N,Fs,win,num_overlap);

% characteristics extraction and manipulation
% input signal
MSO_FL_L = 20*log10(abs(B_fl_l)) - 20*log10(abs(B_fl_r)); 
MSO_FL_R = 20*log10(abs(B_fl_r)) - 20*log10(abs(B_fl_l)); 
[r_data, c_data]=size(MSO_FL_L);
sel_index=1:16:r_data;
MSO_FL=MSO_FL_L(sel_index,:);
[r_d, c_d]=size(MSO_FL);
% target signal
TAR_FL=repmat(signal.fl.target,r_d,1);

% Data visulization
text_str = 'front low';
nn_plot(signal.fl.left, signal.fl.right,B_fl_l,B_fl_r,T_fl_l,F_fl_l,MSO_FL_L,MSO_FL_R,text_str);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Front High Source Location Signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% freq.-time information of the input
[B_fh_l, F_fh_l, T_fh_l ] = specgram(signal.fh.left,N,Fs,win,num_overlap);
[B_fh_r, F_fh_r, T_fh_r ] = specgram(signal.fh.right,N,Fs,win,num_overlap);

% characteristics extraction and manipulation
% input signal
MSO_FH_L = 20*log10(abs(B_fh_l)) - 20*log10(abs(B_fh_r)); 
MSO_FH_R = 20*log10(abs(B_fh_r)) - 20*log10(abs(B_fh_l)); 
[r_data, c_data]=size(MSO_FH_L);
sel_index=1:16:r_data;
MSO_FH=MSO_FH_L(sel_index,:);
[r_d, c_d]=size(MSO_FH);
% target signal
TAR_FH=repmat(signal.fh.target,r_d,1);

% Data visulization
text_str = 'front high';
nn_plot(signal.fh.left, signal.fh.right,B_fh_l,B_fh_r,T_fh_l,F_fh_l,MSO_FH_L,MSO_FH_R,text_str);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% combine all data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MSO = [MSO_LL;MSO_LH;MSO_RL;MSO_RH;MSO_BL;MSO_BH;MSO_FL;MSO_FH];
TAR = [TAR_LL;TAR_LH;TAR_RL;TAR_RH;TAR_BL;TAR_BH;TAR_FL;TAR_FH];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% backpropagation network training
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data.input=MSO; % all 8 position data
data.target=TAR;
[r_data, c_data]=size(MSO);
% Learing by backpropagation
% nn_backpropagation(input,target,eta,numtrial,maxMSE,genfunc,nhiddenunit,wrange,alpha)
[net_out,Wkj,Wk0,Wji,Wj0] = nn_backpropagation(data,0.9,5000,1e-4,'bipolar_sig',c_data,1,0.1);
net_out'

% % network output processing
% tmp1=num2str(net_out);
% tmp2=[tmp1(1),tmp1(2),tmp1(2)];
% tmp3=bin2dec(tmp2);
% if tmp3==4, Left=1; Right=0; Middle=0;
% elseif tmp3==2, Left=0; Right=1; Middle=0;
% elseif tmp3==1, Left=0; Right=0; Middle=1;
% else disp('illegal output. train the network again');
% end