%Natural Frequency = sqrt(k/m)
k = body(2).hydroForce.linearHydroRestCoef(5,5);
m = body(2).momOfInertia(2)+body(2).hydroForce.fAddedMass(5,5); % inertia + added inertia

wn = sqrt(abs(k/m));
T = 2*pi/wn

% Calculate PTO parameters
Kp = body(2).hydroForce.fDamping(5,5)
Ki = (2*pi/waves.T)^2*(body(2).momOfInertia(2)+body(2).hydroForce.fAddedMass(5,5))-body(2).hydroForce.linearHydroRestCoef(5,5)

c = abs((2*pi/waves.T)*(body(2).momOfInertia(2)+body(2).hydroForce.fAddedMass(5,5))-body(2).hydroForce.linearHydroRestCoef(5,5)/(2*pi/waves.T))

readBodyMesh = stlread(body(2).geometryFile);
 bodyMesh(2).Points = readBodyMesh.Points;
 bodyMesh(2).Conns = readBodyMesh.ConnectivityList;
 bodyMesh(2).newPos = bodyMesh(2).Points(:,3)-3;
TR = triangulation(bodyMesh(2).Conns,[bodyMesh(2).Points(:,1:2),bodyMesh(2).newPos]);

stlwrite(TR,'tritext.stl','text')