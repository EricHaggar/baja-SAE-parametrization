% =========================================================================
%   Function: DesignCode
%
%   Parameters: driverMass (kg), suspensionFeelType, steeringTurnsToLock
%   (turns), jumpHeight (m), terrainType
%   
%   Outputs: None
%
%   DesignCode is the main "design" function which calls all other 
%   scripts used for calculaions 
% =========================================================================
function DesignCode(driverMass, suspensionFeelType, rackPinionRatio, jumpHeight, terrainType)

    % Adding all necessary paths
    addpath('Z:\2018\MCG4322A\Digital Files\BSAE-3B\Programming\Frame');
    addpath('Z:\2018\MCG4322A\Digital Files\BSAE-3B\Programming\Suspension');
    addpath('Z:\2018\MCG4322A\Digital Files\BSAE-3B\Programming\Steering');

    % Output log file location
    logFile = 'Z:\2018\MCG4322A\Digital Files\BSAE-3B\Log\BSAE-3B_LOG.txt'; % log file
    
    fileID = fopen(logFile,'wt+'); % Open logFile for reading and writing. If the file exists, its contents are erased
    % Writing values to file
    fprintf(fileID,'******************************************************************************\n');
    fprintf(fileID,'                                 Input Parameters \n');
    fprintf(fileID,'******************************************************************************\n\n');
    fprintf(fileID,strcat('Mass of the driver =',32,num2str(driverMass),' kg\n'));
    fprintf(fileID,strcat('Suspension feel type (damping ratio) =',32,num2str(suspensionFeelType),'\n'));
    fprintf(fileID,strcat('Rack and pinion ratio =',32,num2str(rackPinionRatio),'\n'));
    fprintf(fileID,strcat('Jump height =',32,num2str(jumpHeight),' m\n'));
    fprintf(fileID,strcat('Terrain type (friction coefficient) =',32,num2str(terrainType),'\n\n'));
    fclose(fileID); % Close file
    
    % Calculate max height based on user inputted jumpHeight
    maxVehicleHeight = GetVehicleMaxHeight(jumpHeight);
    
    % Calls FrameMain which calculates FEA Safety Factors and returns the
    % frame mass based on tube thicknesses 
    frameMass = FrameMain(driverMass, maxVehicleHeight);
    
    % Calls MassCalculation and returns masses needed for suspension and
    % steering
    [totalMass, sprungFrontCornerMass, sprungRearCornerMass] = MassCalculation(frameMass, driverMass);
    
    % Calculates landing impact forces (normal force) in 3D based on total
    % mass and maximum vehicle height
    [normalForceX, normalForceY, normalForceZ] = LandingImpactForce(totalMass,maxVehicleHeight);
    
    % Calls SuspensionMain which calls scripts for shock absorber and
    % suspension arms analysis
    SuspensionMain(suspensionFeelType, sprungFrontCornerMass, sprungRearCornerMass, totalMass, normalForceX, normalForceY, normalForceZ);
    
    % Calls SteeringMain
    SteeringMain(normalForceZ, driverMass, totalMass, terrainType, rackPinionRatio);
   
end

% =========================================================================
%   Function: MassCalculation
%
%   Parameters: frameMass (kg), driverMass (kg)
%   
%   Outputs: totalMass (kg), sprungTotalMass (kg), sprungFrontCornerMass
%   (kg), sprungRearCornerMass (kg)
%
%   Calculates required masses for the design calculations
% =========================================================================
function [totalMass, sprungFrontCornerMass, sprungRearCornerMass] = MassCalculation(frameMass, driverMass)

% Defining constants
subComponentsMass = 155; % kg
unsprungFrontCornerMass = 32.6; % kg
unsprungRearCornerMass = 25.2; % kg
COGToFront = 917; % mm
COGToRear = 644; % mm

% Total mass
totalMass = driverMass + frameMass + subComponentsMass; % kg

% Mass supported by shock absorbers
sprungTotalMass = totalMass - (2*unsprungFrontCornerMass + 2*unsprungRearCornerMass); % kg

% Mass distribution based on Center Of Gravity (COG)
sprungFrontCornerMass = (sprungTotalMass*COGToRear)/(2*(COGToFront + COGToRear)); % kg
sprungRearCornerMass = (sprungTotalMass*COGToFront)/(2*(COGToFront + COGToRear)); % kg

end

% =========================================================================
%   Function: LandingImpactForce
%
%   Parameters: totalMass (kg), jumpHeight (m) 
%   
%   Outputs: normalForceX (N), normalForceY (N), normalForceZ (N)  
%
%   Calculates landing impact forces
% =========================================================================
function [normalForceX, normalForceY, normalForceZ] = LandingImpactForce(totalMass,jumpHeight)

% Gravitational acceleration
g = 9.81; % m/s^2

% Track width of vehcile
trackWidth = 1.354; % m

% Vehicle landing angle on x-y plane
alpha = 18; % Degrees

% Vehcile landing angle on x-z plane 
beta = 20; % Degrees

% Slow down distance 
deltaY = trackWidth*sind(alpha); % m

% Total normal force at wheel 
resultantNormalForce = (totalMass*2*g*jumpHeight)/(deltaY); % N

% Normal force x,y,z components
normalForceX = resultantNormalForce*sind(alpha); % N 
normalForceY = resultantNormalForce*cosd(beta)*cosd(alpha); % N
normalForceZ = resultantNormalForce*sind(beta); % N

end

% =========================================================================
%   Function: GetVehicleMaxHeight
%
%   Parameters: jumpHeight
%   
%   Outputs: maxVehicleHeight
%
%   Calculates the final height the vehicle will reach based on the jump
%   height inputted by the user
% =========================================================================
function maxVehicleHeight = GetVehicleMaxHeight(jumpHeight)

% Defining constants
jumpLength = 3; % m
velocity = 7; % m/s
g = 9.81; % m/s^2

% Jump angle
jumpAngle = asind(jumpHeight/jumpLength);

% Max height the vehicle can reach from the top of the jump 
projectileHeight = ((velocity^2)*sind(jumpAngle)^2)/(2*g);

% Final height
maxVehicleHeight = projectileHeight + jumpHeight;

end

