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
Jp = 2*m_p*l_p^2;
K1 = L1/Jp;
L3 = -Kf*l_h;
Je = m_c*l_c^2 + 2*m_p*l_h^2;
K2 = L3/Je;
A = [0 1 0;0 0 0;0 0 0];
A2 = [0 1 0 0 0;0 0 0 0 0;0 0 0 0 0;-1 0 0 0 0;0 0 -1 0 0];
B2 = [0 0;0 K1;K2 0;0 0;0 0];
%G = [0 0;0 0;0 0;1 0;0 1];
B = [0 0;0 K1;K2 0];
Q = [1 0 0 0 0;0 1 0 0 0;0 0 1 0 0;0 0 0 1 0;0 0 0 0 1];
R = [1 0;0 1];
K = lqr(A2,B2,Q,R);
F = [K(1,1) K(1,3);K(2,1) K(2,3)];
%C = [1 0 0 0 0;0 0 1 0 0];
