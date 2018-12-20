% =========================================================================
%   Function: GetTransverseShearSF
%
%   Parameters: torque (N*mm), innerDiameter (mm), outerDiameter (mm), 
%   stressConcentrationFactor, yieldStress (MPa)
%   
%   Outputs: n (shear stress safety factor)
% 
%   Description: Calculates the transverse shear safety factor of a 
%   tubular beam
% =========================================================================
function n = GetTransverseShearSF(torque, innerDiameter, outerDiameter, stressConcentrationFactor, yieldStress)
    
    % Finding the transverse shear stress
    shearStress = 16*stressConcentrationFactor*torque*outerDiameter/(pi*(outerDiameter^4-innerDiameter^4)); % MPa
    
    % Shear yield stress
    shearyield = 0.58*yieldStress; % MPa
        
    % Tube buckling safety factor
    n = shearyield/shearStress;    
    
end