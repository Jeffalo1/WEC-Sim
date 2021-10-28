%Example of user input MATLAB file for post processing

%Plot waves
waves.plotEta(simu.rampTime);
try 
    waves.plotSpectrum();
catch
end

%Plot heave response for body 1
output.plotResponse(1,3);

%Plot heave response for body 2
output.plotResponse(2,3);

%Plot heave forces for body 1
output.plotForces(1,3);

%Plot heave forces for body 2
output.plotForces(2,3);

%Save waves and response as video
% output.plotWaves(simu,body,waves,...
%     'timesPerFrame',5,'axisLimits',[-150 150 -150 150 -50 20],...
%     'startEndTime',[100 125]);

%% Calculate and Plot Power 
time =  output.ptos.time;
ii = find(time==25);
time = time(ii:end);
% force = -output.ptos.forceActuation(ii:end,3);
% vel = output.ptos.velocity(ii:end,3);
% power = force.*vel;
power = output.ptos.powerInternalMechanics(ii:end,3);
eff = 0.7;
for i = 1:length(power)
    if power(i)>= 0
        power_eff(i) = power(i)*eff;
    else
        power_eff(i) = power(i)/eff;
    end
end
figure
plot(time,power,time,power_eff)
xlim([25 inf])
xlabel('Time (s)')
ylabel('Power (W)')
title(['body' num2str(1) ' (' output.bodies(1).name ') Power'])
legend('power','power w/eff')


%% Calculate Evaluation Criteria (EC)
pto_force = output.ptos.forceInternalMechanics(ii:end,3);
pto_displacement = output.ptos.position(ii:end,3);

f_98 = prctile(abs(pto_force),98);
f_max = 60;
z_98 = prctile(abs(pto_displacement),98);
z_max = 0.08;
power_average = mean(power_eff);
power_abs_average = mean(abs(power_eff));
P98 = prctile(abs(power_eff),98);

EC = power_average/(2 + f_98/f_max + z_98/z_max - power_abs_average/P98);

