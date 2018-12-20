% =========================================================================
%   Function: SteeringMain
%
%   Parameters: normalForcez (N), driverMass (kg), totalMass (kg),
%   frictionCoefficient, rackPinionRatio
%   
%   Outputs: None
%
%   SteeringMain is the main script for steering parametrization
% =========================================================================

function SteeringMain(normalForceZ, driverMass, totalMass, frictionCoefficient, rackPinionRatio)
    
    % Add necessary paths
    addpath('Z:\2018\MCG4322A\Digital Files\BSAE-3B\Programming\Stress Safety Factors');
    
    % Add output log path 
    logOutput = 'Z:\2018\MCG4322A\Digital Files\BSAE-3B\Log\BSAE-3B_LOG.txt';
    
    % Add equation file path
    steeringEquations = 'Z:\2018\MCG4322A\Digital Files\BSAE-3B\SolidWorks\Equations\steeringEquations.txt';
   
    % Dimensions definitions 
    
    rackHoleToHoleLength = 500;             % mm
    primarySteeringShaftlength = 555;       % mm
    steeringArmLength = 100;                % mm
    steeringShaftAngle = 30;                % degrees
    turningRadius = 2000;                   % mm
    track = 1354;                           % mm
    wheelBase = 1561;                       % mm
    lengthTieRod = 305;                     % mm
    
    % ---------------------------------------------------------------------
    
    frontTireNormalForce = totalMass*9.81*(644)/wheelBase;    % N
    
    % Material properties declarations
    % AISI 4140 steel
    sy_4140 = 655;       % MPa
    su_4140 = 1020.4;    % MPa
    bhn_4140 = 302;      % MPa
    
    % AISI 4340 steel
    sy_4340 = 861.8;     % MPa
    su_4340 = 1279;      % MPa
    bhn_4340 = 364;      % MPa
    
    % AISI 1040 steel
    sy_1040 = 413.7;     % MPa
        
    % AISI1018 steel
    sy_1018 = 220;       % MPa
    young_1018 = 205000; % MPa
    
    % Metric bolt specs
    metricBoltsMajorDiameters = [6 7 8 9 10 12 14 16 18];
    metricBoltsStressAreas = [20.1 28.9 36.6 58 84.3 115 157 192]; % mm^2
    
    % SAE grade 4.6 yield strength
    sy_SAE46 = 240;      % MPa
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%              
    %                   Turning Input Forces Analysis                                                
    %############################################%%%%%%%%%%%%%%%%%%%%%%%%%%

    % The moment required to turn one front wheel
    % The oval contact patch area is assumed to be a circle of the same area
    % The radius is then found, and in this case assumed to be 100mm

    momentToTurn = (2/3)*frictionCoefficient*frontTireNormalForce*100; % Nmm

    % Maxiumum turning angle using ackerman
    maxTurningAngle = atand(wheelBase/(turningRadius - 0.5*track)); % degrees

    % Steering arm angle
    steeringArmAngle = atand(track/(2*wheelBase)); % degrees

    % Lateral force on the steering aarm required to turn the steering wheel
    steeringArmTurningForce = momentToTurn/(steeringArmLength*cosd(90-maxTurningAngle-steeringArmAngle)); % N
        

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Steering arm bolt shear
    % An M6 bolt is chosen as default
    
    % Variable to iterate through bolt tables
    i = 1;
    
    % Verify if an M6 bolt is satisfactory
    steeringArmBoltDiameter = metricBoltsMajorDiameters(i); % mm
    steeringArmSF = GetCircularShearStressSF(steeringArmTurningForce, steeringArmBoltDiameter, sy_SAE46);
    
    % Will start greater if satisfactory and will not change the bolt size
    % Will only change if M6 is not satisfactory
    while steeringArmSF < 1.4
        steeringArmBoltDiameter = metricBoltsMajorDiameters(i+1); % mm
        steeringArmSF = GetCircularShearStressSF(steeringArmTurningForce, steeringArmBoltDiameter, sy_SAE46);
        % Next bolt
        i = i+1;
    end 
    
    %Reset i to 1
    i = 1;
   
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Heim joint threaded portion threading
    
    %Finding the axial force of the tie rod
    %Tie rod angle is 55.67 degrees, 90-55.67 = 34.33 with the bottom plane
    %Adding an angle of 10 degrees with the front plane
    axialForceTieRods = steeringArmTurningForce/(cosd(34.33)*cosd(10)); %N
    
    %Assume that the threaded portion follows the metric bolt
    %characteristics
    SA_heimjointStressArea = metricBoltsStressAreas(i); %mm^2
    
    %As the equation is the same as axial stress, this function is called
    %with the equivalent diameter for this area
    equivalentDiameter = sqrt(4*SA_heimjointStressArea/pi); %mm
    
    SA_heimJointSF = GetCylindricalAxialSF(axialForceTieRods, equivalentDiameter, sy_1018, 1);
    
    %in case the threads on the heim joint are too small
    while SA_heimJointSF < 1.5
       SA_heimjointStressArea = metricBoltsStressAreas(i+1); %mm^2
       equivalentDiameter = sqrt(4*SA_heimjointStressArea/pi); %mm
       SA_heimJointSF = GetCylindricalAxialSF(axialForceTieRods, equivalentDiameter, sy_1018, 1);
       %Next bolt
       i = i+1;
    end 
    %As the 
    %i = i-1;
    heimJointThreadingSize = metricBoltsMajorDiameters(i);  %mm
    heimJointHoleSize = steeringArmBoltDiameter;  %mm^2
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Tie rod outer diameter calculations
    
    
   
    innerDiameterTieRod = metricBoltsMajorDiameters(i)+0.6;%mm
    outerDiameterTieRod = innerDiameterTieRod+0.05; %mm
    
    tieRodsSF = [0,0];
    tieRodsSF(1) = GetTubularBucklingSF(axialForceTieRods, innerDiameterTieRod, outerDiameterTieRod, lengthTieRod, young_1018);
    tieRodsSF(2) = GetTubularAxialSF(axialForceTieRods, innerDiameterTieRod, outerDiameterTieRod, sy_1018, 1);
        
    while min(tieRodsSF) < 3
        outerDiameterTieRod = outerDiameterTieRod + 0.05;  %mm
        tieRodsSF(1) = GetTubularBucklingSF(axialForceTieRods, innerDiameterTieRod, outerDiameterTieRod, lengthTieRod, young_1018);
        tieRodsSF(2) = GetTubularAxialSF(axialForceTieRods, innerDiameterTieRod, outerDiameterTieRod, sy_1018, 1);
    end
    
    %Must see if the pin of the same size as the steering arm bolt will
    %fail in double shear on the rack end.
    
    rackPinDiameter = steeringArmBoltDiameter;  %mm
    
    rackPinSF = 2*GetCircularShearStressSF(axialForceTieRods, rackPinDiameter, sy_SAE46);
    
    while rackPinSF < 1.5 
        
        rackPinDiameter = rackPinDiameter+1;  %mm
    
        rackPinSF = 2*GetCircularShearStressSF(axialForceTieRods, rackPinDiameter, sy_SAE46);
    
    end
    
    pinionFaceWidth = 26.5; %mm
    rackheight = 20; %mm
    
    %Approximation of the stress concentration curve
    
    rackEndRatio = rackPinDiameter/rackheight;
    
    %Stress concentration factor
    k_t = -rackEndRatio*(11.6) + 7.9767;
    
    prongArea = (rackheight - rackPinDiameter)*(pinionFaceWidth);  %mm^2
    
    %The axial force on the rack is the same force as the lateral force on
    %the steering arm bolt
    rackAxialForce = steeringArmTurningForce;  %N
    
    %To use the cylindrical axial stress function
    equivalentDiameter = sqrt(4*prongArea/pi);  %mm
    
    
    
    rackEndsSF = GetCylindricalAxialSF(rackAxialForce, equivalentDiameter, sy_4140,k_t);
    
    while rackEndsSF < 1.5
        rackheight = rackheight+0.01;  %mm
        rackEndRatio = rackPinDiameter/rackheight; 
        k_t = -rackEndRatio*(11.6) + 7.9767;
        equivalentDiameter = sqrt(4*prongArea/pi);
        rackEndsSF = GetCylindricalAxialSF(rackAxialForce, equivalentDiameter, sy_4140,k_t);
    end
    
    %Starting pitch diameter
    %pinionPitchDiameter = 34; %mm
    
    %The maximum steering angle is found using ackerman
    %Equation 11
    maxSteeringAngle = atand(wheelBase/(turningRadius - 0.5*track));  %degree
    
    %Desired pinion diameter
    %Equation 204
    
    %The diameter of the pinion based on how much the steering arm needs to
    %be pushed
    desiredPinionDiameter = 2*steeringArmLength*sind(0.5*maxSteeringAngle)/(rackPinionRatio*pi);  %mm
    
    %The distance the rack must travel in one direction to reach the
    %maximum turning angle
    maxRackTravel = rackPinionRatio*desiredPinionDiameter*pi;  %mm^2
    
    %Finding the minimum number of pinion teeth for a pressure angle of 20
    %degrees
    pressureAngle = 20;
    numberOfTeeth = ceil(2/(sind(pressureAngle)*sind(pressureAngle)));  
    
    %Will be used to ensure the ratio desired is possible
    startingDiameterPinion = desiredPinionDiameter;
    
    
    %Worst case tangential force on the pinion to turn both wheels
    pinionTangentialForce = steeringArmTurningForce*2; %N
    
    pinionBendingSF = pinionBendingStress(numberOfTeeth, desiredPinionDiameter, steeringArmTurningForce, pinionFaceWidth, su_4340);
    pinionFatigueSF = pinionFatigueStress(desiredPinionDiameter, steeringArmTurningForce, pinionFaceWidth, bhn_4340);
    
    
    %While the program should never enter this loop, it is done just in
    %case...
    
    %Incrememnt the pinion diameter until the safety factors are met
    while max(pinionBendingSF,pinionFatigueSF) < 1.5
        desiredPinionDiameter = desiredPinionDiameter + 0.05;
        pinionBendingSF = pinionBendingStress(numberOfTeeth, desiredPinionDiameter, steeringArmTurningForce, pinionFaceWidth, su_4340); 
        pinionFatigueSF = pinionFatigueStress(desiredPinionDiameter, steeringArmTurningForce, pinionFaceWidth, bhn_4340);
    end
    
    pinionChange = startingDiameterPinion/startingDiameterPinion;
    %All the forces through each components caused by the steering wheel
    %input forces should be found.
    
    
    %############################################%
    %                                            %
    %    Steering Wheel Input Forces Analysis    %
    %                                            %
    %############################################%

    %Pulling force is the driver weight divided by two
    pullingForce = driverMass*9.81/2; %N

    %Pushing force is the driver weight
    pushingForce = driverMass*9.81; %N

    %Hitting force is the driver weight divided by four
    hittingForce = driverMass*9.81/4;  %N
    
    %Steering wheel holding bolt forces:
    %Equation 131
    steeringWheelBoltForce = pullingForce;  %N

    %Primary steering shaft forces and max moment
    maxMomentPrimary = hittingForce*primarySteeringShaftlength/8;  %Nmm
    
    %Finding the reactions
    %Equation 140
    %primaryReactionLateral2 = hittingForce*(primarySteeringShaftlength/8)/(primarySteeringShaftlength*(1-1/8-1/20));  %N
    
    %Equation 139
    %primaryReactionLateral1 = hittingForce + primaryReactionLateral2;  %N
    
    %The pushing force applied on the primary steering shaft followed by
    %the equal reactions on the u-joint yoke arms
    
    primaryAxialPushingForce = pushingForce; %N
    
    %Equation 144
    %uJointYokeArmForce = primaryAxialPushingForce/2; %N
    
    
    %Pulling force reaction on the primary steering shaft
    %Equation 150
    %primaryPullingReaction = pullingForce; %N 

    %Pushing force on one arm of the secondary steering shaft
    %Equation 157
    secondaryYokeArmPushingRadial = pushingForce*sind(steeringShaftAngle); %N
    secondaryYokeArmPushingAxial = pushingForce*cosd(steeringShaftAngle); %N
    secondaryMaxMoment = 60*secondaryYokeArmPushingRadial; %Nmm
    
    %All required forces from the lateral, pushing, and pulling forces have
    %been found.
    
    %The analysis can now continue with the turning force applied at the
    %pinion
    
    %With a known pinion tangential force, the torque on the pinion can be
    %found.
    
    pinionTorque = desiredPinionDiameter*pinionTangentialForce; %Nmm
    
    %If the key width is assumed to be 1/4 of the shaft diameter
    %the shear force on the key becomes
    
    %starting key width 
    keyWidth = 1; %mm
    
    %With a face width of 26.5 mm, and a step for the bearing, the key
    %length will be 30 mm
    keyLength = 30; %mm
    
    keyShearForce = pinionTorque/(2*keyWidth); %N
    
    pinionKeySF = GetRectangularShearStressSF(keyShearForce, keyLength, keyWidth, sy_1040);
    
    while pinionKeySF < 1.5
        keyWidth = keyWidth + 0.01;
        keyShearForce = pinionTorque/(2*keyWidth);
        pinionKeySF = GetRectangularShearStressSF(keyShearForce, keyLength, keyWidth, sy_1040);        
        
    end

    
    %The minimum shaft diameter chosen is thus the key width*4
    secondaryShaftDiameter = keyWidth*4; %mm
    
    secondaryShaftSafetyFactors = [0,0,0];
    %The stress concentration factor for a profiled keyway is 1.3 in
    %bending
    secondaryShaftSafetyFactors(1) = GetCircularBendingStressSF(secondaryMaxMoment, secondaryShaftDiameter, sy_1018, 1.3);
    %Although bucklingwill clearly not occur, the function is available and
    %it will therefore be calculated
    secondaryShaftSafetyFactors(2) = GetCircularBucklingSF(secondaryYokeArmPushingAxial, secondaryShaftDiameter, 60, young_1018);
    
    %Transverse shear safety factor
    secondaryShaftSafetyFactors(3) = GetTransverseShearSF(pinionTorque, 0, secondaryShaftDiameter, 1.3, sy_1018);
    
    while min(secondaryShaftSafetyFactors) < 1.5
        secondaryShaftDiameter = secondaryShaftDiameter + 0.05;
        secondaryShaftSafetyFactors(1) = GetCircularBendingStressSF(secondaryMaxMoment, secondaryShaftDiameter, sy_1018, 1.3);
        secondaryShaftSafetyFactors(2) = GetCircularBucklingSF(secondaryYokeArmPushingAxial, secondaryShaftDiameter, 60, young_1018);
        secondaryShaftSafetyFactors(3) = GetTransverseShearSF(pinionTorque, 0, secondaryShaftDiameter, 1.3, sy_1018);
    end
    
    % Take the ceiling of the values. the change will be small, but a bearing will be found easily
    secondarySmallShaftDiameter = ceil(secondaryShaftDiameter); %mm
    secondaryLargeShaftDiameter = ceil(secondaryShaftDiameter + 8); %mm
    
    %To find the total force on the bearings, the reactions must be found
    bearing2xReaction = pinionTangentialForce*18.25/21.75; %N
    bearing1xReaction = pinionTangentialForce - bearing2xReaction;  %N
    
    bearing2yReaction = pinionTangentialForce*tand(20)*18.25/21.75; %N
    bearing1yReaction = pinionTangentialForce*tand(20) - bearing2yReaction; %N
    
    totalBearing2Force = sqrt(bearing2xReaction*bearing2xReaction+bearing1xReaction*bearing1xReaction); %N
    totalBearing1Force = sqrt(bearing2yReaction*bearing2yReaction+bearing1yReaction*bearing1yReaction); %N
    

    bearing2Life = (7280/(1.75*totalBearing2Force))^3.33; %cycles
    bearing1Life = (7280/(1.75*totalBearing1Force))^3.33; %cycles
    
    
    %The u-joint failure point is the pin. Must ensure it does not fail
    uJointPinShearForce = primaryAxialPushingForce/2 + 0.5*pinionTorque/33.75; %N
    
    %u-joint height
    uJointYokeHeight = 30; %mm
    
    %Starting Pin Diameter
    uJointPinDiameter = 6; %mm
    uJointPinSF = GetCircularShearStressSF(uJointPinShearForce, uJointPinDiameter, sy_1018);
    
    %Should never enter this. Just in case. Also increment the yoke height
    %to maintain a hole to height ratio. thus maintaining a constant yoke
    %thickness, bushing thickness, and stress concentration factor that did
    %not fail
    while uJointPinSF < 1.5
        uJointPinDiameter = uJointPinDiameter + 0.01; %mm
        uJointYokeHeight = uJointYokeHeight + 0.01; %mm
        uJointPinSF = GetCircularShearStressSF(uJointPinShearForce, uJointPinDiameter, sy_1018);
    end
    
    %The primary shaft is the last component to parametrize
    
    %The key will be the same length as the pinion key.
    
    i = 1;
    steeringWheelBoltStressArea = metricBoltsStressAreas(i);  %mm^2
    
    %As the equation is the same as axial stress, this function is called
    %with the equivalent diameter for this area
    equivalentDiameter = sqrt(4* steeringWheelBoltStressArea/pi);  %mm
    
    steeringWheelBoltSF = GetCylindricalAxialSF(steeringWheelBoltForce, equivalentDiameter, sy_1018, 1);
    
    %in case the threads on the heim joint are too small
    while steeringWheelBoltSF < 1.5
       steeringWheelBoltStressArea = metricBoltsStressAreas(i+1);
       equivalentDiameter = sqrt(4*steeringWheelBoltStressArea/pi);
       steeringWheelBoltSF = GetCylindricalAxialSF(pullingForce, equivalentDiameter, sy_1018, 1);
       
       % Next bolt
       i = i+1;
    end 
    
    %+0.6 for hole size
    steeringWheelBoltHoleDiameter = metricBoltsMajorDiameters(i)+0.6; %mm
    
    primaryInnerDiameter = steeringWheelBoltHoleDiameter; %mm
    primaryOuterDiameter = primaryInnerDiameter + keyWidth*1.5; %mm
    
    primaryShaftSafetyFactors = [0,0,0,0];
    
    %Find the bending stress safety factor
    primaryShaftSafetyFactors(1) = GetTubularBendingStressSF(maxMomentPrimary, primaryInnerDiameter, primaryOuterDiameter, sy_1018, 1.6);
    
    %Find the axial stress safety factor
    primaryShaftSafetyFactors(2) = GetTubularAxialSF(pullingForce, primaryInnerDiameter, primaryOuterDiameter, sy_1018,1.3);
    
    %Find the buckling stress safety factor
    primaryShaftSafetyFactors(3) = GetTubularBucklingSF(pushingForce, primaryInnerDiameter, primaryOuterDiameter, 700, young_1018);
    
    %Find the transverse stress safety factor
    primaryShaftSafetyFactors(4) = GetTransverseShearSF(pinionTorque, primaryInnerDiameter, primaryOuterDiameter, 1.3, sy_1018);
    
    while min(primaryShaftSafetyFactors) < 1.5
        primaryOuterDiameter = primaryOuterDiameter + 0.01; %mm
        primaryShaftSafetyFactors(1) = GetTubularBendingStressSF(maxMomentPrimary, primaryInnerDiameter, primaryOuterDiameter, sy_1018, 1.6);
        primaryShaftSafetyFactors(2) = GetTubularAxialSF(pullingForce, primaryInnerDiameter, primaryOuterDiameter, sy_1018,1.3);
        primaryShaftSafetyFactors(3) = GetTubularBucklingSF(pushingForce, primaryInnerDiameter, primaryOuterDiameter, 700, young_1018);
        primaryShaftSafetyFactors(4) = GetTransverseShearSF(pinionTorque, primaryInnerDiameter, primaryOuterDiameter, 1.3, sy_1018);
    end
    
    %For ease of obtaining bearings
    primarySmallDiameter = ceil(primaryOuterDiameter); %mm
    primaryLargeDiameter = primarySmallDiameter + 8; %mm
    
    flangedBearingThickness = ceil((primaryLargeDiameter-primarySmallDiameter)/4); %mm
    
    forceToTurn = 0.5*pinionTorque/150; %N
    forceToTurnPounds = forceToTurn/4.456; %pounds
    
    % Standardize bore diameter 
    if secondaryLargeShaftDiameter < 25 && secondaryLargeShaftDiameter > 20
        secondaryLargeShaftDiameter = 25;
    end
    
    rackPinDiameter = 10;
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                        Steering Log Output                          %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fileID = fopen(logOutput,'at');
    fprintf(fileID,'******************************************************************************\n');
    fprintf(fileID,'                             Optimized Steering Design \n');
    fprintf(fileID,'******************************************************************************\n\n');
    fprintf(fileID,'------------ Steering Dimensions ----------------\n\n');
    fprintf(fileID,strcat('Inner tie rod diameter = ',32, num2str (innerDiameterTieRod),' mm\n'));
    fprintf(fileID,strcat('Outer tie rod diameter = ',32, num2str (outerDiameterTieRod),' mm\n\n'));
    rackTeethLength = round(2*maxRackTravel,1);
    fprintf(fileID,strcat('Rack toothed portion length = ',32, num2str(rackTeethLength),' mm\n'));
    fprintf(fileID,strcat('Pinion number of teeth = ',32, num2str(numberOfTeeth),'.\n'));
    fprintf(fileID,strcat('Pinion pitch diameter = ',32, num2str(round(desiredPinionDiameter,2)),' mm\n\n'));
    
    fprintf(fileID,strcat('Pinion key width = ', 32, num2str(keyWidth),' mm\n\n'));
    fprintf(fileID,strcat('Secondary shaft small diameter = ',32, num2str (secondarySmallShaftDiameter),' mm\n'));
    fprintf(fileID,strcat('Secondary shaft large diameter = ',32, num2str (secondaryLargeShaftDiameter),' mm\n\n'));
    fprintf(fileID,strcat('Primary shaft small diameter = ',32, num2str (primarySmallDiameter),' mm\n'));
    fprintf(fileID,strcat('Primary shaft large diameter = ',32, num2str (primaryLargeDiameter),' mm\n\n'));
    fprintf(fileID,strcat('Steering wheel holding bolt hole diameter = ',32, num2str (ceil(steeringWheelBoltHoleDiameter)),'\n\n\n'));
    
    fprintf(fileID,'----------- Steering Specifications --------------\n\n');
    
    fprintf(fileID,strcat('Steering arm bolt: SAE grade 4.6 ', 32, strcat('M',num2str(steeringArmBoltDiameter)),'\n'));
    fprintf(fileID,strcat('Steering arm heim joint threading type: ',32, strcat(' M',num2str(heimJointThreadingSize)),' counter clockwize\n'));
    fprintf(fileID,strcat('Steering arm heim joint ball hole size: ',32, num2str (steeringArmBoltDiameter),' mm diameter\n\n'));
    
    fprintf(fileID,strcat('Rack pin: SAE grade 4.6, ',32, num2str (heimJointHoleSize),' mm diameter\n'));
    fprintf(fileID,strcat('Rack pin heim joint threading type: ',32, strcat('M',num2str(heimJointThreadingSize)),' clockwize\n'));
    fprintf(fileID,strcat('Rack pin heim joint ball hole diameter, ',32, num2str(heimJointHoleSize),' mm\n\n'));
    
    fprintf(fileID,strcat('Bearing 1 required life = ',32, num2str (round(bearing1Life,0)),' x 10^6 cycles\n'));
    fprintf(fileID,strcat('Bearing 1 required bore = ',32, num2str (secondarySmallShaftDiameter),' mm\n\n'));
    
    fprintf(fileID,strcat('Bearing 2 required life = ',32, num2str (round(bearing2Life,0)),' x 10^6 cycles\n'));
    fprintf(fileID,strcat('Bearing 2 required bore = ',32, num2str (secondaryLargeShaftDiameter),' mm\n\n'));    
    
    fprintf(fileID,strcat('Sleeve bearing thickness = ',32, num2str (2),' mm\n'));
    fprintf(fileID,strcat('Sleeve bearing bore diameter = ',32, num2str (primaryLargeDiameter),' mm\n\n'));
    
    fprintf(fileID,strcat('Flanged sleeve bearing thickness = ',32, num2str (flangedBearingThickness),' mm\n'));
    fprintf(fileID,strcat('Flanged sleeve bearing bore diameter = ',32, num2str (primarySmallDiameter),' mm\n\n'));
    
    if pinionChange == 1
        fprintf(fileID,strcat('Desired rack and pinion ratio is possible\n\n'));
    else
        fprintf(fileID,strcat('Desired rack and pinion ratio is not possible. The pinion has changed by ',32, num2str (pinionChange),' percent \n\n'));
    end
    
    fprintf(fileID,strcat('Steering wheel applied force is ',32, num2str (round(forceToTurn,0)),' N (',32, num2str (round(forceToTurnPounds,0)), ' lbs)', '\n\n'));
	fclose(fileID);
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                      Equation File Outputs                          %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fileID = fopen(steeringEquations,'w+t');
    fprintf(fileID,strcat('"column angle" = ',32, num2str (45),'deg \n'));
    fprintf(fileID,strcat('"short_bearing_outer_width" = ',32, num2str (10),'mm \n')); 
    fprintf(fileID,strcat('"wheel base" = ',32, num2str (wheelBase),'mm \n'));
    fprintf(fileID,strcat('"track" = ',32, num2str (track),'mm \n'));
    fprintf(fileID,strcat('"turning radius" = ',32, num2str (turningRadius),'mm \n'));
    fprintf(fileID,strcat('"turn to lock" = ',32, num2str (rackPinionRatio),'mm \n'));
    fprintf(fileID,strcat('"steering arm length" = ',32, num2str (steeringArmLength),'mm \n\n'));
    
    fprintf(fileID,strcat('"primary shaft small diameter" = ',32, num2str (primarySmallDiameter),'mm \n'));
    fprintf(fileID,strcat('"primary shaft large diameter" = ',32, num2str (primaryLargeDiameter),'mm \n'));
    
    fprintf(fileID,strcat('"secondary shaft small diameter" = ',32, num2str (secondarySmallShaftDiameter),'mm \n'));
    fprintf(fileID,strcat('"secondary shaft large diameter" = ',32, num2str (secondaryLargeShaftDiameter),'mm \n'));
    
    fprintf(fileID,strcat('"steering column length" = ',32, num2str (primarySteeringShaftlength),'mm \n'));
    
    fprintf(fileID,strcat('"keyway_height" = ',32, num2str (keyWidth/2),'mm \n'));
    fprintf(fileID,strcat('"keyway_width" = ',32, num2str (keyWidth),'mm \n'));
    fprintf(fileID,strcat('"keyway_length" = ',32, num2str (30),'mm \n\n'));
    
    
    fprintf(fileID,strcat('"steering wheel bolt width" = ',32, num2str (steeringWheelBoltHoleDiameter - 0.6),'mm \n'));
    fprintf(fileID,strcat('"steering wheel bolt length" = ',32, num2str (40),'mm \n'));
    
    
    fprintf(fileID,strcat('"bushing length" = ',32, num2str (40),'mm \n'));
    fprintf(fileID,strcat('"bushing thickness" = ',32, num2str (3),'mm \n\n'));
    
    fprintf(fileID,strcat('"u_joint clearance" = ',32, num2str (30),'mm \n'));
    fprintf(fileID,strcat('"u_joint thickness" = ',32, num2str (7.5),'mm \n\n'));
    
    fprintf(fileID,strcat('"horizontal shaft length" = ',32, num2str (90),'mm \n'));
    fprintf(fileID,strcat('"column bushing diameter" = "primary shaft small diameter" + 4 \n'));
    fprintf(fileID,strcat('"column bushing distance" = "steering column length"/4 \n'));
    
    fprintf(fileID,strcat('"pinion width" = 26.5mm \n'));
    
    fprintf(fileID,strcat('"pin hole diameter" = ',32, num2str (rackPinDiameter),'mm \n'));
    fprintf(fileID,strcat('"rack hole to hole" = ',32, num2str (rackHoleToHoleLength),'mm \n'));
    fprintf(fileID,strcat('"rack length" = "rack hole to hole" + "pin hole diameter"*2 \n\n'));
    
    fprintf(fileID,strcat('"max turning angle" = atn("wheel base" / ("turning radius" - 0.5 * "track")) \n'));
    fprintf(fileID,strcat('"max travel" = 2 * "steering arm length" * sin(0.5 * "max turning angle") \n'));
    fprintf(fileID,strcat('"pitch diameter" = "max travel"/(pi * "turn to lock") \n'));
    fprintf(fileID,strcat('"number of teeth" = ',32, num2str (numberOfTeeth),'mm \n'));
    fprintf(fileID,strcat('"pressure angle" = 20deg \n'));
    fprintf(fileID,strcat('"module" = "pitch diameter" / "number of teeth" \n\n'));
    
    fprintf(fileID,strcat('"tie rod length" = ',32, num2str (lengthTieRod),'mm \n'));
    fprintf(fileID,strcat('"tie rod inner diameter" = ',32, num2str (innerDiameterTieRod),'mm \n'));
    fprintf(fileID,strcat('"tie rod outer diameter" = ',32, num2str (outerDiameterTieRod),'mm \n'));
    fclose(fileID);
end

% =========================================================================
%   Function: pinionBendingStress
%
%   Parameters: numberOfTeeth, pitchDiameter (mm), tangentialForce (N),
%   faceWidth (mm), ultimateStrength(N)
%
%   Outputs: n (safety factor)
%
%   Calculates the pinion bending fatigue safety factor
% =========================================================================
function n = pinionBendingStress(numberOfTeeth, pitchDiameter, tangentialForce, faceWidth, ultimateStrength) 
    
    % Bending stress factors
    k_v = 1;
    k_o = 2.25;
    k_m = 1.6;
    j = 0.35;
        
    % Conversion of Newtons to pounds 
    tangentialForceImperial = 0.2248*tangentialForce;
    
    % Conversion of mm to inches
    pitchDiameterImperial = pitchDiameter/25.4;
    faceWidthImperial = faceWidth/25.4;
    
    % Bending stress
    sigmaBending = tangentialForceImperial*(numberOfTeeth/pitchDiameterImperial)*k_v*k_o*k_m/(faceWidthImperial*j)/1000; % ksi
    
    % Bending fatigue stress factrors  
    c_l  =1;
    c_g  =1;
    c_s  =0.79;
    k_r  =0.897;
    k_t  =1;
    k_ms =1.4;
    
    s_n_prime = 0.5*ultimateStrength/6.895; % ksi
    
    % Bending fatigue stress
    bendingFatigueStress = s_n_prime*c_l*c_g*c_s*k_r*k_t*k_ms; % ksi
    
    % Safety factor for gear bending fatigue
    % No conversion back to metric needed
    n = bendingFatigueStress/sigmaBending; 

end

% =========================================================================
%   Function: pinionFatigueStress
%
%   Parameters: pitchDiameter (mm), tangentialForce (N),
%   faceWidth (mm), brinellHardness
%
%   Outputs: n (safety factor)
%
%   Calculates a gear fatigue strength for a connection to a rack  
% =========================================================================
function n = pinionFatigueStress(pitchDiameter, tangentialForce, faceWidth, brinellHardness)
    
    pressureAngle = 20; %degrees
    c_p = 2300; %sqrt(psi)
    
    %Conversion of Newtons to pounds for the tangential force
    tangentialForceImperial = 0.2248*tangentialForce;  %in
    
    %Conversion of mm to inches for faceWidth and pitchDiameter
    pitchDiameterImperial = pitchDiameter/25.4; %in
    faceWidthImperial = faceWidth/25.4; %in
    
    k_v = 1;
    k_o = 2.25;
    k_m = 1.6;
    
    %Finding the surface stress. the third term of the square root will
    %always be 0, and will be ignored 
    sigma_h = c_p*sqrt((tangentialForceImperial*(k_v*k_o*k_m)/(faceWidthImperial*cosd(pressureAngle)))*(1/(0.5*pitchDiameterImperial*sind(pressureAngle))));
    sigma_h = sigma_h/1000; %ksi
    %Finding the surface fatigue strength 
    s_fe = 0.4*brinellHardness - 10; %ksi
    
    
    c_li = 1.1; 
    c_r = 1.25;
    
    %Gear teeth strength 
    s_h = s_fe*c_li*c_r;
    
    n = s_h/sigma_h;
   
end





