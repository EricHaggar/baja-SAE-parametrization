% =========================================================================
%   Function: GetTubularBendingStressSF
%
%   Parameters: maxMoment(Nmm), innerDiameter (mm), outerDiameter (mm)
%   yieldStrength (MPa),  stressConcentrationFactor
%   
%   Outputs: n (tubular bending stress safety factor)
% 
%   Description: Calculates the bending stress safety factor for a
%   tubular cross section 
% =========================================================================
function n = GetTubularBendingStressSF(maxMoment, innerDiameter, outerDiameter, yieldStrength, stressConcentrationFactor)

    % Moment of inertia of the cross section
    momentOfInertia = (pi/4)*((0.5*outerDiameter)^4-(0.5*innerDiameter)^4); % mm^4
   
    % Bending Stress
    sigma_b = stressConcentrationFactor*maxMoment*0.5*outerDiameter/momentOfInertia; % MPa
    
    % Safety Factor
    n = yieldStrength/sigma_b;
    
end