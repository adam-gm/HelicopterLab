% FOR HELICOPTER NR 3-10
% This file contains the initialization for the helicopter assignment in
% the course TTK4115. Run this file before you execute QuaRC_ -> Build 
% to build the file heli_q8.mdl.

% Oppdatert høsten 2006 av Jostein Bakkeheim
% Oppdatert høsten 2008 av Arnfinn Aas Eielsen
% Oppdatert høsten 2009 av Jonathan Ronen
% Updated fall 2010, Dominik Breu
% Updated fall 2013, Mark Haring
% Updated spring 2015, Mark Haring
PORT = 5;
%%%%%%%%%%% Calibration of the encoder and the hardware for the specific
%%%%%%%%%%% helicopter
Joystick_gain_x = 1;
Joystick_gain_y = -1;

%%%%%%%%%%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.46; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.72; % Motor mass [kg]
Vs0 = 8;
Kf = (g*(m_c*l_c-2*m_p*l_h))/(Vs0*l_h);
L1 = -Kf*l_p;
L2 = g*(m_c*l_c-2*m_p*l_h);
Jp = 2*m_p*l_p^2;
K1 = L1/Jp;
L3 = -Kf*l_h;
Je = m_c*l_c^2 + 2*m_p*l_h^2;
K2 = L3/Je;
A2 = [0 1 0 0 0 ;0 0 0 0 0;0 0 0 0 0;-1 0 0 0 0;0 0 -1 0 0];
B2 = [0 0;0 K1;K2 0;0 0;0 0];
%G = [0 0;0 0;0 0;1 0;0 1];
B = [0 0;0 K1;K2 0];
Q = [5 0 0 0 0;0 5 0 0 0;0 0 5 0 0;0 0 0 5 0;0 0 0 0 5];
R = [1 0;0 1];
K = lqr(A2,B2,Q,R);
F = [K(1,1) K(1,3);K(2,1) K(2,3)];
C = [1 0 0 0 0;0 0 1 0 0];
Jl = m_c*l_c^2+2*m_p*(l_h^2+l_p^2);
K3 = -L2/Jl;
Ahatt = [0 1 0 0 0;0 0 0 0 0;0 0 0 1 0;0 0 0 0 0;K3 0 0 0 0];
Bhatt = [0 0;0 K1;0 0;K2 0;0 0];
Chatt1 = [0 0 1 0 0;0 0 0 0 1];
Chatt2 = [1 0 0 0 0;0 1 0 0 0;0 0 1 0 0;0 0 0 1 0;0 0 0 0 1];
p = [-10;-10;-10;-10;-10];
Cd = [1 0 0 0 0 0;0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 0 1];
Chatt = Cd;
%L = place(Ahatt',Chatt',p).';
FlyData = importdata("flyingtimeseries.mat");
Rd = cov(FlyData(2:6,1:6)');
I = eye(6,6);
Qd = [5 0 0 0 0 0;0 5 0 0 0 0;0 0 5 0 0 0;0 0 0 5 0 0;0 0 0 0 5 0;0 0 0 0 0 5];
T = 0.002;
Ad = [1 T 0 0 0 0;0 1 0 0 0 0;0 0 1 T 0 0;0 0 0 1 0 0;1/2*K3*T*T 1/6*K3*T*T*T 0 0 1 T;K3*T 1/2*K3*T*T 0 0 0 1];
Bd = [0 1/2*K1*T*T;0 K1*T;1/2*K2*T*T 0;K2*T 0;0 1/24*K1*K3*T*T*T*T;0 1/6*K1*K3*T*T*T];
xhatt0 = [0;0;0;0;0;0];
