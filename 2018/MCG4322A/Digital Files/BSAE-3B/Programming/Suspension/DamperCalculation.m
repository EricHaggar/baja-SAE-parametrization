% =========================================================================
%   Function: DamperCalculation
%
%   Parameters: dampingCoefficientSuspension (Ns/m), forceOnDamper (N),
%   fullSolidDeflection (mm), innerDiameterSpring (mm), reboundLength (m)
%   
%   Outputs: pistonRodDiameter (mm), effectivePistonRodLength (mm),
%   wallThickness (mm), innerHousingDiameterOfDamper (mm)
%
%   Description: Calculates the different parameterized variables for the
%   damper of the shock absorber.
% =========================================================================
function [pistonRodDiameter, effectivePistonRodLength, wallThickness , innerHousingDiameterOfDamper, orificeDiameter] = DamperCalculation(dampingCoefficientSuspension, forceOnDamper, fullSolidDeflection, innerDiameterSpring, reboundLength)

% This is the range of motion of the shock absorber (damper and spring)
% used for the navier-stokes function
fullSolidDeflection = fullSolidDeflection/1000; % m

% Calling the piston rod calculation function
[pistonRodDiameter, effectivePistonRodLength] = PistonRodCalculation(forceOnDamper, reboundLength);

% Outer housing diameter of damper, allowing for a 10% clearance 
% between spring and damper, converted from mm to m
outerHousingDiameterOfDamper = (innerDiameterSpring/1000) * 0.9; % m
% Assumed wall thickness
wallThickness = 0.001; % m
% Diameter of the damper's inner housing, D_Housing
innerHousingDiameterOfDamper = outerHousingDiameterOfDamper - (2 * wallThickness); % m
% Annulus area of damper's housing
annulusAreaOfHousing = (pi / 4) * ((outerHousingDiameterOfDamper^2)-(innerHousingDiameterOfDamper^2)); % m^2

% Calling buckling safety factor function
[bucklingSafetyFactor] = BucklingOfHousing(forceOnDamper, annulusAreaOfHousing);
% Calling bursting pressure safety factor function
[burstingPressureSafetyFactor] = BurstingPressureOfHousing(forceOnDamper, annulusAreaOfHousing, innerHousingDiameterOfDamper, wallThickness);
% Dtermining lowest safety factor between buckling and bursting pressure
lowestSafetyFactor = min(bucklingSafetyFactor, burstingPressureSafetyFactor);
% While loop increases wallThickness by 0.001[mm] until lowestSafetyFactor 
% reaches 2
while (lowestSafetyFactor < 1.5)
    wallThickness = wallThickness + 0.001; % m
    [bucklingSafetyFactor] = BucklingOfHousing(forceOnDamper, annulusAreaOfHousing);
    [burstingPressureSafetyFactor] = BurstingPressureOfHousing(forceOnDamper, annulusAreaOfHousing, innerHousingDiameterOfDamper, wallThickness);
    lowestSafetyFactor = min(bucklingSafetyFactor, burstingPressureSafetyFactor); % unitless
end

% Calling Navier-Stokes function
[innerHousingDiameterOfDamper, orificeDiameter] = NavierStokes(outerHousingDiameterOfDamper, wallThickness, dampingCoefficientSuspension, fullSolidDeflection);

% Converting all outputs from [m] to [mm]
pistonRodDiameter = pistonRodDiameter * 1000; % mm
effectivePistonRodLength = effectivePistonRodLength * 1000; % mm
wallThickness = wallThickness * 1000; % mm
innerHousingDiameterOfDamper = innerHousingDiameterOfDamper * 1000; % mm
orificeDiameter = orificeDiameter * 1000; % mm

end

% =========================================================================
%   Function: PistonRodCalculation
%
%   Parameters: forceOnDamper (N), reboundLength (m)
%   
%   Outputs: pistonRodDiameter (m), effectivePistonRodLength (m)
%
%   Description: Calculates the different variables of the damper's piston
%   rod. Piston rod diameter of the shock absorber is determined based on 
%   buckling analysis, using Euler's Theory.
% =========================================================================
function [pistonRodDiameter, effectivePistonRodLength] = PistonRodCalculation(forceOnDamper, reboundLength)

% Effective length of the piston rod, to allow for 1/3 bottoming
effectivePistonRodLength = reboundLength * (1/3); % m
% Modulus of elasticity of stainless steel AISI type 304
modulusOfElasticity = 2e+11; % Pa
% Safety factor desired for the piston rod
safetyFactorDesiredForRod = 2; % unitless
% Critical buckling load
criticalBucklingLoad = forceOnDamper * safetyFactorDesiredForRod;
% Piston rod diameter calculated based on safety factor desired
pistonRodDiameter = (((64 * criticalBucklingLoad * (effectivePistonRodLength^2))/(modulusOfElasticity * (pi^3)))^(1/4)); % m

end

% =========================================================================
%   Function: BucklingOfHousing
%
%   Parameters: forceOnDamper (N), annulusAreaOfHousing (m^2)
%   
%   Outputs: bucklingSafetyFactor (unitless)
%
%   Description: Calculates the buckling safety factor of the damper's
%   housing.
% =========================================================================
function [bucklingSafetyFactor] = BucklingOfHousing(forceOnDamper, annulusAreaOfHousing)

% Buckling stress allowed
bucklingStress = forceOnDamper / annulusAreaOfHousing; % Pa
% Yield strength of Aluminum 2124-T851
yieldStrengthDamperHousing = 4.41e+08; % Pa
% Buckling safety factor for the housing of damper
bucklingSafetyFactor = yieldStrengthDamperHousing / bucklingStress; % unitless

end

% =========================================================================
%   Function: BurstingPressureOfHousing
%
%   Parameters: forceOnDamper (N), annulusAreaOfHousing (m^2),
%   innerHousingDiameterOfDamper (m), wallThickness (m)
%   
%   Outputs: burstingPressureSafetyFactor (unitless)
%
%   Description: Calculates the bursting pressure safety factor of the
%   damper's housing using the thin wall method.
% =========================================================================
function [burstingPressureSafetyFactor] = BurstingPressureOfHousing(forceOnDamper, annulusAreaOfHousing, innerHousingDiameterOfDamper, wallThickness)

% The thin wall method is implemented since the thickness of the wall is
% about one-tenth or less of its radius (from Shigley's textbook)

% Yield strength of Aluminum 2124-T851
yieldStrengthDamperHousing = 4.41e+08; % Pa
% Maximum pressure inside the damper
innerPressure = forceOnDamper / annulusAreaOfHousing; % Pa
% Radial stress is quite small compared with tangential stress, therefore
% Shigley's textbook neglects radial stress
radialStress = 0; % Pa
% Maximal tangential stress, higher than average tangential stress
maximalTangentialStress = (innerPressure*(innerHousingDiameterOfDamper + wallThickness))/(2*wallThickness); % Pa
% Longitudinal stress
longitudinalStress = (innerPressure * innerHousingDiameterOfDamper)/(4*wallThickness); % Pa
% Von Mises stress theory: stresses must be sorted in ascending order (1 
% being the highest, 3 being the lowest)
% Array of stresses
arrayOfStresses = [radialStress,maximalTangentialStress,longitudinalStress];
sigma1 = max(arrayOfStresses);
sigma2 = median(arrayOfStresses);
sigma3 = min(arrayOfStresses);
% Von Mises stress
vonMisesStress = sqrt((((sigma1-sigma2)^2)+((sigma2-sigma3)^2)+((sigma3-sigma1)^2))/2); % Pa
% Bursting pressure safety factor
burstingPressureSafetyFactor = yieldStrengthDamperHousing / vonMisesStress; % unitless
end

% =========================================================================
%   Function: NavierStokes
%
%   Parameters: outerHousingDiameterOfDamper (m), wallThickness (m),
%   wallThickness (m), dampingCoefficientSuspension (Ns/m),
%   fullSolidDeflection (m)
%   
%   Outputs: innerHousingDiameterOfDamper (m), orificeDiameter (m)
%
%   Description: Calculates the piston's orifice diameter of the damper
%   using Navier-Stokes. It also recalculates the inner housing diameter of
%   the damper using the final parameterized wall thickness.
% =========================================================================
function [innerHousingDiameterOfDamper, orificeDiameter] = NavierStokes(outerHousingDiameterOfDamper, wallThickness, dampingCoefficientSuspension, fullSolidDeflection)

% Inner housing diameter of damper
innerHousingDiameterOfDamper = outerHousingDiameterOfDamper - (2 * wallThickness); % m
% Diameter of the piston, with a 0.5[mm] all-around clearance from the
% damper's inner housing diameter
pistonDiameter = innerHousingDiameterOfDamper - 0.001; % m
% Number of orifices (holes) in the piston, determined in shock absorber
% manual to be 3 for applications such as Baja SAE
numberOfOrifices = 3;
% ISO 32 oil used for the damper
coefficientDynamicViscosity = 32; % N*s/m^2 (or Pa*s)
% Orifice diameter calculation, derived from Navier-Stokes
orificeDiameter = abs(((pistonDiameter^2)-(sqrt( (dampingCoefficientSuspension*(pistonDiameter^4)) / (8*pi*coefficientDynamicViscosity*fullSolidDeflection) ))) / numberOfOrifices); % m

end