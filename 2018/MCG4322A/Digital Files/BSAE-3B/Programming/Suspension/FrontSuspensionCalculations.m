% =========================================================================
%   Function: FrontSuspensionalculations
%
%   Parameters: normalForceX (N), normalForceY (N), normalForceZ (N)
%   
%   Outputs: newInnerDiameter (mm), newNominalDiameter (mm),
%   bushingInnerDiameter (mm), bushingInnerDiameter (mm)
%
%   Description: Calculates the final inner Diameter of the front
%   suspension tubes based on the safety factors of the bending sress,
%   shear stress, buckling, and welding stress. Finally, the output variables
%   will be appended to the log and equation text files.
% =========================================================================
function [newInnerDiameterFront,newNominalDiameter, bushingInnerDiameter, shockAbsorberForce] = FrontSuspensionCalculations(normalForceX,normalForceY,normalForceZ)

% Initial dimensions
 outerDiameter = 31;
 innerDiameter = outerDiameter-1;
 length = 415.23; % mm

% Calling interal forces function 
[axialForce,maxMoment,shearForce,shockAbsorberForce_z, shockAbsorberForce] = GetFrontInternalForces(normalForceX,normalForceY,normalForceZ);

% AISI 4130 yield strength
yieldStrength = 862; % MPa
% AISI young modulus
youngModulus = 205000; % MPa

% Bending stress concentration factor
stressConcentrationFactor = 1;

% Weld elecrtode E90xxx yield strength 
weldyieldStrength = 531; % MPa

% Suspension arm safety factor array
suspensionArmSF = [0,0,0,0];

i = 0.1; % Increment

% Array index = 1 => bending safety factor 
% Array index = 2 => shear stress safety factor 
% Array index = 3 => buckling safety factor
% Array index = 4 => shear in welding safety factor 

suspensionArmSF(1) = GetTubularBendingStressSF(maxMoment, innerDiameter, outerDiameter, yieldStrength, stressConcentrationFactor);
suspensionArmSF(2) = GetTubularShearStressSF(shearForce, innerDiameter,outerDiameter, yieldStrength);
suspensionArmSF(3) = GetTubularBucklingSF(axialForce, innerDiameter, outerDiameter, length, youngModulus);
suspensionArmSF(4) = GetWeldingStressSF(maxMoment,axialForce,innerDiameter,outerDiameter,shockAbsorberForce_z,weldyieldStrength,stressConcentrationFactor);

% Tube thickness will keep increasing by deacreasing the inner diameter by a factor of i

while min(suspensionArmSF) < 2
    innerDiameter = innerDiameter-i;
    [axialForce,maxMoment,shearForce,shockAbsorberForce_z] = GetFrontInternalForces(normalForceX,normalForceY,normalForceZ);
    suspensionArmSF(1) = GetTubularBendingStressSF(maxMoment, innerDiameter, outerDiameter, yieldStrength, stressConcentrationFactor);
    suspensionArmSF(2) = GetTubularShearStressSF(shearForce, innerDiameter, outerDiameter, yieldStrength);
    suspensionArmSF(3) = GetTubularBucklingSF(axialForce, innerDiameter, outerDiameter, length, youngModulus);
    suspensionArmSF(4) = GetWeldingStressSF(maxMoment,axialForce,innerDiameter,outerDiameter,shockAbsorberForce_z,weldyieldStrength,stressConcentrationFactor);
end

% New inner diameter and safety factor for it 
newInnerDiameterFront = innerDiameter;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Bolt Diameter Parametrisation                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Major Bolt diameter 
metricBoltsMajorDiameters = [6 7 8 10 12 14 16 18];

% Bolt yield strenght 
yieldStrengthBolt = 660;

% Incrementing through metric bolts major diameter array
j = 1;

% Nominal diameter
nominalDiameter = metricBoltsMajorDiameters(j);

% Safety fcator for bolt
boltSuspensionActual = GetCircularShearStressSF(shearForce, nominalDiameter, yieldStrengthBolt);
SF = 2*boltSuspensionActual;

while boltSuspensionActual < SF
    j = j+1;
    nominalDiameter = metricBoltsMajorDiameters(j);
    boltSuspensionActual = GetCircularShearStressSF(shearForce, nominalDiameter, yieldStrengthBolt);
    newNominalDiameter = nominalDiameter; 
end

% Bushing diameter
bushingInnerDiameter = newNominalDiameter+0.1;
end 