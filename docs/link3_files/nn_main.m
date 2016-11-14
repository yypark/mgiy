% CS342 Neural Network Class Project: Sound Source Localization
% 
% Sampling Frequency: 44100 Hz
% Signal Type: toneburst
% last modified 12/02/04 by Yul Young Park 

clear all; close all;

% Data Load
train_d = trainingdata;   % load training data
test_d = testdata;        % load test data

% network training
[Wkj,Wk0,Wji,Wj0] = nn_training(train_d);

% network test
[expected_output, net_output] = nn_test(test_d,Wkj,Wk0,Wji,Wj0);

save('nn_result.mat','Wkj','Wk0','Wji','Wj0','train_d','test_d','expected_output', 'net_output')