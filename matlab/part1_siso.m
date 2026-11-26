clear; clc; close all;
addpath('functions');
load(fullfile('C:\Soft_dev\SC42145-Floating-Wind-Turbine\matlab', 'data', 'Assignment_Data_SC42145_2026.mat')); % A, B, C, D, FWT, Wind_Data

G_siso  = -FWT(1, 1);   % -beta -> omega_r (phase starts at 360 deg)
Gd_siso =  FWT(1, 3);   % V     -> omega_r

% Q1.1: Poles, zeros, damping
p = pole(G_siso);
z = zero(G_siso);
damp(G_siso)

% Break frequencies for visual markers
wp = unique(abs(p));
wz = unique(abs(z));

% Bode plot
w = logspace(-3, 2, 2000);
[mag, phase] = bode(G_siso, w);
mag = squeeze(mag);
phase = squeeze(phase);
if phase(1) < 180
    phase = phase + 360;   % start at 360 deg per assignment convention
end

figure('Color', 'w');
subplot(2, 1, 1);
semilogx(w, 20*log10(mag), 'b', 'LineWidth', 1.6); hold on;
hp = xline(wp, '--r');
hz = xline(wz, ':k');
grid on;
ylabel('Magnitude (dB)');
title('Open-Loop Bode of -G_{11}(s)');
legend([hp(1), hz(1)], {'Pole \omega_n', 'Zero \omega_n'}, 'Location', 'best');

subplot(2, 1, 2);
semilogx(w, phase, 'Color', [0.85 0.33 0.10], 'LineWidth', 1.6); hold on;
xline(wp, '--r');
xline(wz, ':k');
grid on;
yticks(-90:90:360);
ylim([-120 390]);
ylabel('Phase (deg)');
xlabel('Frequency (rad/s)');

% Pole-zero map
figure('Color', 'w');
plot(real(p), imag(p), 'xr', 'MarkerSize', 10, 'LineWidth', 1.8); hold on;
plot(real(z), imag(z), 'ob', 'MarkerSize', 9, 'LineWidth', 1.8);
xline(0, 'k-');
yline(0, 'k-');
grid on;
xlabel('Real Axis (s^{-1})');
ylabel('Imaginary Axis (s^{-1})');
title('Pole-Zero Map of -G_{11}(s)');
legend('Poles', 'Zeros', 'Location', 'best');
