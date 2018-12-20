% =========================================================================
%   Function: SpringCalculation
%
%   Parameters: springRate (N/m), maximumBumpForce (N)
%   
%   Outputs: meanCoilDiameter (mm), wireDiameter (mm), fullSolidDeflection
%   (mm), innerDiameterSpring (mm)
%
%   Description: Calculates the different parameterized variables for the
%   spring of the shock absorber.
% =========================================================================
function [meanCoilDiameter, wireDiameter, fullSolidDeflection, innerDiameterSpring] = SpringCalculation(springRate, maximumBumpForce)

% Assumed initial values
% Mean Coil Diameter, D
meanCoilDiameter = 40; % mm
% Wire Diameter, d
wireDiameter = 8; % mm

% Calling the function that calculates the safety factors and checks for
% ranges of design
[condSpringIndex, condActiveCoils, condStability, fatigueSF, yieldingSF, fullSolidDeflection, innerDiameterSpring] = SpringSafetyFactors(meanCoilDiameter, wireDiameter, springRate, maximumBumpForce);

% This variable is a flag which holds a false binary value (0 means false)
keepLooping = 0;
% MeanCoilDiameter evaluated from initial assumed value to maximum of 200mm
% to restrict spring within the upper control arm's minimum wishbone spread
for i = meanCoilDiameter:80
    % The flag will be toggled to true (1 meaning true) once both the
    % MeanCoilDiameter and WireDiameter variables meet the conditions of the if
    % statement
    if keepLooping == 1
        break
    end
    meanCoilDiameter = i;
    % WireDiameter evaluated from initial assumed value to maximum of 12mm,
    % restriction of manufacturing set for material (Shigley)
    for j = wireDiameter:12
        if(condSpringIndex == 0 || condActiveCoils == 0 || condStability == 0 || fatigueSF < 1.5 || yieldingSF < 1.2)
            tempWireDiameter = j;
            [condSpringIndex, condActiveCoils, condStability, fatigueSF, yieldingSF, fullSolidDeflection, innerDiameterSpring] = SpringSafetyFactors(meanCoilDiameter, tempWireDiameter, springRate, maximumBumpForce);
        else
            % Final values meeting conditions in if statement
            meanCoilDiameter = i;
            wireDiameter = j-1;
            % Flag toggled to true since both variables meet the conditions
            % in if statement
            keepLooping = 1;
            break
        end
    end
end


end

% =========================================================================
%   Function: SpringSafetyFactors
%
%   Parameters: meanCoilDiameter (mm), wireDiameter (mm), springRate
%   (N/mm), maximumBumpForce (N)
%   
%   Outputs: condSpringIndex (0 or 1/True or False), condActiveCoils (0 or
%   1/True or False), condStability (0 or 1/True or False), fatigueSF
%   (unitless), yieldingSF (unitless), fullSolidDeflection (mm),
%   innerDiameterSpring (mm)
%
%   Description: Calculates the safety factors and conditions based on the
%   spring's parameters.
% =========================================================================
function [condSpringIndex, condActiveCoils, condStability, fatigueSF, yieldingSF, fullSolidDeflection, innerDiameterSpring] = SpringSafetyFactors(meanCoilDiameter, wireDiameter, springRate, maximumBumpForce)

% Material: Chrome Silicon A401 - Peened

% Material properties
% Shear Modulus, G
shearModulus = 77200; % Mpa
% Material constants (used later for UTS)
A = 1974; % Mpa*mm^m
m = 0.108;
% Endurance strength for infinite life (used later for safety factor)
Ssa = 398; % Mpa

% Predetermined values

% Force when suspension in full rebound (i.e. full extension during a jump, 
% F_min)
minimumBumpForce = 0; % N
% Amplitude force, F_a
amplitudeForce = (maximumBumpForce-minimumBumpForce)/2;
% Spring rate, called from vibrationAnalysisForSuspension in N/m,converted
% into to N/mm
springRateNperMM = springRate/1000; % N/mm
% Damping ratio
zeta = 0.15;

% Calculated values

% Inner diameter of the spring, ID
innerDiameterSpring = meanCoilDiameter - wireDiameter;
% UTS - Shigley's formula and constants A and m for specified material
ultimateTensileStrength = A/wireDiameter^m; % Mpa
% Torsional modulus of rupture
%Ssu = 0.67*(UltimateTensileStrength); % N
% Torsional yield strength
Ssy = 0.45*(ultimateTensileStrength); % N
% Spring index, C
springIndex = meanCoilDiameter/wireDiameter;

% Solid Force, F_s
solidForce = (1+zeta)*maximumBumpForce; % N
% Number of active coils, N_a, rounded since it must be an integer
activeCoils = round(((wireDiameter^4)*shearModulus)/(8*(meanCoilDiameter^3)*springRateNperMM));

% Number of total coils, N_t
totalCoils = activeCoils + 2;
% Solid length, L_s
solidLength = wireDiameter * totalCoils;
% Free length, L_f
freeLength = solidLength + (solidForce/springRateNperMM);
% Full deflection
fullSolidDeflection = freeLength - solidLength;
% Correction factor for curvature and direct shear, K_b
correctionFactorK_b = ((4*springIndex)+2)/((4*springIndex-3));
% Shear stress amplitude, Tao_a
shearStressAmplitude = correctionFactorK_b*((8*amplitudeForce*meanCoilDiameter)/(pi*(wireDiameter^3)));
% INCLUDE SHEAR STRESS MEAN IF NEEDED, Tao_m
% Solid shear stress, Tao_s
solidShearStress = shearStressAmplitude * (solidForce/amplitudeForce);


% Spring index check
if(springIndex<4) || (springIndex>12)
    condSpringIndex = 0;
else
    condSpringIndex = 1;
end

% Active Coils range check
if(activeCoils<3) || (activeCoils>15)
    condActiveCoils = 0;
else
    condActiveCoils = 1;
end

% Stability check for Buckling
% Squared and ground ends supported between flat parallel surfaces, alpha
alpha = 0.5;
stabilityValue = 2.63*(meanCoilDiameter/alpha);
if(freeLength<stabilityValue)
    condStability = 1;
else
    condStability = 0;
end

% Fatigue safety factor
fatigueSF = Ssa/shearStressAmplitude;

% Yielding safety factor
yieldingSF = Ssy/solidShearStress;

end