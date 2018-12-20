% =========================================================================
%   Function: GetRearInternalForces
%
%   Parameters: normalForceX (N), normalForceY (N), normalForceZ (N)
%   
%   Outputs: maxMoment (N*mm), shearForce (N),
%   axialForce (N), shockAbsorberForce_z (N), shockAbsorberForce (N)
%
%   Description: Calculates the final inner force in the arm of the rear
%   suspension tubes based on the input force at the wheel. 
% =========================================================================

function[maxMoment, shearForce, axialForce, shockAbsorberForce_z, shockAbsorberForce] = GetRearInternalForces(normalForceX,normalForceY,normalForceZ)

    unsprungMass = 25.2; % kg
    outerDiameter = 35;  % mm
    innerDiameter = 21;  % mm
    
    % Length of member 1
    armLength1 = 424.4;
    
    % Length of member 2
    armLength2 = 395.5;
    
    theta1 = 57;    % degrees
    theta2 = 50;    % degrees
    beta_yz = 76;   % degrees
    beta_xz = 67;   % degrees
    beta_xy = 60.3; % degrees
    angularAcceleration = 0.61;
    linearAcceleration = angularAcceleration*armLength1; % mm/s^2
    
    % Moment of inertia of the cross section
    momentOfInertia = (pi/4)*((0.5*outerDiameter)^4-(0.5*innerDiameter)^4); % mm^4
    
    % Rear suspension arm forces at wheel axis
    Ax = normalForceX;
    Ay = abs(normalForceY-unsprungMass*linearAcceleration);
    Az = normalForceZ;
    
    % Shock absorber forces  
    shockAbsorberForce = ((momentOfInertia*angularAcceleration)+(Ay*armLength1)-(Az*1))/((sind(beta_yz)*armLength2+cosd(beta_yz)*1));
    shockAbsorberForce_x = shockAbsorberForce*cosd(beta_xz)*cosd(beta_xy);
	shockAbsorberForce_y = shockAbsorberForce*sind(beta_yz);
    shockAbsorberForce_z = shockAbsorberForce*cosd(beta_yz)*cosd(beta_xz);
    
    % Rear suspension arm force at pivot axis
    Bx = Ax-shockAbsorberForce_x;
    By = shockAbsorberForce_y-Ay;
    Bz = Az-shockAbsorberForce_z;
    B = sqrt(Bx*Bx+By*By+Bz*Bz);
    
    % Max Bending moment
    maxMoment = (Ax/2)*armLength1*sind(theta1);
    % Max shear stress
    shearForce = Ax/2;
    % Axial force for buckling
    axialForce = Az/2;
    % Shear on bolt 
    boltShear = B/2;
end




