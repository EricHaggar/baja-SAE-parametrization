% =========================================================================
%   Function: GetWeldingStressSF
%
%   Parameters: maxMoment (N*mm), axialForce (N), innerDiameter (mm),
%   outerDiameter (mm), shockAbsorberForce_z (N), weldYieldStrength (MPa)
%   stressConcentrationFactor
%   
%   Outputs: n (welding stress safety factor)
%
%   Description: Calculates the welding stress safety factor 
% =========================================================================
function n = GetWeldingStressSF(maxMoment, axialForce, innerDiameter, outerDiameter, shockAbsorberForce_z, weldYieldStrength, stressConcentrationFactor)
    
    % Arm angle 
    theta1 = 52; % degrees 
    
    % Chord thickness
    chordThickness = 9.5; % mm
    
    % Constants
    Ka = 1;
    Kb = 1.2;
    
    % Ratio of branch to chord thickness
    t = ((outerDiameter-innerDiameter)/2)/chordThickness;
    
    % Cross sectional area
    crossSectionArea = (pi/4)*(outerDiameter*outerDiameter - innerDiameter*innerDiameter); % mm^2
    
    % Moment of inertia 
    momentOfInertia = (pi/4)*((0.5*outerDiameter)^4-(0.5*innerDiameter)^4); % mm^4

    % Modified axial force direction, please view welding analysis on
    % Suspension arm for further explanation 
    modifiedAxialForce = axialForce/sind(57);
        
    % Axial welding stress
    modifiedShockAbsorberForce_z = (shockAbsorberForce_z*0.5)/sind(theta1);
    sigma_a = (modifiedAxialForce-modifiedShockAbsorberForce_z)/crossSectionArea; % MPa 

    % Bending stress 
    sigma_b = stressConcentrationFactor*maxMoment*0.5*outerDiameter/momentOfInertia; % MPa
    
    % Shear at weld
    shearWeld = t*(((sigma_a*sind(theta1))/Ka)+(sigma_b/Kb));

    n = (0.58*weldYieldStrength)/shearWeld;
    
end