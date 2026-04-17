% EXCLUDE LOW FREQUENCIES (f <= 1.5 Hz)

mask1 = f_e > 1.5;

% ===================== FIGURE 1 =====================
% Trim angles
close all
figure
plot(f_e(mask1), Trim_Incidence_Elastic(mask1), '-o', 'LineWidth', 1); hold on
plot(f_e(mask1), Trim_Elevator_Elastic(mask1),  '-s', 'LineWidth', 1);
plot(f_e(mask1), Trim_Incidence_Rigid * ones(sum(mask1),1), '-d', 'LineWidth', 1);
plot(f_e(mask1), Trim_Elevator_Rigid   * ones(sum(mask1),1), '-x', 'LineWidth', 1);
xlabel('Natural frequency [Hz]')
ylabel('Angle [deg]')
xlim([0 10])
ylim([-8 8])
title('Variation of trim incidence and elevator over natural frequency range')
legend('Trim incidence (Elastic)', 'Trim elevator (Elastic)', ...
       'Trim incidence (Rigid)', 'Trim elevator (Rigid)', 'Location', 'best')
grid on

% ===================== FIGURE 2 =====================
% Fuselage deflections
mask2 = f_e > 2;
figure
plot(f_e(mask2), 10*w_front_fuselage(mask2),  '-o', 'LineWidth', 1); hold on
plot(f_e(mask2), 10*w_center_fuselage(mask2), '-s', 'LineWidth', 1);
plot(f_e(mask2), 10*w_rear_fuselage(mask2),   '-^', 'LineWidth', 1);
xlabel('Natural frequency [Hz]')
ylabel('Fuselage deflection [dm]')

title('Variation of fuselage deflection over natural frequency range')
legend('Front fuselage', 'Center fuselage', 'Rear fuselage', 'Location', 'best')
grid on


% ===================== FIGURE 3 =====================
% Wing deflections

figure
plot(f_e(mask1), 10*w_tipTE_wing(mask1), '-o', 'LineWidth', 1); hold on
plot(f_e(mask1), 10*w_root_wing(mask1),  '-^', 'LineWidth', 1);
plot(f_e(mask1), 10*w_tipLE_wing(mask1), '-s', 'LineWidth', 1);
xlabel('Natural frequency [Hz]')
ylabel('Wing deflection [dm]')

title('Variation of wing deflection over natural frequency range')
legend('Tip TE', 'Root', 'Tip LE', 'Location', 'best')
grid on

% ===================== FIGURE 4 =====================
% Generalized elastic coordinate

figure
plot(f_e, q_e_trim, '-o', 'LineWidth', 1)
xlabel('Natural frequency [Hz]')
ylabel('Generalized coordinate q_e [m]')
xlim([0 max(f_e)])
ylim([-13 3])
title('Generalized elastic coordinate vs natural frequency')
grid on

% ===================== FIGURE 5 =====================
% Difference elastic vs rigid trim

figure
plot(f_e(mask1), Trim_Incidence_Elastic(mask1) - Trim_Incidence_Rigid, '-o', 'LineWidth', 1); hold on
plot(f_e(mask1), Trim_Elevator_Elastic(mask1)  - Trim_Elevator_Rigid,  '-s', 'LineWidth', 1);
xlabel('Natural frequency [Hz]')
ylabel('Difference [deg]')
xlim([0 max(f_e)])
ylim([-10 10])
title('Difference between elastic and rigid trim response')
legend('Incidence difference', 'Elevator difference', 'Location', 'best')
grid on

% ===================== FIGURE 6 =====================
% Trim vs modal stiffness

figure
plot(k_e/1e5, Trim_Incidence_Elastic, '-o', 'LineWidth', 1); hold on
plot(k_e/1e5, Trim_Elevator_Elastic, '-s', 'LineWidth', 1);
xlabel('Modal stiffness k_e [10^5 N/m]')
ylabel('Angle [degrees]')
ylim([-10 10])
title('Trim response vs modal stiffness')
legend('Trim incidence', 'Trim elevator', 'Location', 'best')
grid on