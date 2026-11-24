clear; clc; close all;
addpath('functions');
load(fullfile('C:\Soft_dev\SC42145-Floating-Wind-Turbine\matlab', 'data', 'Assignment_Data_SC42145_2026.mat')); % A, B, C, D, FWT, Wind_Data

G_siso  = -FWT(1, 1);   % -beta -> omega_r (phase starts at 360 deg)
Gd_siso =  FWT(1, 3);   % V     -> omega_r

% Q1.1: Poles, zeros, damping
p = pole(G_siso)
z = zero(G_siso)
damp(G_siso)

figure; bode(G_siso); grid on;
title('Q1.1: Open-Loop Bode of -G_{11}(s)');

figure; pzmap(G_siso); grid on;
title('Q1.1: Pole-Zero Map of -G_{11}(s)');