
% Upload data and compute aerodynamic derivatives
Pgm_H1_Rigid_Aircraft_Data
Pgm_H2_Flexible_Aircraft_Data
Pgm_H3_Flight_Case_Data
Pgm_H4_Aero_Derivatives

% Load factor and steady pitch rate for equilibrium manoeuvre 
n = 1.9;	q_pr = 0;			

% Trim response of a rigid aircraft-requires aircraft data, flight case and
% derivative codes
% Setting-up and Solving Equations of Motion for the Rigid Aircraft
ARigid = -[Z_eta Z_alpha; M_eta M_alpha];
CRigid = [1 ; 0]; DRigid = [Z_q; M_q]; ERigid = [Z_0; M_0]; BRigid = inv(ARigid)...
    *(CRigid*(n*W) + DRigid*q_pr + ERigid); Bdeg = BRigid*180 / pi;
Trim_Elevator_Rigid = Bdeg(1)
Trim_Incidence_Rigid = Bdeg(2)


%% TRIM RESPONSE OF AN ELASTIC AIRCRAFT
% FOR EACH ELASTIC MODE FREQUENCY, THE MODAL STIFFNESS IS COMPUTED AND THE
% ELASTIC TRIM EQUATIONS ARE SOLVED; THE RESULTING GENERALIZED ELASTIC
% COORDINATE IS THEN USED TO EVALUATE STRUCTURAL DEFLECTIONS ALONG THE
% FUSELAGE AND THE WINGS.

CElastic = [1 ; 0 ; 0];  
DElastic = [Z_q ; M_q ; Q_q];  
EElastic = [Z_0 ; M_0 ; Q_0];   

for i = 1:length(f_e) 
    k_e(i) = omega_e(i)^2 * m_e; % MODAL STIFFNESS

    AElastic = - [ Z_eta   Z_alpha   Z_e;
                   M_eta   M_alpha   M_e;
                   Q_eta   Q_alpha   Q_e - k_e(i) ];

    % SOLVE TRIM EQUATIONS

    BElastic = inv(AElastic) * (CElastic * (n * W) + DElastic * q_pr + EElastic);

    Trim_Elevator_Elastic(i)  = BElastic(1) * 180/pi;
    Trim_Incidence_Elastic(i) = BElastic(2) * 180/pi;

    q_e_trim(i) = BElastic(3);

    % STRUCTURAL DEFLECTIONS

    w_front_fuselage(i) = q_e_trim(i) * kappa_eF;
    w_center_fuselage(i) = q_e_trim(i) * kappa_eC;
    w_rear_fuselage(i) = q_e_trim(i) * kappa_eT;
    w_tipTE_wing(i) = q_e_trim(i) * kappa_tipTE;
    w_root_wing(i) = q_e_trim(i) * kappa_e0;
    w_tipLE_wing(i) = q_e_trim(i) * kappa_tipLE;

end   


