% =========================================================================
%   Function: GetTubularBucklingSF
%
%   Parameters: axialForce (N), innerDiameter (mm), outerDiameter (mm),
%   length (mm), youngModulus (MPa) 
%   
%   Outputs: n (buckling safety factor)
% 
%   Description: Calculates the buckling safety factor of a circular
%   beam
% =========================================================================
function n = GetTubularBucklingSF(axialForce, innerDiameter, outerDiameter, length, youngModulus)

    % Area of the cross section
    crossSectionArea = (pi/4)*(outerDiameter*outerDiameter - innerDiameter*innerDiameter); % mm^2
    
    % Moment of inertia of the cross section
    momentOfInertia = (pi/4)*((0.5*outerDiameter)^4-(0.5*innerDiameter)^4); % mm^4
    
    % Critical buckling force
    criticalForce = pi*pi*youngModulus*momentOfInertia/(length*length); % N
    
    % Critical buckling stress
    criticalStress = criticalForce/crossSectionArea; % MPa
    
    % Actual stress
    actualStress = axialForce/crossSectionArea; % MPa
    
    % Tube buckling safety factor
    n = criticalStress/actualStress;    
    
end