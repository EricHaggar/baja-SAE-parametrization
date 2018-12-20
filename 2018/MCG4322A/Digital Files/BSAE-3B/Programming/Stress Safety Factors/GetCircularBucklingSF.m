% =========================================================================
%   Function: GetCircularBucklingSF
%
%   Parameters: axialForce (N), diameter (mm), length (mm)
%   youngModulus (MPa) 
%   
%   Outputs: n (buckling safety factor)
% 
%   Description: Calculates the buckling safety factor of a cylindrical
%   beam
% =========================================================================
function n = GetCircularBucklingSF(axialForce, diameter, length, youngModulus)
    
    % Area of the cross section
    crossSectionArea = pi*(diameter*diameter)/4; % mm^2
    
    % Moment of inertia of the cross section
    momentOfInertia = (pi/4)*((diameter/2)^4); % mm^4
    
    % Critical buckling force
    criticalForce = pi*pi*youngModulus*momentOfInertia/(length*length); % N
    
    % Critical buckling stress
    criticalStress = criticalForce/crossSectionArea; % MPa
    
    % Actual stress
    actualStress = axialForce/crossSectionArea; % MPa
    
    % Tube buckling safety factor
    n = criticalStress/actualStress;    
    
end