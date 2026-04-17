% Data for Symmetric Aircraft
close all;  clear all

% Mass and Dimensions 
m = 10000; W = m * 9.81; % Aircraft mass and weight
m_F = 0.15 * m; % Front Fuselage mass
m_W = 0.3 * m; % Wing mass
m_C = 0.4 * m; % Center Fuselage mass
m_T = 0.15 * m; % Rear Fuselage mass

S_W = 30.0; S_T = 7.5; % Wing and Tail Areas

s = 7.5; chord = 2.0; % Wing semi-span and chord
s_tp = 3.0; c_tp = 1.25; % Tail semi-span and chord

l_W = 0.3*chord; % Distance from WM to the WA
l_T = 3.5 * chord; % Distance from WM to the tail CM
l_A = 0.125 * chord; % Distance from WA to the WE
l_E = 0.125 * chord; % Distance from WM and WA
l_WM = l_W - l_A - l_E; % Distance from CM to the WM
l_M = 0.375 * chord; % Distance from CM to the main landing gear 
l_F = (m_T * l_T - m_W * l_WM) / m_F; % Distance from WM to the front fuselage
l_WT = l_W + l_T; % Distance between the WA and the tail CM
l_N = l_F;

mu = m_W / 2 / s; % Wing mass per unit span

% Moments of Inertia 
I_y_fuse = m_F * l_F^2 + m_T * l_T^2; 
I_y_W = m_W * (chord / 3)^2;  
I_y = I_y_fuse + I_y_W + m_W * l_WM^2;  
l_y_W = sqrt(I_y_W / m_W); 
l_y = sqrt(I_y / m);

% Landing gear 
C_N = 3200;  
C_M = 19200; 
K_N = 80000; 
K_M = 240000; 
l_B = l_N + l_M; 

% Basic aerodynamics 
a_W = 4.5; a_T = 3.2; a_E = 1.5; % Lift curve slopes 
alpha_0 = - 0.03;
C_M0 = - 0.03; 
C_D = 0.1; 
k_epsilon = 0.35; 

