function [x, pdf, mean, variability, spk_num]=distribution(res,dt,T,tag)
%%%%%%%%%%%%%%%%%%%%%%%%%%% final_project.m %%%%%%%%%%%%%%%%%%%%%%%
% Purpose : to calculate ISI distribution or spike count distribution 
% 
% spk   - spike data
% dt    - data sampling period
% T     - observation window size
% tag   - '0'->ISI distribution, '1'->spike count distribution 
%
% Last modified 05/11/04 by Yul Young Park
%
% Copyright 2004 by Yul Young Park, pyy@mail.utexas.edu
%     You may use, edit, run or distribute this file 
%     as long as the above copyright notice remains
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if tag == 0
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % ISI histogram of a fly H1 neuron response %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    spk_pos = find(res);
    spk_pos_shift = circshift(spk_pos,[1 0]);
    total_spk_num = length(spk_pos);
    isi_all = spk_pos - spk_pos_shift;      % first element should be ignored 
    
    min_isi = min(isi_all(2:end));
    max_isi = max(isi_all(2:end));
    isi = isi_all(2:end);
    y = zeros(1,max_isi+1);
    for i = 1:(max_isi+1)
        y(i) = length(find(isi==(i-1)));
    end
    % normalize
    pdf = y/total_spk_num;
    x = 0:dt:max_isi*dt;
    
    % mean, variance, std, coefficient of variation of ISI distribution
    u_x = sum(x.*pdf);
    var_x = sum(((x-u_x).^2).*pdf);
    std_x = sqrt(var_x);
    Cv_x = std_x/u_x;
    
    % result passing
    x=x; pdf=pdf; mean=u_x; variability=Cv_x; spk_num=total_spk_num;

else 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % spike count of a fly H1 neuron response   %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    res_len = length(res);          % total response length
    iter_num = floor(res_len/T);    % total number of spike counting
    res_temp = res(1:(iter_num*T));
    res_spk_inT = reshape(res_temp,T,iter_num);
    res_spk_cnt = sum(res_spk_inT);
    
    min_spk_cnt = min(res_spk_cnt);
    max_spk_cnt = max(res_spk_cnt);
    
    y_spk_cnt = zeros(1,max_spk_cnt+1);
    for i = 1:(max_spk_cnt+1)
        y_spk_cnt(i) = length(find(res_spk_cnt==(i-1)));
    end
    % normalize
    tot_spk_cnt_num = sum(y_spk_cnt);
    pdf_spk_cnt = y_spk_cnt/tot_spk_cnt_num;
    x_spk_cnt = 0:max_spk_cnt;
    
    % mean, variance, std, and Fanor factor of spike count distribution
    u_x_spk_cnt = sum(x_spk_cnt.*pdf_spk_cnt);
    var_x_spk_cnt = sum(((x_spk_cnt-u_x_spk_cnt).^2).*pdf_spk_cnt);
    Fanor_spk_cnt = var_x_spk_cnt/u_x_spk_cnt;
    
    % result passing
    x=x_spk_cnt; pdf=pdf_spk_cnt; mean=u_x_spk_cnt; variability=Fanor_spk_cnt;
    spk_num = tot_spk_cnt_num;
end