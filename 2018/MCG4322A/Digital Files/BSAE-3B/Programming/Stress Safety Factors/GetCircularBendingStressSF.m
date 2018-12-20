% =========================================================================
%   Function: GetCircularBendingStressSF
%
%   Parameters: maxMoment (N*mm), diameter (mm), yieldStrength (MPa), 
%   stressConcentrationFactor
%   
%   Outputs: n (circular bending stress safety factor)
% 
%   Description: Calculates the bending stress safety factor for a
%   circular cross section
% =========================================================================
function n = GetCircularBendingStressSF(maxMoment, diameter, yieldStrength, stressConcentrationFactor)

    % Moment of inertia of the cross section
    momentOfInertia = (pi/4)*((diameter/2)^4); % mm^4
   
    % Bending Stress
    sigma_b = stressConcentrationFactor*maxMoment*0.5*diameter/momentOfInertia; % MPa
    
    % Safety Factor
    n = yieldStrength/sigma_b;
    
end