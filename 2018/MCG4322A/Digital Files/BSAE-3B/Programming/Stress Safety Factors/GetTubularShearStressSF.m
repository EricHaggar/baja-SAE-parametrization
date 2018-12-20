% =========================================================================
%   Function: GetTubularShearStressSF
%
%   Parameters: shearForce(Nmm), innerDiameter (mm), outerDiameter (mm),
%   yieldStrength (MPa)
%   
%   Outputs: n (turbular shear stress safety factor)
%
%   Description: Calculates the shear stress safety factor for a circular 
%   cross section.
% =========================================================================
function n = GetTubularShearStressSF(shearForce, innerDiameter, outerDiameter, yieldStrength)
    
    % Shear yield strength
    s_sy = 0.58*yieldStrength; % MPa
    
    % Shear plane area
    shearArea = pi*(outerDiameter*outerDiameter-innerDiameter*innerDiameter)/4; % mm^2
    
    % Shear stress
    tau_max = (4/3)*shearForce/shearArea; % MPa
    
    % Safety Factor
    n = s_sy/tau_max;
    
end