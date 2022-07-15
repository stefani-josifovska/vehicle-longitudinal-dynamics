# vehicle-longitudinal-dynamics

A vehicle longitudinal dynamics model in Matlab/Simulink, using a .m initialization file.

The vehicle (parameters from VW Golf 2019) is represented in the form of a bicycle model. The calculations consist of a system of three differential equations:
1. an equation calculating the acceleration and velocity of the vehicle
2. an equation calculating the front wheel speed and
3. an equation calculating the rear wheel speed.

The longitudinal slip and, therefore, the longitudinal force (Fx) of the front and rear wheels, are calculated using the Burckhardt equation.

The file 'vehicle_parameters.m' contains the parameters of the vehicle and tires (including the Burckhardt model, which is later implemented as a 1D lookup table in the Simulink model).

The file 'input_torque.m' contains 5 different torque inputs, as well as the initial conditions and the simulation time needed for running the Simulink model.

The 'vehicle_parameters.m' and 'input_torque.m' files must be run prior to running the Simulink (vehicle_model.slx) file.
