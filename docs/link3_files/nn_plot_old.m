function nn_plot(left, right,B_l,B_r,T,F,SO_L,SO_R,text_str)
% % CS342 Neural Network Class Project: Sound Source Localization
% % 
% % last modified 12/02/04 by Yul Young Park 
% 
% figure % time domain plot
% plot(1:length(right),left,'b',1:length(right),right,'r');
% legend('left ear','right ear');
% title([text_str,' source location, Left and Right Ear signal']);xlabel('samples');ylabel('freq.');
% 
% figure % freq.-time domain plot
% subplot(2,1,1)
% imagesc(T,F,20*log10(abs(B_l)));axis xy; colormap(jet);colorbar;
% title([text_str,' source location signal of Left Ear']);xlabel('time');ylabel('freq.');
% subplot(2,1,2);
% imagesc(T,F,20*log10(abs(B_r)));axis xy; colormap(jet);colorbar; % 'imagesc' function, not 'image' function 
% title([text_str,' source location signal of Right Ear']);xlabel('time');ylabel('freq.');
% 
% figure % manipulated data(left-right diff) plot
% subplot(2,1,1)
% imagesc(T,F,SO_L);axis xy; colormap(jet);colorbar
% title([text_str,' source, SO left: left - right']);xlabel('time');ylabel('freq.');
% subplot(2,1,2);
% imagesc(T,F,SO_R);axis xy; colormap(jet);colorbar % 'imagesc' function, not 'image' function 
% title([text_str,' source, SO right: right - left']);xlabel('time');ylabel('freq.');
