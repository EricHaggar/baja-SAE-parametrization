% =========================================================================
%   Function: FrameMain
%
%   Parameters: driverMass (kg), jumpHeight (m)
%   
%   Outputs: finalFrameMass (kg)
%
%   Description: Calculates the final mass of the frame by finding the
%   minimum tube thicknesses based on safety factors. The safety factors
%   are obtained by calling the FEA scripts. Finally, the output variables
%   will be appended to the log and equation text files.
% =========================================================================
function finalFrameMass = FrameMain(driverMass, maxVehicleHeight)
    
    % Output log file location
    logFile = 'Z:\2018\MCG4322A\Digital Files\BSAE-3B\Log\BSAE-3B_LOG.txt';
    
    % Output equation file location
    frameEquationFile = 'Z:\2018\MCG4322A\Digital Files\BSAE-3B\SolidWorks\Equations\frameEquations.txt';
    
    % Total mass excluding the frame and driver
    componentsMass = 155; %kg
       
    % First assumed values for the first iteration
    % The outer diameter for primary and secondary members are assumed to be
    % 38 mm
    thicknessOfPrimaryMembers = 1;
    thicknessOfSecondaryMembers = 2;
    
    % The maximal thickness the primary and secondary members can reach
    maxThickness1 = 31.75/2;
    maxThickness2 = 31.75/2;
    
    % Chosen safety factor
    safetyFactor = 1.5;
    
    % Getting the first mass
    tempFrameMass = updatedFrameMass(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers);
    
    % The total mass of the vehicle
    totalMass = tempFrameMass + driverMass + componentsMass;
    
    % Calling the function to determine the maximum forces for the four
    % scenarios
    [dropForce, speedImpactForce] = getMaxForces(totalMass, maxVehicleHeight); 
    
    % Initiation of an array to store the safety factors of every scenario
    allSafetyFactorsPrimary = [0, 0, 0, 0];
    allSafetyFactorsSecondary = [0, 0, 0, 0];
    
    % Finding the first set of safety factors
    allSafetyFactorsPrimary(1) = FrontImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
    allSafetyFactorsPrimary(2) = SideImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
    allSafetyFactorsPrimary(3) = RearImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
    allSafetyFactorsPrimary(4) = DropTest_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, dropForce);
    
    allSafetyFactorsSecondary(1) = FrontImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
    allSafetyFactorsSecondary(2) = SideImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
    allSafetyFactorsSecondary(3) = RearImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
    allSafetyFactorsSecondary(4) = DropTest_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, dropForce);
    
    % Will save the previoulsy obtained minimum safety factors
    
    % To observe if incrementing either the primary or secondary tube
    % thickness still has an effect
    
    % This will prevent unnecessary weight being added
    primaryMinSafetyFactor = [0.0001,min(allSafetyFactorsPrimary)];
    secondaryMinSafetyFactor = [0.0001,min(allSafetyFactorsSecondary)];
   
    while (min(allSafetyFactorsPrimary) < safetyFactor && min(allSafetyFactorsSecondary) < safetyFactor) && (thicknessOfPrimaryMembers < maxThickness1 && thicknessOfSecondaryMembers < maxThickness2)
        
        % Calculate the difference between the previous safety factors
        primarySafetyFactorDifference = 100*primaryMinSafetyFactor(1)/primaryMinSafetyFactor(2);
        secondarySafetyFactorDifference = 100*secondaryMinSafetyFactor(1) / secondaryMinSafetyFactor(2);
        
        if primarySafetyFactorDifference < abs(99.9) && min(allSafetyFactorsPrimary) > safetyFactor
            % Stop incrementing, do nothing
        else
            % New tube thicknesses
            thicknessOfPrimaryMembers = thicknessOfPrimaryMembers + 0.1;
            
            % Getting the updated frame mass
            tempFrameMass = updatedFrameMass(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers);
            
            % The updated total mass of the vehicle
            totalMass = tempFrameMass + driverMass + componentsMass;
            
            % Calling the function to determine the updated maximum forces for the four
            % scenarios
            [dropForce, speedImpactForce] = getMaxForces(totalMass, maxVehicleHeight);
            
            % Finding the first set of safety factors
            allSafetyFactorsPrimary(1) = FrontImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
            allSafetyFactorsPrimary(2) = SideImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
            allSafetyFactorsPrimary(3) = RearImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
            allSafetyFactorsPrimary(4) = DropTest_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, dropForce);
            
            % Finding the first set of safety factors
            allSafetyFactorsSecondary(1) = FrontImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
            allSafetyFactorsSecondary(2) = SideImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
            allSafetyFactorsSecondary(3) = RearImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
            allSafetyFactorsSecondary(4) = DropTest_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, dropForce);
            
            % Update the past and new minimum safety factors
            primaryMinSafetyFactor(1) = primaryMinSafetyFactor(2);
            primaryMinSafetyFactor(2) = min(allSafetyFactorsPrimary);
             
        end
        
        
        if (secondarySafetyFactorDifference < abs(99.9)) && min(allSafetyFactorsSecondary) > safetyFactor
            % Stop incrementing, do nothing
        else
            % Updates the thickness
            thicknessOfSecondaryMembers = thicknessOfSecondaryMembers + 0.1;

            % Getting the updated frame mass
            tempFrameMass = updatedFrameMass(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers);

            % The updated total mass of the vehicle
            totalMass = tempFrameMass + driverMass + componentsMass;

            % Calling the function to determine the updated maximum forces for the four
            % scenarios
            [dropForce, speedImpactForce] = getMaxForces(totalMass, maxVehicleHeight);
            
            % Finding the first set of safety factors
            allSafetyFactorsPrimary(1) = FrontImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
            allSafetyFactorsPrimary(2) = SideImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
            allSafetyFactorsPrimary(3) = RearImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
            allSafetyFactorsPrimary(4) = DropTest_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, dropForce);
            
            % Finding the secondary set of safety factors
            allSafetyFactorsSecondary(1) = FrontImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
            allSafetyFactorsSecondary(2) = SideImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
            allSafetyFactorsSecondary(3) = RearImpact_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, speedImpactForce);
            allSafetyFactorsSecondary(4) = DropTest_3DFEA(thicknessOfPrimaryMembers, thicknessOfSecondaryMembers, dropForce);
            
            % Update the past and new minimum safety factors
            secondaryMinSafetyFactor(1) = secondaryMinSafetyFactor(2);
            secondaryMinSafetyFactor(2) = min(allSafetyFactorsSecondary);
        end
        
    end
        
    finalFrameMass = tempFrameMass;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                          Log File Outputs                           %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           
    fileID = fopen(logFile,'at+');
    fprintf(fileID,'******************************************************************************\n');
    fprintf(fileID,'                             Optimized Frame Design \n');
    fprintf(fileID,'******************************************************************************\n\n');
    fprintf(fileID,strcat('Final frame mass = ', 32, num2str(round(finalFrameMass,2)),' kg\n'));
    fprintf(fileID,strcat('Primary member thickness = ', 32, num2str(thicknessOfPrimaryMembers),' mm\n'));
	fprintf(fileID,strcat('Secondary member thickness = ', 32, num2str(thicknessOfSecondaryMembers),' mm\n\n'));
    fclose(fileID);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                       Equation File Outputs                         %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
    fileID = fopen(frameEquationFile,'w+t');
    fprintf(fileID,strcat('"Temp Height" = 879.2mm \n'));
    fprintf(fileID,strcat('"PrimaryTubeThickness" = ',32, num2str (thicknessOfPrimaryMembers),'mm \n'));
    fprintf(fileID,strcat('"SecondaryTubeThickness" = ',32, num2str (thicknessOfPrimaryMembers),'mm \n'));
    fprintf(fileID,strcat('"OuterDIA" = 31.75mm \n'));    
    fclose(fileID);

end

% =========================================================================
%   Function: updatedFrameMass
%
%   Parameters: driverMass (kg), jumpHeight (m)
%   
%   Outputs: newMass(kg)
%
%   Description: Calculates the mass of the frame using the thicknesses
%   being parametrized
% =========================================================================
function newMass = updatedFrameMass(thicknessPrimary, thicknessSecondary)
    
    % The fixed outer element
    outerDiameterPrimary = 31.75; %mm
    outerDiameterSecondary = 31.75; %mm
    
    % Inner diameters
    primaryInnerDiameter = outerDiameterPrimary-2*thicknessPrimary;
    secondaryInnerDiameter = outerDiameterSecondary-2*thicknessSecondary;
    
    % Determining cross section areas for primary and secondary members
    primaryTubeArea = (pi/4)*((outerDiameterPrimary^2) - (primaryInnerDiameter^2)); %mm^2
    secondaryTubeArea = (pi/4)*((outerDiameterSecondary^2) - (secondaryInnerDiameter^2)); %mm^2
    
    % The fixed length of primary and secondary tube members  
    primaryLength = 445.18*25.4;    %mm
    secondaryLength = 652.12*25.4;  %mm
    
    % Finding the total volume of primary and secondary members
    primaryVolume = primaryTubeArea*primaryLength;  %mm^3
    secondaryVolume = secondaryTubeArea*secondaryLength;  %mm^3
    
    % Density of AISI 4130 steel
    density = 7.85*10^(-6); %kg/mm^3
    
    % Total mass is the density multiplied by the total volume
    newMass =  density*(primaryVolume+secondaryVolume); 
    
end


% =========================================================================
%   Function: getMaxForces
%
%   Parameters: totalMass (kg), jumpheight (m)
%   
%   Outputs: dropImpactForce (N), velocityImpactForce (N)
%
%   Description: Calculates the forces for a regular crash and a "drop
%   test" force caused by a jump
% =========================================================================
function [dropImpactForce, velocityImpactForce] = getMaxForces(totalMass, maxVehicleHeight)
    
    %----------------- Velocity Impact Force ------------------%
    
    % Maximum velocity of the car
    maxVelocity = 5.46; %m/s
    
    % Max deformation
    deltaY_vel = 0.5; %m
    
    % The impact force of the vehicle caused by a normal crash
    % Equation **between 39 and 40 ** unlabelled..
    velocityImpactForce = totalMass*(maxVelocity*maxVelocity)/(2*deltaY_vel);
    
    
    %------------------ "Drop Test" Force ---------------------%
    
    % The maxiumum deformation here is assumed to be 0.3m
    deltaY_drop = 0.3;
    
    % The force for a drop can now be calculated
    % Equation 42
    dropImpactForce = totalMass*2*9.81*maxVehicleHeight/deltaY_drop;
   
end


