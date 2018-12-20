% =========================================================================
%   Function: GetFrontInternalForces
%
%   Parameters: normalForceX (N), normalForceY (N), normalForceZ (N)
%   
%   Outputs: axialForce (N), maxMoment (N*mm), shearForce (N),
%   shockAbsorberForce_z (N), shockAbsorberForce (N)
%
%   Description: Calculates the final inner force in the arm of the front
%   suspension tubes based on the input force at the wheel.
% =========================================================================
function [axialForce, maxMoment, shearForce, shockAbsorberForce_z, shockAbsorberForce] = GetFrontInternalForces(normalForceX,normalForceY,normalForceZ)

 outerDiameter = 31;
 innerDiameter = 20;

% Unsprung mass tire,spindle, control arm, brake disk
unsprungMass = 32.6; % kg

% Mass of member 

memberMass = 7; % kg 

% Linear acceleration
a = 231; % mm/s^2

% Gravity constant 
g = 9.81;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Geometry and dimensions of upper control arm               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Lower ball joint to ground 
LBG = 95; % mm

% Higher ball joint to ground 
HBG = 95; % mm

% Ball joint to center line of wheel 
BTC = 190; % mm

% Ball joint ot ball joint 
BTB = 260; % mm

% Tire diameter 
TD = 450; % mm

% Length of wishbone tube 
SAL = 393.24; % mm

% Moment of inertia of the cross section
momentOfInertia = (pi/4)*((0.5*outerDiameter)^4-(0.5*innerDiameter)^4); %mm^4


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Upper Control Arm Internal Forces                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ax = (-normalForceX*LBG+normalForceY*BTC-unsprungMass*a)/BTB; % N
Az = normalForceZ/2; % N


Cx = Ax/2; % N
Cy = (g*memberMass)*0.5; % N
Cz = Az/2; % N

% Axial force
axialForce1 = Ax;

% Maximum bending moment
maxMoment1 = (Az/2)*sin(60.2*pi/180)*SAL; % N*mm

% Max shear force

shearForce1 = (Az)*sin(60.2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 Lower control Arm Geometry and Dimensions               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Projected long arm length 
LA = 453.18; % mm

% Inner ancherman angle 
delta = 60.2; % degrees

alpha = 62.01;

% Projected length of shock 
LS = 362.54; % mm

% Angle between shock and ground
thetaS = 63.45;

LAL = 479.77;

% Lower control arm
Bx=normalForceX-Ax;
By=normalForceY-unsprungMass*a;
Bz=Az/2;

% Shock absorber force
shockAbsorberForce = abs(((momentOfInertia*0.51)-By*LA*sind(alpha)+(Bx)*LA*cosd(alpha))/(cosd(thetaS)*LS*cosd(alpha)-sind(thetaS)*LS*sind(alpha)));
shockAbsorberForce_x = shockAbsorberForce*cosd(thetaS);
shockAbsorberForce_y = shockAbsorberForce*sind(thetaS);
shockAbsorberForce_z = 1;

% Forces at pivot axis 
Dx = (shockAbsorberForce_x-Bx)*0.5;
Dy = (shockAbsorberForce_y-By)*0.5;
Dz = Bz*0.5;

% Axial force on arm
axialForce2 = sqrt(By*By+Bx*Bx);

% Max moment on arm 
maxMoment2 = (Bz)*sind(delta)*LAL;

% Shear force 
shearForce2 = Bz*sind(delta);

La = [axialForce1,axialForce2];
Lb = [maxMoment1,maxMoment2];
Ls = [shearForce1,shearForce2];

maxMoment = max(Lb);
axialForce = max(La);
shearForce = max(Ls);

end