function [] = simWind(FWT, K, type)
% SIMWIND Returns the time response plot of the given FWT in closed-loop
% with a synthesised cotroller K and a step or white noise disturbance on 
% the wind channel.
%
% Input arguments
% ---------------
% FWT   : provided FWT state-space.
% K     : closed-loop controller of choice (may be SISO or MIMO).
% type  : 'step' for simulating the step response or 'wn' for white noise.
%==========================================================================

if size(K,1) == 1 % adapt if SISO
    K = blkdiag(K,0);
end

G = FWT(:,1:2);

% Contstruct CL for simulation
G_sim    = G;
G_sim.u  = 'u';
G_sim.y  = 'y_plant';
 
K_sim    = K;
K_sim.u  = 'y_meas';
K_sim.y  = 'u';

Gd_sim   = FWT(:,3);
Gd_sim.u = 'V';
Gd_sim.y = 'y_dist';

Sum_sim = sumblk('y_meas = y_plant + y_dist', 2);
P_sim   = connect(G_sim,K_sim,Gd_sim,Sum_sim,{'V'},{'y_meas','u'});

P_sim.InputName  = {'V (m/s)'};
P_sim.OutputName = [G.OutputName; G.InputName];

switch type
    case 'step'
        step(P_sim)
        title('Disturbance rejection: Step response')
    case 'wn'
        dt      = 0.05;
        t_end   = 500;  % seconds

        t  = 0:dt:t_end;
        wn = 0.5*randn(numel(t), 1);
        lp = lsimplot(P_sim, wn, t);
        lp.InputVisible = 'off';
        title('Disturbance rejection: White noise response')
    otherwise
        error('Specify ''step'' or ''wn'' as input type.' )
end 

end