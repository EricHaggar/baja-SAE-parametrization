% =========================================================================
%   Function: GetTubularAxialSF
%
%   Parameters: axialForce (N), innerDiameter (mm), outerDiameter (mm)
%   yieldStrength (MPa), stressConcentrationFactor
%   
%   Outputs: n (axial stress safety factor)
% 
%   Description: Calculates axial stress safety factor of a tubular beam
% =========================================================================

function n = GetTubularAxialSF(axialForce, innerDiameter, outerDiameter, yieldStrength, stressConcentrationFactor) 
    
    % Area of the cross section
    crossSectionArea = (pi/4)*(outerDiameter*outerDiameter - innerDiameter*innerDiameter); % mm^2
    
    % Actual axial stress
    actualStress = stressConcentrationFactor*axialForce/crossSectionArea;
    
    % Safety factor
    n = yieldStrength/actualStress;
    
end