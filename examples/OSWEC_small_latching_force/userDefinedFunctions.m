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

%Plot RY response for body 1
pos_nol=output_nol.bodies(2).position(:,5);
vel_nol=output_nol.bodies(2).velocity(:,5);
pos=output.bodies(2).position(:,5);
vel=output.bodies(2).velocity(:,5);
t=output.bodies(2).time;
i = find(t==200);
i2 = find(t==225);
figure()
plot(t(i:i2),pos(i:i2))
hold on
plot(t(i:i2),pos_nol(i:i2))
legend('With Latching','Without Latching')
xlabel('Time (s)')
ylabel('Rotation (rad)')
title('Position')

figure()
plot(t(i:i2),vel(i:i2))
hold on
plot(t(i:i2),vel_nol(i:i2))
legend('With Latching','Without Latching')
xlabel('Time (s)')
ylabel('Angular Velocity (rad/s)')
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
no_latch_power = 3.4808e+04;
%power_upper = (body.hydroForce.fExt.re(3)).^2/(8*body.hydroForce.fDamping(3,3));

power_average = mean(power)
%power_upper_average = mean(power_upper)

figure
plot(time,power)
hold on
yline(power_average,'-r')
hold on
yline(no_latch_power,'-b')
%plot(time2,power_upper)
xlim([low high])
xlabel('Time (s)')
ylabel('Power (W)')
title(['Power Output'])
legend('power', 'average power','average power without latching')

percent_greater = power_average/no_latch_power


