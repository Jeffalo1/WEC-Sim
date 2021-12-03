%Example of user input MATLAB file for post processing

%Plot waves
waves.plotEta(simu.rampTime);
try 
    waves.plotSpectrum();
catch
end

% Plot RY forces for body 1
output.plotForces(2,5)

%Plot RY response for body 1
output.plotResponse(2,5);

% Plot x forces for body 2
output.plotForces(2,2)

% Save waves and response as video
% output.plotWaves(simu,body,waves,...
%     'timesPerFrame',5,'axisLimits',[-50 50 -50 50 -12 20],...
%     'startEndTime',[100 125]);

%Plot RY response for body 1
pos=output.bodies(2).position(:,5);
vel=output.bodies(2).velocity(:,5);
t=output.bodies(2).time;
i = find(t==200);
i2 = find(t==225);
figure()
plot(t(i:i2),pos(i:i2))
xlabel('Time (s)')
ylabel('Position (m)')
title('Position')

figure()
plot(t(i:i2),vel(i:i2))
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('Velocity')


%% Calculate and Plot Power 
low = 200; high = 300;

time =  output.ptos.time;
time2 = output.bodies(2).time;
ii = find(time==low);
ii2 = find(time==high);
jj = find(time2==low);
jj2 = find(time2==high);
time = time(ii:ii2);
time2 = time2(jj:jj2);
% force = -output.ptos.forceActuation(ii:end,3);
% vel = output.ptos.velocity(ii:end,3);
% power = force.*vel;
power = output.ptos.powerInternalMechanics(ii:ii2,5);
%no_latch_power = 508.2582;
%power_upper = (body.hydroForce.fExt.re(3)).^2/(8*body.hydroForce.fDamping(3,3));

power_average = mean(power)
%power_upper_average = mean(power_upper)

figure
plot(time,power)
hold on
yline(power_average,'-r')
hold on
%yline(no_latch_power,'-b')
%plot(time2,power_upper)
xlim([low high])
xlabel('Time (s)')
ylabel('Power (W)')
title(['Power Output'])
legend('power', 'average power')

%percent_greater = power_average/no_latch_power
