% =========================================================================
%   Function: VibrationAnalysisSuspension
%
%   Parameters: dampingRatio (unitless), sprungCornerMass (kg),
%   totalVehicleMass (kg), motionRatio (unitless)
%   
%   Outputs: springRateOfSuspension (N/m), dampingCoefficientOfSuspension
%   (Ns/m)
%
%   Description: Calculates the spring rate for the shock absorber's spring
%   as well as the damping coefficient for the shock absorber's damper;
%   using vibration analysis (based on Kaz Technologies).
% =========================================================================
function [springRateOfSuspension, dampingCoefficientOfSuspension] = VibrationAnalysisForSuspension(dampingRatio, sprungCornerMass, totalVehicleMass, motionRatio)

% Equations based on Kaz Technologies
                                                                                                  
% Ride frequency, f
rideFrequency = 2; % Hz
% Spring constamt for front suspension (one corner), K_s
springRateOfSuspension = (4*(pi^2)*(rideFrequency^2)*sprungCornerMass*((1/(motionRatio))^2)); % N/m
% Tire stiffness, K_t
tireStiffness = 270395; % N/m
% Wheel rate, K_w
wheelRate = springRateOfSuspension*(motionRatio^2); % N/m
% Critical damping coefficient
criticalDampingCoefficientOfSuspension = 2*(sqrt(((wheelRate*tireStiffness)/(wheelRate+tireStiffness))*totalVehicleMass)); % Ns/m
% Damping coefficent for front suspension (one corner), c_front
dampingCoefficientOfSuspension = dampingRatio*criticalDampingCoefficientOfSuspension; % Ns/m

end