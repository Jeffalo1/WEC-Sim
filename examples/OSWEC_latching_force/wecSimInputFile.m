%% Simulation Data
simu = simulationClass();               % Initialize Simulation Class
simu.simMechanicsFile = 'OSWEC_latching_time.slx';    % Specify Simulink Model File
simu.mode = 'normal';                   % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer = 'on';                   % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                     % Simulation Start Time [s]
simu.rampTime = 100;                    % Wave Ramp Time [s]
simu.endTime = 400;                     % Simulation End Time [s]        
simu.solver = 'ode4';                   % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.01;                         % Simulation Time-Step [s]
simu.CITime = 30;                       % Specify CI Time [s]

%% Wave Information
% % noWaveCIC, no waves with radiation CIC  
% waves = waveClass('noWaveCIC');       % Initialize Wave Class and Specify Type  

% % Regular Waves 
waves = waveClass('regular');           % Initialize Wave Class and Specify Type                                 
waves.H = 2.5;                          % Wave Height [m]
waves.T = 15;                           % Wave Period [s]

% Irregular Waves using PM Spectrum with Directionality 
%waves = waveClass('irregular');         % Initialize Wave Class and Specify Type
%waves.H = 2.5;                          % Significant Wave Height [m]
%waves.T = 8;                            % Peak Period [s]
%waves.spectrumType = 'PM';              % Specify Spectrum Type
%waves.waveDir = [0,30,90];              % Wave Directionality [deg]
%waves.waveSpread = [0.1,0.2,0.7];       % Wave Directional Spreading [%}

% % Irregular Waves with imported spectrum
% waves = waveClass('spectrumImport');        % Create the Wave Variable and Specify Type
% waves.spectrumDataFile = 'spectrumData.mat';  %Name of User-Defined Spectrum File [:,2] = [f, Sf]

% % Waves with imported wave elevation time-history  
% waves = waveClass('etaImport');         % Create the Wave Variable and Specify Type
% waves.etaDataFile = 'etaData.mat'; % Name of User-Defined Time-Series File [:,2] = [time, eta]


%% Body Data
% Flap
body(1) = bodyClass('hydroData/oswec.h5');      % Initialize bodyClass for Flap
body(1).geometryFile = 'geometry/flap.stl';     % Geometry File
body(1).mass = 127000;                          % User-Defined mass [kg]
body(1).momOfInertia = [1.85e6 1.85e6 1.85e6];  % Moment of Inertia [kg-m^2]

% Base
body(2) = bodyClass('hydroData/oswec.h5');      % Initialize bodyClass for Base
body(2).geometryFile = 'geometry/base.stl';     % Geometry File
body(2).mass = 'fixed';                         % Creates Fixed Body

%% PTO and Constraint Parameters
% Fixed
constraint(1)= constraintClass('Constraint1');  % Initialize ConstraintClass for Constraint1
constraint(1).loc = [0 0 -10];                  % Constraint Location [m]

% Rotational PTO
pto(1) = ptoClass('PTO1');                      % Initialize ptoClass for PTO1
pto(1).k = 0;                                   % PTO Stiffness Coeff [Nm/rad]
pto(1).c = 12000;                               % PTO Damping Coeff [Nsm/rad]
pto(1).loc = [0 0 -8.9];                        % PTO Location [m]


% End Stop specification
pto(1).hardStops.upperLimitSpecify = 'on'; % enable upper limit
pto(1).hardStops.lowerLimitSpecify = 'on'; % enable lower limit
pto(1).hardStops.upperLimitBound = 30; % upper limit at +0.8 m
pto(1).hardStops.lowerLimitBound = -30; % lower limit at -0.8 m 
pto(1).hardStops.upperLimitStiffness = 1e8; % upper limit at +0.8 m
pto(1).hardStops.lowerLimitStiffness = 1e8; % lower limit at -0.8 m 
pto(1).hardStops.upperLimitDamping = 0; % upper limit at +0.8 m
pto(1).hardStops.lowerLimitDamping = 0; % lower limit at -0.8 m 
pto(1).hardStops.upperLimitTransitionRegion = 0.5; % upper limit at +0.8 m
pto(1).hardStops.lowerLimitTransitionRegion = 0.5; % lower limit at -0.8 m 
