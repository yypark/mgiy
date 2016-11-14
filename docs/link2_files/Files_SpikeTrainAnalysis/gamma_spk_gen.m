function [T, Spike] = gamma_spk_gen(Vth,dt,spk_dur,order)
%%%%%%%%%%%%%%%%%% gamma_spk_gen.m %%%%%%%%%%%%%%%%%%%%
% Purpose : to generate poisson spike train
%       implemented by Integration-Fire model 
%       with exponentially random threshold
% Vth   - threshold membrane voltage
%       (= average ISI in exponential distribution
% dt    - data sampling period, [msec]
% spk_sur   - total response duration, [msec]
% order - order of the gamma distribution for resetting threshold
%
% Last modified 05/12/04 by Yul Young Park
%
% Copyright 2004 by Yul Young Park, pyy@mail.utexas.edu
%     You may use, edit, run or distribute this file 
%     as long as the above copyright notice remains
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ie_amp=5000; smc=80000;

% initial values for some important constants
Vreset  = 0;       % Instantaneous membrane voltage [mV]
cm = smc;           % specific membrane capacitance [nF/mm^2] (= Cm/A), default = 1
T = 0:(spk_dur/dt);       % Simulation time range, total 20 ms steps.
N = length(T);      % number of time steps

% initial values for specific conductances and resting potential
gL = 3;        % conductance for leakage [uS/mm^2]
EL = -54.387;       % resting potential for leakage [mV]

% initial values of rate functions
Vout = [];          % membrane potential over T-range[mV].
Vold = Vreset;
Vnew = Vold;        % membrane potential initial update
Vth_rand = - Vth* log(Vth*rand(1,1)); 
refrac_time = 0;    
Spike = zeros(1,N);

% time-independent parameters
Vinf = (gL*EL + Ie_amp)/gL;     % Ie_amp is independent of time
tv = cm/gL;                     % long tv -> long ISI generation

for i=1:N,                                                     
% membrane potential updating
    Vnew = Vinf + (Vold - Vinf)*exp(-dt/tv);

    if refrac_time > 0   % refractory period in the poisson spike generating neuron
        Vnew = Vreset;
        refrac_time = refrac_time - 1;
        Vth_rand = Vth_rand;
        Spike(i) = 0;
    elseif Vnew > Vth_rand
        Vnew = Vreset;
        refrac_time = 2/dt;                     % defalt refractory time = 2msec
        %refrac_time = 0; 
        Vth_rand = gamrnd(order,1/order);   % exponentially random threshold
        Spike(i) = 1;
    else
        %Vnew = Vinf + (Vold - Vinf)*exp(-dt/tv); %update
        refrac_time = 0;
        Vth_rand = Vth_rand;
        Spike(i) = 0;
    end   
    
% updating the gating variables for plotting
    Vout = [Vout Vnew];
    Vold = Vnew;
end % for
figure(12)
subplot(2,1,1);
plot(T(1:500),Vout(1:500)); title('membrane potential'); xlabel('time(sec)');ylabel('Voltage(mV)');
set(gca,'XTickLabelMode','manual','XTickLabel',{'0';'0.1';'0.2';'0.3';'0.4';'0.5';'0.6';'0.7';'0.8';'0.9';'1'});
subplot(2,1,2);
stem(T(1:500),Spike(1:500)); title('Gamma Spike Train with the order of 5'); xlabel('time(sec)');ylabel('spikes');
set(gca,'XTickLabelMode','manual','XTickLabel',{'0';'0.1';'0.2';'0.3';'0.4';'0.5';'0.6';'0.7';'0.8';'0.9';'1'});