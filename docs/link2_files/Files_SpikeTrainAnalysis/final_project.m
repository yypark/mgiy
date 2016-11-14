%function varargout = final_project(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%% final_project.m %%%%%%%%%%%%%%%%%%%%%%%
% Purpose : to implement ISI analysis for neural encoding 
%           and baysian estimation for neural decoding
%
% Last modified 05/12/04 by Yul Young Park
%
% Copyright 2004 by Yul Young Park, pyy@mail.utexas.edu
%     You may use, edit, run or distribute this file 
%     as long as the above copyright notice remains
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initial Parameter
s = load('c1p8.mat'); % data_set: white noise stimuli, res: response
stim = s.stim;  % white-noise visual motion stimulus
res = s.rho;    % a fly H1-neuron response: 20min duration, 500Hz sampling rate ( 20min*60s*500Hz=600000 data )
dt = 2;         % dt = 2msec by 500Hz sampling for both ISI and spike count distribution
T = 200;        % (msec)observation window for spike counting

figure(1);
tt = 1:length(res);
subplot(2,1,1)
plot(tt(1:500),stim(1:500));
title('white-noise stimulus signal to H1 neuron');xlabel('time(sec)');ylabel('stimulus');
set(gca,'XTickLabelMode','manual','XTickLabel',{'0';'0.1';'0.2';'0.3';'0.4';'0.5';'0.6';'0.7';'0.8';'0.9';'1'});
subplot(2,1,2);
stem(tt(1:500),res(1:500)); title('H1 neuron spike response'); xlabel('time(sec)');ylabel('spikes');
set(gca,'XTickLabelMode','manual','XTickLabel',{'0';'0.1';'0.2';'0.3';'0.4';'0.5';'0.6';'0.7';'0.8';'0.9';'1'});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ISI histogram of a fly H1 neuron response %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[x,pdf,mean_x,Cv_x,spk_num]=distribution(res,dt,T,0);   % tag = 0

figure(2);
subplot(2,1,1)
plot(x(1:100),pdf(1:100));
title('ISI histogram of a fly H1 neuron response');xlabel('time(msec)');ylabel('ISI-distribution prob.');
ylim([0 0.3]); xlim([0 150]);pause(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% spike count of a fly H1 neuron response   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[x_spk_cnt,pdf_spk_cnt,mean_x_spk_cnt,Fanor_x,spk_cnt_num]=distribution(res,dt,T,1); % tag = 1

subplot(2,1,2)
plot(x_spk_cnt,pdf_spk_cnt);
title('Normalized spike count distribution of a fly H1 neuron response');xlabel('spike number');ylabel('spike count prob.');
ylim([0 0.3]); xlim([0 40]);pause(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ISI histogram of a theoretical model       %
%  : poisson spike train, gamma spike train  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% poisson spike train
[t, spk]=poisson_spk_gen(mean_x,dt,60000);  % 60000ms duration
spk = spk';
[px,ppdf,mean_px,Cv_px,pspk_num]=distribution(spk,dt,T,0);   % tag = 0 for ISI
[px_spk_cnt,ppdf_spk_cnt,mean_px_spk_cnt,Fanor_px,pspk_cnt_num]=distribution(spk,dt,T,1); % tag = 1 for spike count
figure(3)
subplot(2,1,1)
plot(px,ppdf);
title('ISI histogram of poisson spike train');xlabel('time(msec)');ylabel('ISI-distribution prob.');
ylim([0 0.3]); xlim([0 150]);pause(1);
subplot(2,1,2)
plot(px_spk_cnt,ppdf_spk_cnt);
title('Normalized spike count distribution of poisson spike train');xlabel('spike number');ylabel('spike count prob.');
ylim([0 0.3]); xlim([0 40]);pause(1);

[tt, gspk]=gamma_spk_gen(mean_x,dt,60000,5);  % 60000ms duration, gamma of order 5
gspk = gspk';
[gx,gpdf,mean_gx,Cv_gx,gspk_num]=distribution(gspk,dt,T,0);   % tag = 0 for ISI
[gx_spk_cnt,gpdf_spk_cnt,mean_gx_spk_cnt,Fanor_gx,gspk_cnt_num]=distribution(gspk,dt,T,1); % tag = 1 for spike count
figure(4)
subplot(2,1,1)
plot(gx,gpdf);
title('ISI histogram of gamma spike train');xlabel('time(msec)');ylabel('ISI-distribution prob.');
ylim([0 0.3]); xlim([0 150]);pause(1);
subplot(2,1,2)
plot(gx_spk_cnt,gpdf_spk_cnt);
title('Normalized spike count distribution of gamma spike train');xlabel('spike number');ylabel('spike count prob.');
ylim([0 0.3]); xlim([0 40]);pause(1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('------------------------------------------------');
disp('from H1 neuron response :');
str09 = ['spk_num = ' num2str(spk_num)];
str10 = ['spk_cnt_num = ' num2str(spk_cnt_num)];
str01 = ['mean_x = ' num2str(mean_x)];
str02 = ['Cv_x = ' num2str(Cv_x)];
str05 = ['mean_x_spk_cnt = ' num2str(mean_x_spk_cnt)];
str06 = ['Fanor_x = ' num2str(Fanor_x)];
disp([str09 ' ,         ' str10]); 
disp([str01 ' ,         ' str02]); 
disp([str05 ' , ' str06]);

disp('------------------------------------------------');
disp('from poisson spike train generator :');
str11 = ['spk_num = ' num2str(pspk_num)];
str12 = ['spk_cnt_num = ' num2str(pspk_cnt_num)];
str03 = ['mean_x = ' num2str(mean_px)];
str04 = ['Cv_x = ' num2str(Cv_px)];
str07 = ['mean_x_spk_cnt = ' num2str(mean_px_spk_cnt)];
str08 = ['Fanor_x = ' num2str(Fanor_px)];
disp([str11 ' ,           ' str12]);
disp([str03 ' ,         ' str04]);
disp([str07 ' , ' str08]);
disp('------------------------------------------------');

disp('from gamma spike train generator (order=5):');
str11 = ['spk_num = ' num2str(gspk_num)];
str12 = ['spk_cnt_num = ' num2str(gspk_cnt_num)];
str03 = ['mean_x = ' num2str(mean_gx)];
str04 = ['Cv_x = ' num2str(Cv_gx)];
str07 = ['mean_x_spk_cnt = ' num2str(mean_gx_spk_cnt)];
str08 = ['Fanor_x = ' num2str(Fanor_gx)];
disp([str11 ' ,           ' str12]);
disp([str03 ' ,         ' str04]);
disp([str07 ' , ' str08]);
disp('------------------------------------------------');