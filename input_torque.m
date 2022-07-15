% input in the system == the torque delivered to the wheels
% it is assumed that the vehicle has an ICE and the gearbox is
% positioned in the second gear, therefore giving a transmission ratio
% of around 12, whereas the max torque delivered by the engine is ~170Nm

% the inputs are modeled with the Sigmoid function, with slight
% mathematical modifications in order to fit the needs

max_torque = 2000; % [Nm] - max torque delivered to the wheels
target_torque = 34.6; % [Nm]

step = 0.01;
t_seg = 0:step:4;

chosen_input = 1; % which input should the simulation be run with (1-5)

% input 1: increasing the torque from 0 to 2000 and then descreasing it 
% to 34.6Nm, sufficient torque for keeping a constant velocity
sig_asc_input1 = max_torque.*(1./(1+exp(-5.*t_seg+10)));

const_input1 = zeros(1,401);
for i = 1:401
    const_input1(i) = max_torque;
end;

sig_desc_input1 = max_torque.*(-(1 - (target_torque / max_torque))./(1+exp(-6.*t_seg+10)) + 1);

const2_input1 = zeros(1,1001);

for i = 1:1001
    const2_input1(i) = target_torque;
end;

input1 = [sig_asc_input1 const_input1 sig_desc_input1 const2_input1];

t_sim = 0:step:22.03;

figure;
plot(t_sim,input1,'LineWidth', 1.5);


% input 2: increasing the torque from 0 to 2000, 
% keeping it constant, and then descreasing it back to 0
sig_desc_input2 = max_torque.*(-1./(1+exp(-6.*t_seg+10)) + 1);
const2_input2 = zeros(1,1501);
t_sim2 = 0:step:27.03;

input2 = [sig_asc_input1 const_input1 sig_desc_input2 const2_input2];

figure;
plot(t_sim2,input2,'LineWidth', 1.5);


% input 3: 0 -> 2000 -> const(2000) -> 34.6 -> const(34.6) -> 0
const1_input3 = zeros(1,401);
for i = 1:401
    const1_input3(i) = target_torque;
end;

const2_input3 = zeros(1,1101);

sig_desc2_input3 = target_torque.*(-1./(1+exp(-6.*t_seg+10)) + 1);

t_sim3 = 0:step:31.05;

input3 = [sig_asc_input1 const_input1 sig_desc_input1...
    const1_input3 sig_desc2_input3 const2_input3];

figure;
plot(t_sim3,input3,'LineWidth', 1.5);


% input 4: 8 seconds deceleration (inertia) from velocity 60km/h
% (16.67m/s), then increasing the torque to 1000 Nm
const1_input4 = zeros(1,800);
const2_input4 = zeros(1,200);
for i = 1:200
    const2_input4(i) = max_torque;
end;

t_sim4 = 0:step:14;
input4 = [const1_input4 sig_asc_input1 const2_input4];

figure;
plot(t_sim4,input4,'LineWidth', 1.5);


% input 5: 0 -> 2000 -> 34.6 -> 2000 -> 0
sig_desc2_input5 = max_torque.*(-1./(1+exp(-6.*t_seg+10)) + 1);
const_input5 = zeros(1,401);
for i = 1:401
    const_input5(i) = max_torque;
end;
const2_input5 = zeros(1,401);
for i = 1:401
    const2_input5(i) = target_torque;
end;
sig_asc2_input5 = ((max_torque-target_torque)./(1+exp(-5.*t_seg+10)))+target_torque;
const3_input5 = zeros(1,400);

input5 = [sig_asc_input1 const_input1 sig_desc_input1 const2_input5 ...
         sig_asc2_input5 const_input5 sig_desc2_input5 const3_input5];

t_sim5 = 0:step:32.06;

figure;
plot(t_sim5,input5,'LineWidth', 1.5);


switch chosen_input
    case 1
        chosen_input_T = input1;
        chosen_input_t = t_sim;
        v0_sim = 0; % [m/s] - initial vehicle velocity in the Simulink model
        time = 22; % time of simulation
    case 2
        chosen_input_T = input2;
        chosen_input_t = t_sim2; 
        v0_sim = 0; % [m/s] - initial vehicle velocity in the Simulink model
        time = 27; % time of simulation
    case 3
        chosen_input_T = input3;
        chosen_input_t = t_sim3;
        v0_sim = 0; % [m/s] - initial vehicle velocity in the Simulink model
        time = 31; % time of simulation
    case 4
        chosen_input_T = input4;
        chosen_input_t = t_sim4;
        v0_sim = 16.67; % [m/s] - initial vehicle velocity in the Simulink model
        time = 14; % time of simulation
    case 5
        chosen_input_T = input5;
        chosen_input_t = t_sim5;
        v0_sim = 16.67; % [m/s] - initial vehicle velocity in the Simulink model
        time = 32; % time of simulation
end
        
