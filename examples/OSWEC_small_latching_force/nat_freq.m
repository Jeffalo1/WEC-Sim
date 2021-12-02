%Natural Frequency = sqrt(k/I)
wn = sqrt(abs(body(2).hydroForce.linearHydroRestCoef(5,5)/(body(2).momOfInertia(2)+body(2).hydroForce.fAddedMass(5,5))));
T = 2*pi/wn