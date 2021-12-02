%% Simulation Data
simu = simulationClass();               % Initialize Simulation Class
simu.simMechanicsFile = 'OSWEC.slx';    % Specify Simulink Model File
simu.mode = 'normal';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer = 'on';                   % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                     % Simulation Start Time [s]
simu.rampTime = 50;                    % Wave Ramp Time [s]
simu.endTime = 600;                     % Simulation End Time [s]        
simu.solver = 'ode4';                   % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.01;                          % Simulation Time-Step [s]
simu.CITime = 30;                       % Specify CI Time [s]

%% Wave Information
% % noWaveCIC, no waves with radiation CIC  
% waves = waveClass('noWaveCIC');       % Initialize Wave Class and Specify Type  

% % Regular Waves 
 waves = waveClass('regular');           % Initialize Wave Class and Specify Type                                 
 waves.H = 2;                          % Wave Height [m]
 waves.T = 8;                            % Wave Period [s]
%{
% Irregular Waves using PM Spectrum with Directionality 
waves = waveClass('irregular');         % Initialize Wave Class and Specify Type
waves.H = 2.5;                          % Significant Wave Height [m]
waves.T = 8;                            % Peak Period [s]
waves.spectrumType = 'PM';              % Specify Spectrum Type
waves.waveDir = [0,30,90];              % Wave Directionality [deg]
waves.waveSpread = [0.1,0.2,0.7];       % Wave Directional Spreading [%}
%}
% % Irregular Waves with imported spectrum
% waves = waveClass('spectrumImport');        % Create the Wave Variable and Specify Type
% waves.spectrumDataFile = 'spectrumData.mat';  %Name of User-Defined Spectrum File [:,2] = [f, Sf]

% % Waves with imported wave elevation time-history  
% waves = waveClass('etaImport');         % Create the Wave Variable and Specify Type
% waves.etaDataFile = 'etaData.mat'; % Name of User-Defined Time-Series File [:,2] = [time, eta]


%% Body Data
% Base
body(1) = bodyClass('hydroData/oswec.h5');      % Initialize bodyClass for Base
body(1).geometryFile = 'geometry/base.stl';     % Geometry File
body(1).mass = 'fixed';                         % Creates Fixed Body
% Flap
body(2) = bodyClass('hydroData/oswec.h5');      % Initialize bodyClass for Flap
body(2).geometryFile = 'geometry/flap.stl';     % Geometry File
body(2).mass = 'equilibrium';                          % User-Defined mass [kg]
body(2).momOfInertia = [5.3e5 2.27e5 3.14e5];  % Moment of Inertia [kg-m^2]

%% PTO and Constraint Parameters
% Fixed
constraint(1)= constraintClass('Constraint1');  % Initialize ConstraintClass for Constraint1
constraint(1).loc = [0 0 -6];                  % Constraint Location [m]

% Rotational PTO
pto(1) = ptoClass('PTO1');                      % Initialize ptoClass for PTO1
pto(1).k = 0;                                   % PTO Stiffness Coeff [Nm/rad]
pto(1).c = 12000;                               % PTO Damping Coeff [Nsm/rad]
pto(1).loc = [0 0 -5];                        % PTO Location [m]
