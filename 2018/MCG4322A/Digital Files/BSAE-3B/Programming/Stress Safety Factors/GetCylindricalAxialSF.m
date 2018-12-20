% =========================================================================
%   Function: GetCylindricalAxialSF
%
%   Parameters: axialForce (N), diameter (mm), yieldStrength (MPa)
%   stressConcentrationFactor
%   
%   Outputs: n (axial stress safety factor)
% 
%   Description: Calculates the axial stress safety factor of a cylindrical
%   beam
% =========================================================================
function n = GetCylindricalAxialSF(axialForce, diameter, yieldStrength, stressConcentrationFactor) 
    
    % Area of the cross section
    crossSectionArea = pi*(diameter*diameter)/4; % mm^2
    
    % Actual axial stress
    actualStress = stressConcentrationFactor*axialForce/crossSectionArea;
    
    % Safety factor
    n = yieldStrength/actualStress;
    
end