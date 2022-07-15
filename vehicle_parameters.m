% vehicle parameters:
m = 1700; % [kg] - vehicle mass [kg]
rd = 0.3; % [m] - wheel radius (effective)
Cx = 0.31; % [-] - drag coefficient
A = 2.71; % [m^2] - vehicle frontal area
ro = 1.2; % [kg/m^3] - air density
hc = 0.5; % [m] - height of the center of mass
It = 8; % moment of inertia of the wheel

l = 2.73; % [m] - wheelbase
lp = 1.2; % [m] - distance from the center of mass to the front axle
lz = l - lp; % [m] - distance from the center of mass to the rear axle

f0 = 0.015; % [-] - rolling resistance coefficient
g = 9.81; % [m/s^2] - acceleration due to gravity

Z_zst = m*g*lp/l; % [N] - normal reactive force acting on the front axle (static)
Z_pst = m*g-Z_zst; % [N] - normal reactive force acting on the rear axle (static)


% tire parameters
fi = 0.8;
bh_coef = [1.11 23.99 0.52]; % Burckhardt coefficients - dry asphalt

step = 0.01;
s_final = 1;
s = -s_final:step:s_final;

mi = zeros(1,length(s));

for i=1:201
    mi(i) = fi*sign(s(i)).*((bh_coef(1)*(1-exp(-bh_coef(2).*abs(s(i)))))-bh_coef(3).*abs(s(i)));
end

figure;
plot(s,mi,'LineWidth', 1.5);














