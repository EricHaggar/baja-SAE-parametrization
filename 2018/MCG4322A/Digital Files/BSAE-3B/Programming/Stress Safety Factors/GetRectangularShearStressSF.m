% =========================================================================
%   Function: GetRectangularShearStressSF
%
%   Parameters: shearForce (N), length (mm), width (mm), yieldStrength
%   (MPa)
%   
%   Outputs: n (shear stress safety factor)
% 
%   Description: Calculates the shear stress safety factor for a 
%   rectangular cross section
% =========================================================================
function n = GetRectangularShearStressSF(shearForce, length, width, yieldStrength) 
    
    % Shear yield strength
    s_sy = 0.58*yieldStrength; % MPa
    
    % Shear plane area
    shearArea = length*width;  % mm^2
    
    % Shear stress
    tau_max = (3/2)*shearForce/shearArea; % MPa
    
    % Safety Factor
    n = s_sy/tau_max;

end