% =========================================================================
% =========================================================================
%                             BAJA SAE GUI    
% =========================================================================
% =========================================================================

% Developed by: BSAE-3B Team
% GROUP: BSAE-3B
% University of Ottawa
% Mechanical Engineering

% =========================================================================
% SOFTWARE DESCRIPTION
% =========================================================================

function varargout = MAIN(varargin)
% MAIN MATLAB code for MAIN.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MAIN_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MAIN_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MAIN

% Last Modified by GUIDE v2.5 05-Dec-2018 18:45:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MAIN_OpeningFcn, ...
                   'gui_OutputFcn',  @MAIN_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MAIN is made visible.
function MAIN_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MAIN (see VARARGIN)

% Choose default command line output for MAIN
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Display Assembly picture on the GUI
axis image
axes(handles.finalAssemblyImage);
assemblyPicture = imread('Z:\2018\MCG4322A\Digital Files\BSAE-3B\GUI Images\Assembly.jpg');
imshow(assemblyPicture);

% Display SAE Logo
axis image
axes(handles.SAELogo);
saeLogo = imread('Z:\2018\MCG4322A\Digital Files\BSAE-3B\GUI Images\SAE Logo.png');
imshow(saeLogo);

% Display uOttawa Logo
axis image
axes(handles.uottawaLogo);
uottawaLogo = imread('Z:\2018\MCG4322A\Digital Files\BSAE-3B\GUI Images\uOttawa Logo.jpg');
imshow(uottawaLogo);

% Initialize driver mass
initialDriverMass = get(handles.driverMassSlider, 'Max');
set(handles.driverMassText, 'String', num2str(initialDriverMass));
set(handles.driverMassSlider, 'Value', initialDriverMass);

% Initialize jump height
initialJumpHeight = get(handles.jumpHeightSlider, 'Max');
set(handles.jumpHeightText, 'String', num2str(initialJumpHeight));
set(handles.jumpHeightSlider, 'Value', initialJumpHeight);

% Initialize all radio buttons
set(handles.suspensionFeelButtonGroup, 'SelectedObject', handles.medium);
set(handles.rackPinionRatioButtonGroup, 'SelectedObject', handles.normalRatio);
set(handles.terrainTypeButtonGroup, 'SelectedObject', handles.dry);

% Set initial log message
set(handles.logOutputText,'String', 'Choose input parameters and click "Generate Design!"'); 

% Hide Log file output directory
set(handles.logOutputPathText,'Visible', 'off');

% Set the window title with the group identification:
set(handles.figure1,'Name','BSAE-3B // CADCAM 2018');

%Add the 'subfunctions' folder to the path so that subfunctions can be
%accessed
addpath('Z:\2018\MCG4322A\Digital Files\BSAE-3B\Programming');


% --- Outputs from this function are returned to the command line.
function varargout = MAIN_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in generateDesignButton.
function generateDesignButton_Callback(hObject, eventdata, handles)
% hObject    handle to generateDesignButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if(isempty(handles))
    Wrong_File();
else

    % Get the design parameters from the interface
    driverMass = str2double(get(handles.driverMassText, 'String'));
    suspensionFeelType = get(get(handles.suspensionFeelButtonGroup, 'SelectedObject'),'String');
    rackPinionRatio = get(get(handles.rackPinionRatioButtonGroup, 'SelectedObject'),'String');
    jumpHeight = round(str2double(get(handles.jumpHeightText, 'String')),3);
    terrainType = get(get(handles.terrainTypeButtonGroup, 'SelectedObject'),'String');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %                       Perform range checking                        %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Check driver mass inputted 
    if (isnan(driverMass) ||  driverMass < get(handles.driverMassSlider, 'Min') || driverMass > get(handles.driverMassSlider, 'Max'))
        msgbox('The driver weight specified is not an acceptable value. Please correct it.','Cannot generate design!','warn');
        return;
    end
    
    % Check jump height inputted
    if (isnan(jumpHeight) ||  jumpHeight < get(handles.jumpHeightSlider, 'Min') || jumpHeight > get(handles.jumpHeightSlider, 'Max'))
        msgbox('The jump height specified is not an acceptable value. Please correct it.','Cannot generate design!','warn');
        return;
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %                        Radio button values                          %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
    % Checks which suspension feel type is selected and assigns its value to the corresponding variable
    if (strcmp(suspensionFeelType,'Soft (0.2)'))
        suspensionFeelType = 0.2;
    elseif (strcmp(suspensionFeelType,'Medium (0.4)'))
        suspensionFeelType = 0.4;
    else 
        suspensionFeelType = 0.6;
    end

    % Checks which steering rack and pinion ratio is selected and assigns its value to the corresponding variable
    if (strcmp(rackPinionRatio,'0.5'))
        rackPinionRatio = 0.5;
    elseif (strcmp(rackPinionRatio,'0.75'))
        rackPinionRatio = 0.75;
    else 
        rackPinionRatio = 1.0;
    end

    % Checks which steering turns to lock is selected and assigns its value to the corresponding variable
    if (strcmp(terrainType,'Snow (0.2)'))
        terrainType = 0.2;
    elseif (strcmp(terrainType,'Wet (0.6)'))
        terrainType = 0.6;
    else 
        terrainType = 0.75;
    end
    
    % Creates a message box to let the user know that the design is being
    % generated 
    generateMessage = msgbox('Generating design! Please wait...');
    
    % Calling the design code with all inputted parameters
    DesignCode(driverMass, suspensionFeelType, rackPinionRatio, jumpHeight, terrainType);
    
    % Once DesignCode has been successfully completed, close the message
    % box
    delete(generateMessage);
    
    % Once the parts optimized, output message box to the user
    msgbox('Successfully optimized! Please re-build the SolidWorks assembly');

   
    % Show the results on the GUI.
    logFile = 'Z:\2018\MCG4322A\Digital Files\BSAE-3B\Log\BSAE-3B_LOG.txt';
    fileID = fopen(logFile,'rt'); % Open the log file for reading ('r')
    fileString = char(fread(fileID)'); % Read the file into a string
    fclose(fileID); % Close the log file

    set(handles.logOutputText,'String', fileString); % Write the string into the textbox on the GUI
    set(handles.logOutputPathText,'String', logFile); % Show the path of the log file 
    set(handles.logOutputPathText,'Visible', 'on'); % Make the text box visible

end

% --- Executes on button press in closeGuiButton.
function closeGuiButton_Callback(hObject, eventdata, handles)
% hObject    handle to closeGuiButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Closes GUI and all opened message boxes that haven't been closed by the user
close all hidden 


% --- Gives out a message that the GUI should not be executed directly from
% the .fig file. The user should run the .m file instead.
function Wrong_File()
clc
h = msgbox('You cannot run the MAIN.fig file directly. Please run the program from the Main.m file directly.','Cannot run the figure...','error','modal');
uiwait(h);
disp('You must run the MAIN.m file. Not the MAIN.fig file.');
disp('To run the MAIN.m file, open it in the editor and press ');
disp('the green "PLAY" button, or press "F5" on the keyboard.');
close gcf
 
% --- Executes on slider movement.
function driverMassSlider_Callback(hObject, eventdata, handles)
% hObject    handle to driverMassSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

if(isempty(handles))
    Wrong_File();
else
    massSliderValue = round(get(hObject, 'Value'),2); % get the slider value based on its position
    set(handles.driverMassInvalidEntry, 'Visible', 'off'); % set the invalid entry box as invisible
    set(handles.driverMassText, 'String', num2str(massSliderValue)); % set the slider position value to the edit textbox
    guidata(hObject, handles); % store changes
end

% --- Executes during object creation, after setting all properties.
function driverMassSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to driverMassSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function driverMassText_Callback(hObject, eventdata, handles)
% hObject    handle to driverMassText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of driverMassText as text
%        str2double(get(hObject,'String')) returns contents of driverMassText as a double

if(isempty(handles))
    Wrong_File();
else
    % Gets the driver weight edit text box value
    massTextValue = str2double(get(hObject, 'String'));

    % Getting the minimum and maximum allowed driver mass from the slider
    minMass = get(handles.driverMassSlider, 'Min');
    maxMass = get(handles.driverMassSlider, 'Max');

    if(~isempty(massTextValue) && massTextValue >= minMass && massTextValue <= maxMass) % Checks if the mass entered is within the acceptable range
        set(handles.driverMassInvalidEntry, 'Visible', 'off'); % If the valid is acceptable, the invalid entry text box is made invisible
        set(handles.driverMassSlider, 'Value', massTextValue); % If conditions are met, the slider will be updated 
    else
        set(handles.driverMassInvalidEntry, 'Visible', 'on'); % Sets the invalid entry text box to visible
        set(handles.driverMassInvalidEntry, 'String', 'Invalid Entry'); % Writes to the invalid entry text box 
    end
end

guidata(hObject, handles); % Stores changes


% --- Executes during object creation, after setting all properties.
function driverMassText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to driverMassText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function jumpHeightSlider_Callback(hObject, eventdata, handles)
% hObject    handle to jumpHeightSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

if(isempty(handles))
    Wrong_File();
else
    jumpHeightSliderValue = round(get(hObject, 'Value'),3); % Get the slider value based on its position
    set(handles.jumpHeightInvalidEntry, 'Visible', 'off');  % Set the invalid entry box as invisible
    set(handles.jumpHeightText, 'String', num2str(jumpHeightSliderValue)); % Set the slider position value to the edit textbox 
end

guidata(hObject, handles); % Store changes

% --- Executes during object creation, after setting all properties.
function jumpHeightSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jumpHeightSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function jumpHeightText_Callback(hObject, eventdata, handles)
% hObject    handle to jumpHeightText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jumpHeightText as text
%        str2double(get(hObject,'String')) returns contents of jumpHeightText as a double

if(isempty(handles))
    Wrong_File();
else
    % Gets the jump height edit text box value
    jumpHeightTextValue = str2double(get(hObject, 'String'));

    % Getting the minimum and maximum allowed jump height from the slider
    minJumpHeight = get(handles.jumpHeightSlider, 'Min');
    maxJumpHeight = get(handles.jumpHeightSlider, 'Max');

    if(~isempty(jumpHeightTextValue) && jumpHeightTextValue >= minJumpHeight && jumpHeightTextValue <= maxJumpHeight) % Checks if the jump height entered is within the acceptable range
        set(handles.jumpHeightInvalidEntry, 'Visible', 'off'); % If the valid is acceptable, the invalid entry text box is made invisible
        set(handles.jumpHeightSlider, 'Value', jumpHeightTextValue); % If conditions are met, the slider will be updated 
    else
        set(handles.jumpHeightInvalidEntry, 'Visible', 'on'); % Sets the invalid entry text box to visible
        set(handles.jumpHeightInvalidEntry, 'String', 'Invalid Entry'); % Writes to the invalid entry text box
    end
end

guidata(hObject, handles); % Stores changes


% --- Executes during object creation, after setting all properties.
function jumpHeightText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jumpHeightText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function logOutputText_Callback(hObject, eventdata, handles)
% hObject    handle to logOutputText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of logOutputText as text
%        str2double(get(hObject,'String')) returns contents of logOutputText as a double


% --- Executes during object creation, after setting all properties.
function logOutputText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logOutputText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
