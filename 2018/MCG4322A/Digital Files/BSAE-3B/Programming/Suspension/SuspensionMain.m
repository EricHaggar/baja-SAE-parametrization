% =========================================================================
%   Function: SuspensionMain
%
%   Parameters: dampingRatio (unitless), sprungFrontCornerMass (kg),
%   sprungFrontCornerMass (kg), totalVehicleMass (kg), normalForceX (N),
%   normalForceY (N), normalForceZ (N)
%   
%   Outputs: None
%
%   Description: Calls all other functions for the front and rear
%   suspension calculations
% =========================================================================
function SuspensionMain(dampingRatio, sprungFrontCornerMass, sprungRearCornerMass, totalVehicleMass, normalForceX, normalForceY, normalForceZ)
    
% Add necessary path to stress safety factor calculations
addpath('Z:\2018\MCG4322A\Digital Files\BSAE-3B\Programming\Stress Safety Factors');
    
% Add output log path 
logOutput = 'Z:\2018\MCG4322A\Digital Files\BSAE-3B\Log\BSAE-3B_LOG.txt';

% Add all equation files for SolidWorks
frontSuspensionFile = 'Z:\2018\MCG4322A\Digital Files\BSAE-3B\SolidWorks\Equations\DoubleWishbone.txt';
rearSuspensionFile = 'Z:\2018\MCG4322A\Digital Files\BSAE-3B\SolidWorks\Equations\SemiTrailingArm.txt';
frontShockAbsorberFile = 'Z:\2018\MCG4322A\Digital Files\BSAE-3B\SolidWorks\Equations\Shock_Global_variables_front.txt';
rearShockAbsorberFile = 'Z:\2018\MCG4322A\Digital Files\BSAE-3B\SolidWorks\Equations\Shock_Global_variables_rear.txt';

% Defining constants

frontMotionRatio = 0.8;                % unitless
rearMotionRatio = 1;                   % unitless
bumpFrontWorstCaseScenario = 1659;     % N
landingFrontWorstCaseScenario = 12359; % N
bumpRearWorstCaseScenario = 2161.6;    % N
landingRearWorstCaseScenario = 13196;  % N
frontReboundLength = 0.447;            % m
rearReboundLength = 0.447;             % m


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Front Suspension                           %                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[frontSuspensionSpringRate, frontSuspensionDampingCoefficient] = VibrationAnalysisForSuspension(dampingRatio, sprungFrontCornerMass, totalVehicleMass, frontMotionRatio);

[newFrontInnerDiameter,newFrontBoltDiameter,frontBushingInnerDiameter, shockAbsorberFrontForce] = FrontSuspensionCalculations(normalForceX,normalForceY,normalForceZ);

% The 2209 N is the worst case scenario bump force applied on the shock 
% absorber and the 15489 N is the worst case scenario landing impact force
% applied on the shock absorber. This determines the percentage of the
% input shock absorber force that the spring will support
frontSpringForce = shockAbsorberFrontForce*(bumpFrontWorstCaseScenario/landingFrontWorstCaseScenario);

[frontMeanCoilDiameter, frontWireDiameter, frontFullSolidDeflection, frontInnerSpringDiameter] = SpringCalculation(frontSuspensionSpringRate, frontSpringForce);

% The damper will support the rest of the input shock absorber force, after
% the spring taking a portion of it (aforementioned in this code
frontDamperForce = shockAbsorberFrontForce - frontSpringForce;

[frontPistonRodDiameter, frontEffectivePistonRodLength, frontWallThickness, frontInnerHousingDamperDiameter, frontOrificeDiameter] = DamperCalculation(frontSuspensionDampingCoefficient, frontDamperForce, frontFullSolidDeflection, frontInnerSpringDiameter, frontReboundLength);

frontInnerHousingDamperRadius = (frontInnerHousingDamperDiameter / 2);
frontPistonRodRadius = (frontPistonRodDiameter / 2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Rear Suspension                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[rearSuspensionSpringRate, rearSuspensionDampingCoefficient] = VibrationAnalysisForSuspension(dampingRatio, sprungRearCornerMass, totalVehicleMass, rearMotionRatio);

[newRearInnerDiameter,newRearBoltDiameter, rearBushingInnerDiameter, shockAbsorberRearForce] = RearSuspensionCalculations(normalForceX,normalForceY,normalForceZ);

% The 2209 N is the worst case scenario bump force applied on the shock 
% absorber and the 15489 N is the worst case scenario landing impact force
% applied on the shock absorber. This determines the percentage of the
% input shock absorber force that the spring will support
rearSpringForce = shockAbsorberRearForce*(bumpRearWorstCaseScenario/landingRearWorstCaseScenario);

[rearMeanCoilDiameter, rearWireDiameter, rearFullSolidDeflection, rearInnerSpringDiameter] = SpringCalculation(rearSuspensionSpringRate, rearSpringForce);

% The damper will support the rest of the input shock absorber force, after
% the spring taking a portion of it (aforementioned in this code
rearDamperForce = shockAbsorberRearForce - rearSpringForce;

[rearPistonRodDiameter, rearEffectivePistonRodLength, rearWallThickness, rearInnerHousingDamperDiameter, rearOrificeDiameter] = DamperCalculation(rearSuspensionDampingCoefficient, rearDamperForce, rearFullSolidDeflection, rearInnerSpringDiameter, rearReboundLength);

rearInnerHousingDamperRadius = (rearInnerHousingDamperDiameter / 2);
rearPistonRodRadius = (rearPistonRodDiameter / 2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         Suspension Log Output                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fileID = fopen(logOutput,'at');
fprintf(fileID,'******************************************************************************\n');
fprintf(fileID,'                       Optimized Front Suspension Design \n');
fprintf(fileID,'******************************************************************************\n\n');
fprintf(fileID,'------------- Upper and Lower Arms --------------\n\n');
fprintf(fileID,strcat('Tube inner diameter = ',32, num2str (newFrontInnerDiameter),' mm\n'));
fprintf(fileID,strcat('Mounting bolt diameter = ',32, num2str (newFrontBoltDiameter),' mm\n'));
fprintf(fileID,strcat('Mounting bushing inner diameter = ',32, num2str (frontBushingInnerDiameter),' mm\n\n'));
fprintf(fileID,'--------------- Shock Absorber ------------------\n\n');
fprintf(fileID,strcat('Spring mean coil diameter = ',32, num2str (frontMeanCoilDiameter),' mm\n'));
fprintf(fileID,strcat('Spring wire diameter = ',32, num2str (frontWireDiameter),' mm\n'));
fprintf(fileID,strcat('Piston rod diameter = ',32, num2str (frontPistonRodDiameter),' mm\n'));
fprintf(fileID,strcat('Wall thickness = ',32, num2str (frontWallThickness),' mm\n'));
fprintf(fileID,strcat('Housing damper inner diameter = ',32, num2str (frontInnerHousingDamperDiameter),' mm\n\n'));

fprintf(fileID,'******************************************************************************\n');
fprintf(fileID,'                       Optimized Rear Suspension Design \n');
fprintf(fileID,'******************************************************************************\n\n');
fprintf(fileID,'------------- Semi-Trailing Arms ----------------\n\n');
fprintf(fileID,strcat('Tube inner diameter = ',32, num2str (newRearInnerDiameter),' mm\n'));
fprintf(fileID,strcat('Mounting bolt diameter = ',32, num2str (newRearBoltDiameter),' mm\n'));
fprintf(fileID,strcat('Mounting bushing inner diameter = ',32, num2str (rearBushingInnerDiameter),' mm\n\n'));
fprintf(fileID,'--------------- Shock Absorber ------------------\n\n');
fprintf(fileID,strcat('Spring mean coil diameter = ',32, num2str (rearMeanCoilDiameter),' mm\n'));
fprintf(fileID,strcat('Spring wire diameter = ',32, num2str (rearWireDiameter),' mm\n'));
fprintf(fileID,strcat('Piston rod diameter = ',32, num2str (rearPistonRodDiameter),' mm\n'));
fprintf(fileID,strcat('Wall thickness = ',32, num2str (rearWallThickness),' mm\n'));
fprintf(fileID,strcat('Housing damper inner diameter = ',32, num2str (rearInnerHousingDamperDiameter),' mm\n'));
fclose(fileID);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Equation File Outputs                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Front Suspension Arms
fileID = fopen(frontSuspensionFile,'w+t');
fprintf(fileID,strcat('"Inner diameter tube" = ', 32, num2str(newFrontInnerDiameter), 'mm \n'));
fprintf(fileID,strcat('"BoltNominalDiameter" = ',32, num2str (newFrontBoltDiameter),'mm \n'));
fprintf(fileID,strcat('"BushingInnerDiameter" = ',32, num2str (frontBushingInnerDiameter),'mm \n'));
fclose(fileID);

% Front Shock Absorber 
fileID = fopen(frontShockAbsorberFile,'w+t');
fprintf(fileID,strcat('"Spring_inner_dia" =',num2str(frontMeanCoilDiameter),'\n'));
fprintf(fileID,strcat('"Spring_wire_dia" =',num2str(frontWireDiameter),'\n'));
fprintf(fileID,strcat('"Lower_Mount_piston_rod_radius"	=',num2str(frontPistonRodRadius),'\n'));
fprintf(fileID,strcat('"Lower_Mount_piston_rod_length" =',num2str(frontEffectivePistonRodLength),'\n'));
fprintf(fileID,strcat('"Upper_mount_wall_thickness" =',num2str(frontWallThickness),'\n'));
fprintf(fileID,strcat('"Upper_Mount_largest_radius" =',num2str(frontInnerHousingDamperRadius),'\n'));
fprintf(fileID,strcat('"Piston_orifice_dia"=',num2str(frontOrificeDiameter),'\n'));
fclose(fileID);
    

% Rear Suspension Arms
fileID = fopen(rearSuspensionFile,'w+t');
fprintf(fileID,strcat('"innerDiameter" = ', 32, num2str(newRearInnerDiameter), 'mm \n'));
fprintf(fileID,strcat('"chordThickness" = 9.5mm \n'));
fprintf(fileID,strcat('"chordLength" = 55mm \n'));
fprintf(fileID,strcat('"ArmLength" = 424mm \n'));
fprintf(fileID,strcat('"shockMountSpacing" = 30mm \n'));
fprintf(fileID,strcat('"shockMountHeight" = 55mm \n'));
fprintf(fileID,strcat('"ShockMountlength" = 35mm \n'));
fprintf(fileID,strcat('"shockMountAngle" = 40deg \n'));
fprintf(fileID,strcat('"BoltNominalDiameter" = ', 32, num2str(newRearBoltDiameter), 'mm \n'));
fprintf(fileID,strcat('"BushingInnerDiameter" = ', 32, num2str(rearBushingInnerDiameter), 'mm \n'));
fclose(fileID);


% Rear Shock Absorber    
fileID = fopen(rearShockAbsorberFile,'w+t');
fprintf(fileID,strcat('"Spring_inner_dia" =',num2str(rearMeanCoilDiameter),'mm\n'));
fprintf(fileID,strcat('"Spring_wire_dia" =',num2str(rearWireDiameter),'mm\n'));
fprintf(fileID,strcat('"Lower_Mount_piston_rod_radius"	=',num2str(rearPistonRodRadius),'mm\n'));
fprintf(fileID,strcat('"Lower_Mount_piston_rod_length" =',num2str(rearEffectivePistonRodLength),'mm\n'));
fprintf(fileID,strcat('"Upper_mount_wall_thickness" =',num2str(rearWallThickness),'mm\n'));
fprintf(fileID,strcat('"Upper_Mount_largest_radius" =',num2str(rearInnerHousingDamperRadius),'mm\n'));
fprintf(fileID,strcat('"Piston_orifice_dia"=',num2str(rearOrificeDiameter),'mm\n'));
fclose(fileID);

end