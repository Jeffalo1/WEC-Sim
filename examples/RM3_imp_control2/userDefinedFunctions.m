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
%output.plotResponse(2,3);

%Plot heave forces for body 1
output.plotForces(1,3);

%Plot heave forces for body 2
%output.plotForces(2,3);

%Save waves and response as video
% output.plotWaves(simu,body,waves,...
%     'timesPerFrame',5,'axisLimits',[-150 150 -150 150 -50 20],...
%     'startEndTime',[100 125]);

%% Calculate and Plot Power 
time =  output.ptos.time;
time2 = output.bodies.time;
ii = find(time==125);
ii2 = find(time==225);
jj = find(time2==125);
jj2 = find(time2==225);
time = time(ii:ii2);
time2 = time2(jj:jj2);
% force = -output.ptos.forceActuation(ii:end,3);
% vel = output.ptos.velocity(ii:end,3);
% power = force.*vel;
power = output.ptos.powerInternalMechanics(ii:ii2,3);
power_upper = (output.bodies.forceExcitation(jj:jj2,3)).^2/(8*body.hydroForce.fDamping(3,3));

power_average = mean(power);
power_upper_average = mean(power_upper);

figure
plot(time,power)
hold on
yline(power_average,'-r')
hold on
yline(power_upper_average,'-g')
%plot(time2,power_upper)
xlim([25 inf])
xlabel('Time (s)')
ylabel('Power (W)')
title(['body' num2str(1) ' (' output.bodies(1).name ') Power'])
legend('power', 'average power','max average power')

percent_of_max = power_average/power_upper_average

powerin = output.ptos.inputPower(ii:ii2,3);

figure
plot(time,powerin)


%% Calculate Evaluation Criteria (EC)
pto_force = output.ptos.forceInternalMechanics(ii:end,3);
pto_displacement = output.ptos.position(ii:end,3);

f_98 = prctile(abs(pto_force),98);
f_max = 60;
z_98 = prctile(abs(pto_displacement),98);
z_max = 0.08;

power_abs_average = mean(abs(power));
P98 = prctile(abs(power),98);

maxPower = max(power);
EC = power_average/(2 + f_98/f_max + z_98/z_max - power_abs_average/P98);

