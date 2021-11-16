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
output.plotForces(1,2)

%Plot RY response for body 1
pos=output.bodies(2).position(:,5);
vel=output.bodies(2).velocity(:,5);
t=output.bodies(2).time;
i = find(t==0);
i2 = find(t==150);
figure()
plot(t(i:i2),pos(i:i2))
xlabel('Time (s)')
ylabel('Position (m)')
title('Latching Position')

figure()
plot(t(i:i2),vel(i:i2))
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('Latching Velocity')


%% Calculate and Plot Power 

time =  output.ptos.time;
time2 = output.bodies(2).time;
ii = find(time==100);
ii2 = find(time==300);
jj = find(time2==100);
jj2 = find(time2==300);
time = time(ii:ii2);
time2 = time2(jj:jj2);
% force = -output.ptos.forceActuation(ii:end,3);
% vel = output.ptos.velocity(ii:end,3);
% power = force.*vel;
power = output.ptos.powerInternalMechanics(ii:ii2,5);
no_latch_power = 2.1749e+03;
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
xlim([25 inf])
xlabel('Time (s)')
ylabel('Power (W)')
title(['body' num2str(1) ' (' output.bodies(2).name ') Power', ' -- Latching Power'])
legend('power', 'average power','no latching power')

percent_greater = power_average/no_latch_power

