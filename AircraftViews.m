%% FRONT VIEW 
i_sel = 7;
q = q_e_trim(i_sel);

% --- spostamenti elastici ---
w_root   = -q * kappa_e0;
w_center = -q * kappa_eC;  
w_tip    = -q * (kappa_tipTE + kappa_tipLE) / 2;

s=s; % semi-span

x_FV = linspace(0, s, 200);
xi = x_FV / s;

w_curve = w_root + (w_tip - w_root) .* (xi.^2);

% Graphical amplification
scale = 10;

% Fuselage as a circumference
R = 0.05 * s;
theta = linspace(0, 2*pi, 200);
x_fus = R * cos(theta);
y_fus = R * sin(theta);

figure; hold on; grid on;

% Undeformed wings
plot(x_FV,  zeros(size(x_FV)), 'k--', 'LineWidth', 0.8)
plot(-x_FV, zeros(size(x_FV)), 'k--', 'LineWidth', 0.8)

% Deformed wings
plot( x_FV,  scale*w_curve, 'b', 'LineWidth', 1.2)
plot(-x_FV,  scale*w_curve, 'b', 'LineWidth', 1.2)

% Undeformed fuselage
plot(x_fus, y_fus, 'k--', 'LineWidth', 0.8)

% Deformed fuselage
plot(x_fus, y_fus + scale*w_center, 'b', 'LineWidth', 1.2)

% Points
scatter([0  s -s], scale*[w_root w_tip w_tip], 20, 'b', 'filled')
text([0+0.5  s  -s], scale*[w_root+0.03 w_tip+0.01 w_tip+0.01], {'Root','Tip','Tip'}, ...
    'VerticalAlignment','bottom', ...
    'HorizontalAlignment','center', ...
    'Color','b')
scatter(0, scale * w_center, 20, 'red', 'filled')
text(0-0.05, scale * (w_center+0.03), 'CM', ...
    'VerticalAlignment','bottom', ...
    'HorizontalAlignment','right', ...
    'Color','r')

xlabel('Spanwise coordinate y [m]')
ylabel(('Displacement along z [dm]'))
title(sprintf('Front View at f = %.2f Hz', f_e(i_sel)))

axis equal
xlim([-8 8])

%% SIDE VIEW

w_front = - q * kappa_eF;
w_rear = - q * kappa_eT;

x_fusSV = linspace(-l_F, l_T, 200);
w_fus = interp1([-l_F, 0, l_T], [w_front, w_center, w_rear], x_fusSV, 'pchip');

x_LE = - (l_W + 0.25 * chord);
x_TE = chord - abs(x_LE);

x_wingSV = linspace(x_LE, x_TE, 100);

w_tipLE = - q * kappa_tipLE;
w_tipTE = - q * kappa_tipTE;
w_wing = interp1([x_LE, x_TE],[w_tipLE, w_tipTE], x_wingSV, 'linear');



figure; hold on; grid on;
plot(x_fusSV, scale*w_fus, 'r', 'LineWidth', 1)
scatter([-l_F, 0, l_T], scale*[w_front, w_center, w_rear], 20, 'r', 'filled')
text([-l_F+0.01, 0+0.01, l_T+0.01], scale*[w_front-0.01, w_center-0.01, w_rear-0.01], {'F','CM','T'}, ...
    'VerticalAlignment','top', ...
    'HorizontalAlignment','center', ...
    'Color','r')

plot(x_wingSV, scale*w_wing, 'b', 'LineWidth', 1)
scatter([x_LE, x_TE], scale*[w_tipLE, w_tipTE], 20, 'b', 'filled')
text([x_LE+0.1, x_TE+0.1], scale*[w_tipLE+0.01, w_tipTE+0.01], {'LE', 'TE'}, ...
    'VerticalAlignment','bottom', ...
    'HorizontalAlignment','center', ...
    'Color','b')


plot(x_fusSV, scale*zeros(size(x_fusSV)), 'k--', 'LineWidth', 1)
xlabel('Fuselage coordinate x [m]')
ylabel(('Displacement along z [dm]'))
title(sprintf('Side View at f = %.2f Hz', f_e(i_sel)))
xlim([-9 9])
axis equal

