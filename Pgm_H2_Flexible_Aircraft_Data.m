%% Fuselage Bending mode shape

kappa_e0_FB = 1; 
gamma_e0_FB = 0; 
A_FB = 0; 
B_FB = 0;

% Normalisation to 1 at wing tip trailing edge

kappa_tipTE_FB = kappa_e0_FB * (1 + A_FB) + gamma_e0_FB * (1 + B_FB) * (chord - chord/4 - l_A);

kappa_e0_FB = kappa_e0_FB / kappa_tipTE_FB;

% Solution of equations to yield dominant Fuselage Bending mode shape

X = [m_F  m_T;  -m_F * l_F  m_T * l_T]; 
Y = [- (m_W + m_C) * kappa_e0_FB; m_W * l_WM * kappa_e0_FB]; 
Z = X\Y;
kappa_eC_FB = 1; 
kappa_eF_FB = Z(1); 
kappa_eT_FB = Z(2); 

gamma_eT_FB = 2 * (kappa_eT_FB - kappa_eC_FB) / l_T - gamma_e0_FB;
kappa_tipLE_FB = kappa_e0_FB * (1 + A_FB) - gamma_e0_FB * (1 + B_FB) * (chord/4 + l_A);

% ‘J’ Integrals 
J1_FB = gamma_e0_FB * (1 + B_FB / 2);
J2_FB = kappa_e0_FB * (1 + A_FB / 3) - l_A * gamma_e0_FB * (1 + B_FB / 2);
J3_FB = gamma_e0_FB * kappa_e0_FB * (1 + A_FB / 3 + B_FB / 2 + A_FB * B_FB / 4) - l_A * gamma_e0_FB^2 * (1 + B_FB + B_FB^2 / 3);

% Modal Mass

m_e_FB = ...
    m_F * kappa_eF_FB^2 ...
  + m_W * (1 + 2*A_FB/3 + A_FB^2/5) * kappa_e0_FB^2 ...
  + (I_y_W + m_W*l_E^2) * (1 + B_FB + B_FB^2/3) * gamma_e0_FB^2 ...
  + 2*m_W*l_E * (1 + A_FB/3 + B_FB/2 + A_FB*B_FB/4) * kappa_e0_FB * gamma_e0_FB ...
  + m_C * kappa_eC_FB^2 ...
  + m_T * kappa_eT_FB^2;

%% WING BENDING MODE SHAPE

B_WB = 0;
A_WB = -3 * (m / m_W) / (1 + l_WM * (l_E + l_WM) / l_y^2);

% NORMALISATION TO 1 AT WING TIP TRAILING EDGE

kappa_tipTE_WB = 1;

% SOLUTION OF EQUATIONS TO YIELD DOMINANT WING BENDING MODE SHAPE

X_WB = [(1 + A_WB)  (1 + B_WB)*(chord - chord/4 - l_A);
        (m + m_W * A_WB / 3)    (m * (l_E + l_WM))];
Y_WB = [kappa_tipTE_WB;     0];
sol_WB = X_WB \ Y_WB;
kappa_e0_WB = sol_WB(1);
gamma_e0_WB = sol_WB(2);

gamma_eT_WB = gamma_e0_WB;
kappa_eF_WB = kappa_e0_WB - (l_F - l_WM - l_E)*gamma_e0_WB;
kappa_eC_WB = kappa_e0_WB + (l_WM + l_E)*gamma_e0_WB;
kappa_eT_WB = kappa_e0_WB + (l_T + l_WM + l_E)*gamma_e0_WB;
kappa_tipLE_WB = kappa_e0_WB * (1 + A_WB) - ...
                 gamma_e0_WB * (1 + B_WB) * (chord/4 + l_A);

% 'J' INTEGRALS

J1_WB = gamma_e0_WB * (1 + B_WB / 2);
J2_WB = kappa_e0_WB * (1 + A_WB / 3) - l_A * gamma_e0_WB * (1 + B_WB / 2);
J3_WB = gamma_e0_WB * kappa_e0_WB * (1 + A_WB / 3 + B_WB / 2 + A_WB * B_WB / 4) - l_A * gamma_e0_WB^2 * (1 + B_WB + B_WB^2 / 3);

% MODAL MASS

m_e_WB = ...
    m_F * kappa_eF_WB^2 ...
  + m_W * (1 + 2*A_WB/3 + A_WB^2/5) * kappa_e0_WB^2 ...
  + (I_y_W + m_W*l_E^2) * (1 + B_WB + B_WB^2/3) * gamma_e0_WB^2 ...
  + 2*m_W*l_E * (1 + A_WB/3 + B_WB/2 + A_WB*B_WB/4) * kappa_e0_WB * gamma_e0_WB ...
  + m_C * kappa_eC_WB^2 ...
  + m_T * kappa_eT_WB^2;


%% WING TORSION MODE SHAPE

A_WT = 0;
I_barW = I_y_W - m_W * l_E * l_WM;
B_WT = -2 * I_y / I_barW;

% NORMALISATION TO 1 AT WING TIP TRAILING EDGE

kappa_tipTE_WT = 1;

% SOLUTION OF EQUATIONS TO YIELD DOMINANT WING TWIST MODE SHAPE

X_WT = [(1 + A_WT)  (1 + B_WT)*(chord - chord/4 - l_A);
        (1)         (l_E + l_WM + (m_W / m) * (B_WT / 2) * l_E)];
Y_WT = [kappa_tipTE_WT;     0];
sol_WT = X_WT \ Y_WT;
kappa_e0_WT = sol_WT(1);
gamma_e0_WT = sol_WT(2);

gamma_eT_WT = gamma_e0_WT;
kappa_eF_WT = kappa_e0_WT - (l_F - l_WM - l_E)*gamma_e0_WT;
kappa_eC_WT = kappa_e0_WT + (l_WM + l_E)*gamma_e0_WT;
kappa_eT_WT = kappa_e0_WT + (l_T + l_WM + l_E)*gamma_e0_WT;
kappa_tipLE_WT = kappa_e0_WT * (1 + A_WT) - ...
                 gamma_e0_WT * (1 + B_WT) * (chord/4 + l_A);

% 'J' INTEGRALS

J1_WT = gamma_e0_WT * (1 + B_WT / 2);
J2_WT = kappa_e0_WT * (1 + A_WT / 3) - l_A * gamma_e0_WT * (1 + B_WT / 2);
J3_WT = gamma_e0_WT * kappa_e0_WT * (1 + A_WT / 3 + B_WT / 2 + A_WT * B_WT / 4) - l_A * gamma_e0_WT^2 * (1 + B_WT + B_WT^2 / 3);

% MODAL MASS

m_e_WT = ...
    m_F * kappa_eF_WT^2 ...
  + m_W * (1 + 2*A_WT/3 + A_WT^2/5) * kappa_e0_WT^2 ...
  + (I_y_W + m_W*l_E^2) * (1 + B_WT + B_WT^2/3) * gamma_e0_WT^2 ...
  + 2*m_W*l_E * (1 + A_WT/3 + B_WT/2 + A_WT*B_WT/4) * kappa_e0_WT * gamma_e0_WT ...
  + m_C * kappa_eC_WT^2 ...
  + m_T * kappa_eT_WT^2;

%% WEIGHTS (STUDENT REGISTRATION NUMBER 2163528)

a_0 = 74;
b_0 = 27;
c_0 = 61;


a = a_0 / (a_0 + b_0 + c_0); % Fuselage bending
b = b_0 / (a_0 + b_0 + c_0); % Wing bending
c = c_0 / (a_0 + b_0 + c_0); % Wing torsion

alpha = [a; b; c]; % VECTOR OF WEIGHTS

Phi_kappa_e0 = [kappa_e0_FB, kappa_e0_WB, kappa_e0_WT];
Phi_kappa_eC = [kappa_eC_FB, kappa_eC_WB, kappa_eC_WT];
Phi_kappa_eF = [kappa_eF_FB, kappa_eF_WB, kappa_eF_WT];
Phi_kappa_eT = [kappa_eT_FB, kappa_eT_WB, kappa_eT_WT];
Phi_kappa_tipTE  = [kappa_tipTE_FB, kappa_tipTE_WB, kappa_tipTE_WT];
Phi_kappa_tipLE  = [kappa_tipLE_FB, kappa_tipLE_WB, kappa_tipLE_WT];

Phi_gamma_e0 = [gamma_e0_FB, gamma_e0_WB, gamma_e0_WT];
Phi_gamma_eT = [gamma_eT_FB, gamma_eT_WB, gamma_eT_WT];

% COMBINED KAPPA AND GAMMA

kappa_e0   = Phi_kappa_e0 * alpha;
kappa_eC   = Phi_kappa_eC * alpha;
kappa_eF   = Phi_kappa_eF * alpha;
kappa_eT   = Phi_kappa_eT * alpha;

kappa_tipTE = Phi_kappa_tipTE * alpha;
kappa_tipLE = Phi_kappa_tipLE * alpha;

gamma_e0   = Phi_gamma_e0 * alpha;
gamma_eT   = Phi_gamma_eT * alpha;


% A AND B EVALUATED BY SOLVING THE ORTHOGONALITY CONDITIONS SYSTEM

M = [ m_W*kappa_e0/3,            m_W*l_E*gamma_e0/2;
     -m_W*kappa_e0*l_WM/3, (I_y_W - m_W*l_E*l_WM)*gamma_e0/2 ];

C = -[ m_F*kappa_eF + m_W*kappa_e0 + m_W*l_E*gamma_e0 + m_C*kappa_eC + m_T*kappa_eT;
      -m_F*kappa_eF*l_F - m_W*kappa_e0*l_WM + (I_y_W - m_W*l_E*l_WM)*gamma_e0 + m_T*kappa_eT*l_T ];

x = M\C; 

A = x(1);
B = x(2);

% COMBINED MODAL MASS

m_e = m_F*kappa_eF^2 + m_W*( 1 + 2*A/3 + A^2/5 )*kappa_e0^2 ...
  + ( I_y_W + m_W*l_E^2 )*( 1 + B + B^2/3 )*gamma_e0^2 ...
  + 2*m_W*l_E*( 1 + A/3 + B/2 + A*B/4 )*kappa_e0*gamma_e0 ...
  + m_C*kappa_eC^2 + m_T*kappa_eT^2;

% COMBINED 'J' INTEGRALS

J1 = (1 + B/2) * gamma_e0;
J2 = (1 + A/3) * kappa_e0 - l_A * (1 + B/2) * gamma_e0;
J3 = (1 + A/3 + B/2 + (A*B)/4) * kappa_e0 * gamma_e0 ...
    - l_A * (1 + B + B^2 / 3) * gamma_e0 ^2;

% NATURAL FREQUENCY

f_e = linspace(0, 10, 25);  
omega_e = 2 * pi * f_e;


fprintf('\n================ 3 COMBINED MODES ================\n');

fprintf('KAPPA VALUES\n');
fprintf('kappa_e0   = %+8.5f\n', kappa_e0);
fprintf('kappa_eF   = %+8.5f\n', kappa_eF);
fprintf('kappa_eC   = %+8.5f\n', kappa_eC);
fprintf('kappa_eT   = %+8.5f\n', kappa_eT);
fprintf('kappa_tipTE   = %+8.5f\n', kappa_tipTE);
fprintf('kappa_tipLE   = %+8.5f\n', kappa_tipLE);

fprintf('\nGAMMA VALUES\n');
fprintf('gamma_e0   = %+8.5f\n', gamma_e0);
fprintf('gamma_eT   = %+8.5f\n', gamma_eT);

fprintf('\nMODAL MASS\n');
fprintf('modal mass = %g\n', m_e);

fprintf('==================================================\n');