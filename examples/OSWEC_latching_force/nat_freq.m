%Natural Frequency = sqrt(k/m)

wn = sqrt(abs(body(1,1).hydroForce.linearHydroRestCoef(5,5)/(body(1,1).mass+body(1,1).hydroForce.fAddedMass(5,5))));
T = 2*pi/wn