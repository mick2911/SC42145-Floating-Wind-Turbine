clear all; clc; close all
load("C:\Users\Ole Lemmers\Documents\Studie\SC Y1\Q2\Robust Control\Robust Assignment\Assignment_Data_SC42145_2026.mat")   % A, B, C, D, FWT, Wind_Data now in workspace
whos                                         % list what got loaded
FWT                                          % look at the plant

sys = ss(A,B,C,D)

K = tf(0);                 % placeholder: no control at all
simWind(FWT, K, 'step')    % step in wind speed

figure; hold on;
bode(sys)
grid on
