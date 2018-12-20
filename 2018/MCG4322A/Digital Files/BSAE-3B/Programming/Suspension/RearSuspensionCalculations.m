% =========================================================================
%   Function: RearSuspensionCalculations
%
%   Parameters: normalForceX (N), normalForceY (N), normalForceZ (N)
%   
%   Outputs: newInnerDiameter (mm), newNominalDiameter (mm),
%   bushingInnerDiameter (mm), shockAbsorberForce (N)
%
%   Description: Calculates the final inner Diameter of the rear
%   suspensino tubes based on the safety factors of the bending sress,
%   shear stress, buckling, and welding stress. Finally, the output variables
%   will be appended to the log and equation text files.
% =========================================================================
function [newInnerDiameterRear, newNominalDiameter, bushingInnerDiameter, shockAbsorberForce] = RearSuspensionCalculations(normalForceX, normalForceY, normalForceZ)

% Initializing diameters 
outerDiameter = 35; % mm
innerDiameter = outerDiameter-1; % mm

% AISI 4140 yield strength
yieldStrength=862; % MPa

% AISI young modulus
youngModulus=205000; % MPa

% Bending stress concentration factor
stressConcentrationFactor=1;
% Arm length 
length=424.54;

% Calling interal forces function 
[maxMoment,shearForce,axialForce,shockAbsorberForce_z, shockAbsorberForce] = GetRearInternalForces(normalForceX,normalForceY,normalForceZ);

% Weld elecrtode E90xxx yield strength 
weldyieldStrength=531; % MPa

% Major bolt diameter 
metricBoltsMajorDiameters=[6 7 8 10 12 14 16 18];

% Suspension arm safety factor array
suspensionArmSF=[0,0,0,0];

i = 0.1; % Increment

% Array index = 1 => bending safety factor 
% Array index = 2 => shear stress safety factor 
% Array index = 3 => buckling safety factor
% Array index = 4 => shear in welding safety factor 

suspensionArmSF(1) = GetTubularBendingStressSF(maxMoment, innerDiameter, outerDiameter,yieldStrength, stressConcentrationFactor);
suspensionArmSF(2) = GetTubularShearStressSF(shearForce, innerDiameter, outerDiameter, yieldStrength);
suspensionArmSF(3) = GetTubularBucklingSF(axialForce, innerDiameter, outerDiameter, length, youngModulus);
suspensionArmSF(4) = GetWeldingStressSF(maxMoment,axialForce,innerDiameter,outerDiameter,shockAbsorberForce_z,weldyieldStrength,stressConcentrationFactor);

% Tube thickness will keep increasing by deacreasing the inner diameter by a factor of i
while min(suspensionArmSF) < 2.00

    innerDiameter = innerDiameter-i;
    suspensionArmSF(1) = GetTubularBendingStressSF(maxMoment, innerDiameter, outerDiameter,yieldStrength, stressConcentrationFactor);
    suspensionArmSF(2) = GetTubularShearStressSF(shearForce, innerDiameter, outerDiameter, yieldStrength);
    suspensionArmSF(3) = GetTubularBucklingSF(axialForce, innerDiameter, outerDiameter, length, youngModulus);
    suspensionArmSF(4) = GetWeldingStressSF(maxMoment,axialForce,innerDiameter,outerDiameter,shockAbsorberForce_z,weldyieldStrength,stressConcentrationFactor);
end

% New inner diameter of semi-trialing arm tube found after previous iteration
newInnerDiameterRear = innerDiameter;

% Updated forces with new innner diameter
[maxMoment,shearForce,axialForce,shockAbsorberForce_z] = GetRearInternalForces(normalForceX,normalForceY,normalForceZ);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Bolt Diameter Parametrisation                         % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Incrementing through metric bolts major diameter array
j = 1;

% Nominal diameter
nominalDiameter = metricBoltsMajorDiameters(j);

% Safety factor for bolt
boltSuspensionSF = GetCircularShearStressSF(shearForce, nominalDiameter, 660);

% 2 shear planes 
SF = 2*boltSuspensionSF;

while boltSuspensionSF < SF
    j = j+1;
    nominalDiameter = metricBoltsMajorDiameters(j);
    boltSuspensionSF = GetCircularShearStressSF(shearForce, nominalDiameter, 660);
    newNominalDiameter = nominalDiameter;
    
end 

% Bushing diameter
bushingInnerDiameter = newNominalDiameter + 0.1;

end