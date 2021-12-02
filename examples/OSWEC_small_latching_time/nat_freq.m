%Natural Frequency = sqrt(k/m)

k = body(2).hydroForce.linearHydroRestCoef(5,5);
m = body(2).momOfInertia(2)+body(2).hydroForce.fAddedMass(5,5); % inertia + added inertia

wn = sqrt(abs(k/m));
T = 2*pi/wn