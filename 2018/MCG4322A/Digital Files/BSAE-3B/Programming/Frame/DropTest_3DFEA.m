function dropTestSF = DropTest_3DFEA(thicknessPrimary, thicknessSecondary, maxForce)
   
    format long;
    
    outerDiameterPrimary = 31.75;
    outerDiameterSecondary = 31.75;
    
    % Problem characteristics
    nnode = 52;             % Number of nodes
    ndof_per_node = 6;      % Number of degrees of freedom per node
    nnode_per_element = 2;  % Number of nodes per element
    nelem = 88;             % Number of elements
    nmat = 1;               % Number of material types

    % Nodal coordinates, specifying the coordinates of each node
    Nodal_coordinates = zeros(nnode,3);
    Nodal_coordinates(1,1) = -1376.71/25.4; % x Coordinate, Node 1
    Nodal_coordinates(1,2) = 275.71/25.4;   % y Coordinate
    Nodal_coordinates(1,3) = 260.68/25.4;   % z Coordinate
    
    % The same applies for the rest of the nodes
    Nodal_coordinates(2,1) = -1354/25.4; 
    Nodal_coordinates(2,2) = 213.32/25.4;
    Nodal_coordinates(2,3) = 241.32/25.4;

    Nodal_coordinates(3,1) = -1276.36/25.4;
    Nodal_coordinates(3,2) = 0/25.4;
    Nodal_coordinates(3,3) = 175.11/25.4;

    Nodal_coordinates(4,1) = -944.78/25.4;
    Nodal_coordinates(4,2) = 275.71/25.4;
    Nodal_coordinates(4,3) = 260.68/25.4;

    Nodal_coordinates(5,1) = -944.78/25.4;
    Nodal_coordinates(5,2) = 213.32/25.4;
    Nodal_coordinates(5,3) = 241.32/25.4;

    Nodal_coordinates(6,1) = -944.78/25.4;
    Nodal_coordinates(6,2) = 0/25.4;
    Nodal_coordinates(6,3) = 175.11/25.4;

    Nodal_coordinates(7,1) = -944.78/25.4;
    Nodal_coordinates(7,2) = 275.71/25.4;
    Nodal_coordinates(7,3) = -260.68/25.4;

    Nodal_coordinates(8,1) = -944.78/25.4;
    Nodal_coordinates(8,2) = 213.32/25.4;
    Nodal_coordinates(8,3) = -241.32/25.4;

    Nodal_coordinates(9,1) = -944.78/25.4;
    Nodal_coordinates(9,2) = 0/25.4;
    Nodal_coordinates(9,3) = -175.11/25.4;

    Nodal_coordinates(10,1) = -1376.71/25.4;
    Nodal_coordinates(10,2) = 275.71/25.4;
    Nodal_coordinates(10,3) = -260.68/25.4;

    Nodal_coordinates(11,1) = -1354/25.4;
    Nodal_coordinates(11,2) = 213.32/25.4;
    Nodal_coordinates(11,3) = -241.32/25.4;

    Nodal_coordinates(12,1) = -1276.36/25.4;
    Nodal_coordinates(12,2) = 0/25.4;
    Nodal_coordinates(12,3) = -175.11/25.4;

    Nodal_coordinates(13,1) = -791.38/25.4;
    Nodal_coordinates(13,2) = 0/25.4;
    Nodal_coordinates(13,3) = 187.01/25.4;

    Nodal_coordinates(14,1) = -791.38/25.4;
    Nodal_coordinates(14,2) = 0/25.4;
    Nodal_coordinates(14,3) = -187.01/25.4;

    Nodal_coordinates(15,1) = -791.38/25.4;
    Nodal_coordinates(15,2) = 0/25.4;
    Nodal_coordinates(15,3) = 0/25.4;

    Nodal_coordinates(16,1) = -877.47/25.4;
    Nodal_coordinates(16,2) = 149.11/25.4;
    Nodal_coordinates(16,3) = 0/25.4;

    Nodal_coordinates(17,1) = -472.39/25.4;
    Nodal_coordinates(17,2) = 0/25.4;
    Nodal_coordinates(17,3) = 211.74/25.4;

    Nodal_coordinates(18,1) = -472.39/25.4;
    Nodal_coordinates(18,2) = 0/25.4;
    Nodal_coordinates(18,3) = -211.74/25.4;

    Nodal_coordinates(19,1) = -473.47/25.4;
    Nodal_coordinates(19,2) = 275.84/25.4;
    Nodal_coordinates(19,3) = 292.61/25.4;

    Nodal_coordinates(20,1) = -473.47/25.4;
    Nodal_coordinates(20,2) = 275.84/25.4;
    Nodal_coordinates(20,3) = -292.61/25.4;

    Nodal_coordinates(21,1) = -472.39/25.4;
    Nodal_coordinates(21,2) = 879.21/25.4;
    Nodal_coordinates(21,3) = 260.68/25.4;

    Nodal_coordinates(22,1) = -472.39/25.4;
    Nodal_coordinates(22,2) = 879.21/25.4;
    Nodal_coordinates(22,3) = -260.68/25.4;

    Nodal_coordinates(23,1) = -109.59/25.4;
    Nodal_coordinates(23,2) = 0/25.4;
    Nodal_coordinates(23,3) = 239.88/25.4;

    Nodal_coordinates(24,1) = -109.59/25.4;
    Nodal_coordinates(24,2) = 0/25.4;
    Nodal_coordinates(24,3) = -239.88/25.4;

    Nodal_coordinates(25,1) = 0/25.4;
    Nodal_coordinates(25,2) = 0/25.4;
    Nodal_coordinates(25,3) = 248.38/25.4;

    Nodal_coordinates(26,1) = 0/25.4;
    Nodal_coordinates(26,2) = 0/25.4;
    Nodal_coordinates(26,3) = -248.38/25.4;

    Nodal_coordinates(27,1) = 0/25.4;
    Nodal_coordinates(27,2) = 0/25.4;
    Nodal_coordinates(27,3) = -67.12/25.4;

    Nodal_coordinates(28,1) = 0/25.4;
    Nodal_coordinates(28,2) = 0/25.4;
    Nodal_coordinates(28,3) = 67.12/25.4;

    Nodal_coordinates(29,1) = 14.94/25.4;
    Nodal_coordinates(29,2) = 55.74/25.4;
    Nodal_coordinates(29,3) = -264.8/25.4;

    Nodal_coordinates(30,1) = 73.96/25.4;
    Nodal_coordinates(30,2) = 276.01/25.4;
    Nodal_coordinates(30,3) = 329.7/25.4;


    Nodal_coordinates(31,1) = 73.96/25.4;
    Nodal_coordinates(31,2) = 276.01/25.4;
    Nodal_coordinates(31,3) = -329.7/25.4;

    Nodal_coordinates(32,1) = 202.91/25.4;
    Nodal_coordinates(32,2) = 757.28/25.4;
    Nodal_coordinates(32,3) = -274.64/25.4;

    Nodal_coordinates(33,1) = 235.58/25.4;
    Nodal_coordinates(33,2) = 879.21/25.4;
    Nodal_coordinates(33,3) = 260.69/25.4;

    Nodal_coordinates(34,1) = 235.58/25.4;
    Nodal_coordinates(34,2) = 879.21/25.4;
    Nodal_coordinates(34,3) = -260.68/25.4;

    Nodal_coordinates(35,1) = 84.52/25.4;
    Nodal_coordinates(35,2) = 0/25.4;
    Nodal_coordinates(35,3) = 67.12/25.4;

    Nodal_coordinates(36,1) = 84.52/25.4;
    Nodal_coordinates(36,2) = 0/25.4;
    Nodal_coordinates(36,3) = -67.12/25.4;

    Nodal_coordinates(37,1) = 239.07/25.4;
    Nodal_coordinates(37,2) = 0/25.4;
    Nodal_coordinates(37,3) = 67.12/25.4;

    Nodal_coordinates(38,1) = 293.07/25.4;
    Nodal_coordinates(38,2) = 0/25.4;
    Nodal_coordinates(38,3) = -67.12/25.4;

    Nodal_coordinates(39,1) = 512.87/25.4;
    Nodal_coordinates(39,2) = 0/25.4;
    Nodal_coordinates(39,3) = 67.12/25.4;

    Nodal_coordinates(40,1) = 512.87/25.4;
    Nodal_coordinates(40,2) = 0/25.4;
    Nodal_coordinates(40,3) = -67.12/25.4;

    Nodal_coordinates(41,1) = 512.87/25.4;
    Nodal_coordinates(41,2) = 275.71/25.4;
    Nodal_coordinates(41,3) = 67.12/25.4;

    Nodal_coordinates(42,1) = 512.87/25.4;
    Nodal_coordinates(42,2) = 275.71/25.4;
    Nodal_coordinates(42,3) = -67.12/25.4;

    Nodal_coordinates(43,1) = -1110.57/25.4;
    Nodal_coordinates(43,2) = 0/25.4;
    Nodal_coordinates(43,3) = 175.11/25.4;

    Nodal_coordinates(44,1) = -1110.57/25.4;
    Nodal_coordinates(44,2) = 0/25.4;
    Nodal_coordinates(44,3) = -175.11/25.4;

    Nodal_coordinates(45,1) = -219.5/25.4;
    Nodal_coordinates(45,2) = 0/25.4;
    Nodal_coordinates(45,3) = 231.35/25.4;

    Nodal_coordinates(46,1) = -219.5/25.4;
    Nodal_coordinates(46,2) = 0/25.4;
    Nodal_coordinates(46,3) = -231.35/25.4;

    Nodal_coordinates(47,1) = -1302.75/25.4;
    Nodal_coordinates(47,2) = 72.49/25.4;
    Nodal_coordinates(47,3) = 197.61/25.4;

    Nodal_coordinates(48,1) = -944.78/25.4;
    Nodal_coordinates(48,2) = 72.49/25.4;
    Nodal_coordinates(48,3) = 197.61/25.4;

    Nodal_coordinates(49,1) = -1302.75/25.4;
    Nodal_coordinates(49,2) = 72.49/25.4;
    Nodal_coordinates(49,3) = -197.61/25.4;

    Nodal_coordinates(50,1) = -944.78/25.4;
    Nodal_coordinates(50,2) = 72.49/25.4;
    Nodal_coordinates(50,3) = -197.61/25.4;

    Nodal_coordinates(51,1) = -1376.71/25.4;
    Nodal_coordinates(51,2) = 275.71/25.4;
    Nodal_coordinates(51,3) = 135.68/25.4;

    Nodal_coordinates(52,1) = -944.78/25.4;
    Nodal_coordinates(52,2) = 275.71/25.4;
    Nodal_coordinates(52,3) = 135.68/25.4;

    % Connectivity table, connecting every node with an element number
    Connect_table = zeros(nelem,nnode_per_element + 1);
    Connect_table(1,1) = 1;  % Node i for element 1
    Connect_table(1,2) = 2;  % Node j for element 1
    Connect_table(1,3) = 1;  % Material flag

    Connect_table(2,1) = 2;  % Element 2
    Connect_table(2,2) = 47;
    Connect_table(2,3) = 1;

    Connect_table(3,1) = 3;
    Connect_table(3,2) = 43;
    Connect_table(3,3) = 1;

    Connect_table(4,1) = 6;
    Connect_table(4,2) = 43;
    Connect_table(4,3) = 1;

    Connect_table(5,1) = 4;
    Connect_table(5,2) = 5;
    Connect_table(5,3) = 1;

    Connect_table(6,1) = 5;
    Connect_table(6,2) = 48;
    Connect_table(6,3) = 1;

    Connect_table(7,1) = 6;
    Connect_table(7,2) = 9;
    Connect_table(7,3) = 1;

    Connect_table(8,1) = 7;
    Connect_table(8,2) = 8;
    Connect_table(8,3) = 1;

    Connect_table(9,1) = 8;
    Connect_table(9,2) = 50;
    Connect_table(9,3) = 1;

    Connect_table(10,1) = 9;
    Connect_table(10,2) = 44;
    Connect_table(10,3) = 1;

    Connect_table(11,1) = 12;
    Connect_table(11,2) = 44;
    Connect_table(11,3) = 1;

    Connect_table(12,1) = 10;
    Connect_table(12,2) = 11;
    Connect_table(12,3) = 1;

    Connect_table(13,1) = 11;
    Connect_table(13,2) = 49;
    Connect_table(13,3) = 1;

    Connect_table(14,1) = 1;
    Connect_table(14,2) = 51;
    Connect_table(14,3) = 1;

    Connect_table(15,1) = 3;
    Connect_table(15,2) = 12;
    Connect_table(15,3) = 1;

    Connect_table(16,1) = 4;
    Connect_table(16,2) = 21;
    Connect_table(16,3) = 1;

    Connect_table(17,1) = 7;
    Connect_table(17,2) = 22;
    Connect_table(17,3) = 1;


    Connect_table(18,1) = 21;
    Connect_table(18,2) = 22;
    Connect_table(18,3) = 1;

    Connect_table(19,1) = 6;
    Connect_table(19,2) = 13;
    Connect_table(19,3) = 1;

    Connect_table(20,1) = 9;
    Connect_table(20,2) = 14;
    Connect_table(20,3) = 1;

    Connect_table(21,1) = 13;
    Connect_table(21,2) = 17;
    Connect_table(21,3) = 1;

    Connect_table(22,1) = 14;
    Connect_table(22,2) = 18;
    Connect_table(22,3) = 1;

    Connect_table(23,1) = 17;
    Connect_table(23,2) = 45;
    Connect_table(23,3) = 1;

    Connect_table(24,1) = 23;
    Connect_table(24,2) = 45;
    Connect_table(24,3) = 1;

    Connect_table(25,1) = 18;
    Connect_table(25,2) = 46;
    Connect_table(25,3) = 1;

    Connect_table(26,1) = 24;
    Connect_table(26,2) = 46;
    Connect_table(26,3) = 1;

    Connect_table(27,1) = 23;
    Connect_table(27,2) = 25;
    Connect_table(27,3) = 1;


    Connect_table(28,1) = 24;
    Connect_table(28,2) = 26;
    Connect_table(28,3) = 1;

    Connect_table(29,1) = 21;
    Connect_table(29,2) = 33;
    Connect_table(29,3) = 1;

    Connect_table(30,1) = 22;
    Connect_table(30,2) = 34;
    Connect_table(30,3) = 1;



    Connect_table(31,1) = 25;
    Connect_table(31,2) = 28;
    Connect_table(31,3) = 1;

    Connect_table(32,1) = 27;
    Connect_table(32,2) = 28;
    Connect_table(32,3) = 1;

    Connect_table(33,1) = 26;
    Connect_table(33,2) = 27;
    Connect_table(33,3) = 1;

    Connect_table(34,1) = 25;
    Connect_table(34,2) = 30;
    Connect_table(34,3) = 1;

    Connect_table(35,1) = 26;
    Connect_table(35,2) = 29;
    Connect_table(35,3) = 1;

    Connect_table(36,1) = 29;
    Connect_table(36,2) = 31;
    Connect_table(36,3) = 1;

    Connect_table(37,1) = 30;
    Connect_table(37,2) = 33;
    Connect_table(37,3) = 1;


    Connect_table(38,1) = 31;
    Connect_table(38,2) = 32;
    Connect_table(38,3) = 1;

    Connect_table(39,1) = 32;
    Connect_table(39,2) = 34;
    Connect_table(39,3) = 1;

    Connect_table(40,1) = 33;
    Connect_table(40,2) = 34;
    Connect_table(40,3) = 1;

    % Secondary members

    Connect_table(41,1) = 1;
    Connect_table(41,2) = 4;
    Connect_table(41,3) = 1;

    Connect_table(42,1) = 2;
    Connect_table(42,2) = 5;
    Connect_table(42,3) = 1;

    Connect_table(43,1) = 7;
    Connect_table(43,2) = 10;
    Connect_table(43,3) = 1;

    Connect_table(44,1) = 8;
    Connect_table(44,2) = 11;
    Connect_table(44,3) = 1;

    Connect_table(45,1) = 43;
    Connect_table(45,2) = 44;
    Connect_table(45,3) = 1;

    Connect_table(46,1) = 4;
    Connect_table(46,2) = 52;
    Connect_table(46,3) = 1;

    Connect_table(47,1) = 4;
    Connect_table(47,2) = 19;
    Connect_table(47,3) = 1;


    Connect_table(48,1) = 7;
    Connect_table(48,2) = 20;
    Connect_table(48,3) = 1;

    Connect_table(49,1) = 19;
    Connect_table(49,2) = 21;
    Connect_table(49,3) = 1;

    Connect_table(50,1) = 20;
    Connect_table(50,2) = 22;
    Connect_table(50,3) = 1;

    Connect_table(51,1) = 17;
    Connect_table(51,2) = 30;
    Connect_table(51,3) = 1;

    Connect_table(52,1) = 18;
    Connect_table(52,2) = 31;
    Connect_table(52,3) = 1;

    Connect_table(53,1) = 19;
    Connect_table(53,2) = 30;
    Connect_table(53,3) = 1;

    Connect_table(54,1) = 20;
    Connect_table(54,2) = 31;
    Connect_table(54,3) = 1;

    Connect_table(55,1) = 45;
    Connect_table(55,2) = 46;
    Connect_table(55,3) = 1;

    Connect_table(56,1) = 23;
    Connect_table(56,2) = 24;
    Connect_table(56,3) = 1;

    Connect_table(57,1) = 29;
    Connect_table(57,2) = 30;
    Connect_table(57,3) = 1;


    Connect_table(58,1) = 30;
    Connect_table(58,2) = 31;
    Connect_table(58,3) = 1;

    Connect_table(59,1) = 30;
    Connect_table(59,2) = 32;
    Connect_table(59,3) = 1;

    Connect_table(60,1) = 25;
    Connect_table(60,2) = 35;
    Connect_table(60,3) = 1;

    Connect_table(61,1) = 28;
    Connect_table(61,2) = 35;
    Connect_table(61,3) = 1;

    Connect_table(62,1) = 27;
    Connect_table(62,2) = 36;
    Connect_table(62,3) = 1;

    Connect_table(63,1) = 26;
    Connect_table(63,2) = 36;
    Connect_table(63,3) = 1;

    Connect_table(64,1) = 35;
    Connect_table(64,2) = 37;
    Connect_table(64,3) = 1;

    Connect_table(65,1) = 36;
    Connect_table(65,2) = 38;
    Connect_table(65,3) = 1;

    Connect_table(66,1) = 37;
    Connect_table(66,2) = 38;
    Connect_table(66,3) = 1;

    Connect_table(67,1) = 37;
    Connect_table(67,2) = 39;
    Connect_table(67,3) = 1;

    Connect_table(68,1) = 38;
    Connect_table(68,2) = 40;
    Connect_table(68,3) = 1;

    Connect_table(69,1) = 39;
    Connect_table(69,2) = 40;
    Connect_table(69,3) = 1;

    Connect_table(70,1) = 39;
    Connect_table(70,2) = 41;
    Connect_table(70,3) = 1;

    Connect_table(71,1) = 40;
    Connect_table(71,2) = 42;
    Connect_table(71,3) = 1;

    Connect_table(72,1) = 30;
    Connect_table(72,2) = 41;
    Connect_table(72,3) = 1;

    Connect_table(73,1) = 31;
    Connect_table(73,2) = 42;
    Connect_table(73,3) = 1;

    Connect_table(74,1) = 33;
    Connect_table(74,2) = 41;
    Connect_table(74,3) = 1;

    Connect_table(75,1) = 34;
    Connect_table(75,2) = 42;
    Connect_table(75,3) = 1;

    Connect_table(76,1) = 41;
    Connect_table(76,2) = 42;
    Connect_table(76,3) = 1;

    Connect_table(77,1) = 13;
    Connect_table(77,2) = 15;
    Connect_table(77,3) = 1;

    Connect_table(78,1) = 14;
    Connect_table(78,2) = 15;
    Connect_table(78,3) = 1;

    Connect_table(79,1) = 15;
    Connect_table(79,2) = 16;
    Connect_table(79,3) = 1;

    Connect_table(80,1) = 3;
    Connect_table(80,2) = 47;
    Connect_table(80,3) = 1;

    Connect_table(81,1) = 6;
    Connect_table(81,2) = 48;
    Connect_table(81,3) = 1;

    Connect_table(82,1) = 47;
    Connect_table(82,2) = 48;
    Connect_table(82,3) = 1;

    Connect_table(83,1) = 49;
    Connect_table(83,2) = 12;
    Connect_table(83,3) = 1;

    Connect_table(84,1) = 50;
    Connect_table(84,2) = 9;
    Connect_table(84,3) = 1;

    Connect_table(85,1) = 49;
    Connect_table(85,2) = 50;
    Connect_table(85,3) = 1;

    Connect_table(86,1) = 10;
    Connect_table(86,2) = 51;
    Connect_table(86,3) = 1;

    Connect_table(87,1) = 7;
    Connect_table(87,2) = 52;
    Connect_table(87,3) = 1;

    Connect_table(88,1) = 51;
    Connect_table(88,2) = 52;
    Connect_table(88,3) = 1;


    % Elastic modulii
    Elastic_modulii = zeros(nmat,1);
    Elastic_modulii(1,1) = 29*10^6;  % psi

    %Density
    Density = zeros(nmat,1);
    Density(1,1) = 0.284 ; % lb/in^3

    %Shear Modulii
    Shear_modulii = zeros(nmat,1);
    Shear_modulii(1,1) = 11.6*10^6; % psi

    %Element outer radii
    Outerradiielementtype1 = (outerDiameterPrimary/2)/25.4; % inches
    Outerradiielementtype2 = (outerDiameterSecondary/2)/25.4; % inches

    % Element inner radii
    Innerradiielementtype1 = Outerradiielementtype1 - thicknessPrimary/25.4;
    Innerradiielementtype2 = Outerradiielementtype2 - thicknessSecondary/25.4;

    % Element moment of Inertia
    inertiaelementtype1 = (pi/4)*((Outerradiielementtype1^4) - (Innerradiielementtype1^4));
    inertiaelementtype2 = (pi/4)*((Outerradiielementtype2^4) - (Innerradiielementtype2^4));

    % Polar moment of Inertia
    polarelementype1 = (pi/2)*((Outerradiielementtype1^4) - (Innerradiielementtype1^4));
    polarelementype2 = (pi/2)*((Outerradiielementtype2^4) - (Innerradiielementtype2^4));

    % Defining the outer radius of every element
    Bar_element_outer_radii = zeros(nelem,1);
    Bar_element_outer_radii(1,1) = Outerradiielementtype1;
    Bar_element_outer_radii(2,1) = Outerradiielementtype1;
    Bar_element_outer_radii(3,1) = Outerradiielementtype1;
    Bar_element_outer_radii(4,1) = Outerradiielementtype1;
    Bar_element_outer_radii(5,1) = Outerradiielementtype1;
    Bar_element_outer_radii(6,1) = Outerradiielementtype1;
    Bar_element_outer_radii(7,1) = Outerradiielementtype1;
    Bar_element_outer_radii(8,1) = Outerradiielementtype1;
    Bar_element_outer_radii(9,1) = Outerradiielementtype1;
    Bar_element_outer_radii(10,1) = Outerradiielementtype1;
    Bar_element_outer_radii(11,1) = Outerradiielementtype1;
    Bar_element_outer_radii(12,1) = Outerradiielementtype1;
    Bar_element_outer_radii(13,1) = Outerradiielementtype1;
    Bar_element_outer_radii(14,1) = Outerradiielementtype1;
    Bar_element_outer_radii(15,1) = Outerradiielementtype1;
    Bar_element_outer_radii(16,1) = Outerradiielementtype1;
    Bar_element_outer_radii(17,1) = Outerradiielementtype1;
    Bar_element_outer_radii(18,1) = Outerradiielementtype1;
    Bar_element_outer_radii(19,1) = Outerradiielementtype1;
    Bar_element_outer_radii(20,1) = Outerradiielementtype1;
    Bar_element_outer_radii(21,1) = Outerradiielementtype1;
    Bar_element_outer_radii(22,1) = Outerradiielementtype1;
    Bar_element_outer_radii(23,1) = Outerradiielementtype1;
    Bar_element_outer_radii(24,1) = Outerradiielementtype1;
    Bar_element_outer_radii(25,1) = Outerradiielementtype1;
    Bar_element_outer_radii(26,1) = Outerradiielementtype1;
    Bar_element_outer_radii(27,1) = Outerradiielementtype1;
    Bar_element_outer_radii(28,1) = Outerradiielementtype1;
    Bar_element_outer_radii(29,1) = Outerradiielementtype1;
    Bar_element_outer_radii(30,1) = Outerradiielementtype1;
    Bar_element_outer_radii(31,1) = Outerradiielementtype1;
    Bar_element_outer_radii(32,1) = Outerradiielementtype1;
    Bar_element_outer_radii(33,1) = Outerradiielementtype1;
    Bar_element_outer_radii(34,1) = Outerradiielementtype1;
    Bar_element_outer_radii(35,1) = Outerradiielementtype1;
    Bar_element_outer_radii(36,1) = Outerradiielementtype1;
    Bar_element_outer_radii(37,1) = Outerradiielementtype1;
    Bar_element_outer_radii(38,1) = Outerradiielementtype1;
    Bar_element_outer_radii(39,1) = Outerradiielementtype1;
    Bar_element_outer_radii(40,1) = Outerradiielementtype1;
    Bar_element_outer_radii(41,1) = Outerradiielementtype2;
    Bar_element_outer_radii(42,1) = Outerradiielementtype2;
    Bar_element_outer_radii(43,1) = Outerradiielementtype2;
    Bar_element_outer_radii(44,1) = Outerradiielementtype2;
    Bar_element_outer_radii(45,1) = Outerradiielementtype2;
    Bar_element_outer_radii(46,1) = Outerradiielementtype2;
    Bar_element_outer_radii(47,1) = Outerradiielementtype2;
    Bar_element_outer_radii(48,1) = Outerradiielementtype2;
    Bar_element_outer_radii(49,1) = Outerradiielementtype2;
    Bar_element_outer_radii(50,1) = Outerradiielementtype2;
    Bar_element_outer_radii(51,1) = Outerradiielementtype2;
    Bar_element_outer_radii(52,1) = Outerradiielementtype2;
    Bar_element_outer_radii(53,1) = Outerradiielementtype2;
    Bar_element_outer_radii(54,1) = Outerradiielementtype2;
    Bar_element_outer_radii(55,1) = Outerradiielementtype2;
    Bar_element_outer_radii(56,1) = Outerradiielementtype2;
    Bar_element_outer_radii(57,1) = Outerradiielementtype2;
    Bar_element_outer_radii(58,1) = Outerradiielementtype2;
    Bar_element_outer_radii(59,1) = Outerradiielementtype2;
    Bar_element_outer_radii(60,1) = Outerradiielementtype2;
    Bar_element_outer_radii(61,1) = Outerradiielementtype2;
    Bar_element_outer_radii(62,1) = Outerradiielementtype2;
    Bar_element_outer_radii(63,1) = Outerradiielementtype2;
    Bar_element_outer_radii(64,1) = Outerradiielementtype2;
    Bar_element_outer_radii(65,1) = Outerradiielementtype2;
    Bar_element_outer_radii(66,1) = Outerradiielementtype2;
    Bar_element_outer_radii(67,1) = Outerradiielementtype2;
    Bar_element_outer_radii(68,1) = Outerradiielementtype2;
    Bar_element_outer_radii(69,1) = Outerradiielementtype2;
    Bar_element_outer_radii(70,1) = Outerradiielementtype2;
    Bar_element_outer_radii(71,1) = Outerradiielementtype2;
    Bar_element_outer_radii(72,1) = Outerradiielementtype2;
    Bar_element_outer_radii(73,1) = Outerradiielementtype2;
    Bar_element_outer_radii(74,1) = Outerradiielementtype2;
    Bar_element_outer_radii(75,1) = Outerradiielementtype2;
    Bar_element_outer_radii(76,1) = Outerradiielementtype2;
    Bar_element_outer_radii(77,1) = Outerradiielementtype2;
    Bar_element_outer_radii(78,1) = Outerradiielementtype2;
    Bar_element_outer_radii(79,1) = Outerradiielementtype2;
    Bar_element_outer_radii(80,1) = Outerradiielementtype1;
    Bar_element_outer_radii(81,1) = Outerradiielementtype1;
    Bar_element_outer_radii(82,1) = Outerradiielementtype2;
    Bar_element_outer_radii(83,1) = Outerradiielementtype1;
    Bar_element_outer_radii(84,1) = Outerradiielementtype1;
    Bar_element_outer_radii(85,1) = Outerradiielementtype2;
    Bar_element_outer_radii(86,1) = Outerradiielementtype1;
    Bar_element_outer_radii(87,1) = Outerradiielementtype2;
    Bar_element_outer_radii(88,1) = Outerradiielementtype2;


    % Defining the inner radius of every element
    Bar_element_inner_radii = zeros(nelem,1);
    Bar_element_inner_radii(1,1) = Innerradiielementtype1 ;
    Bar_element_inner_radii(2,1) = Innerradiielementtype1;
    Bar_element_inner_radii(3,1) = Innerradiielementtype1;
    Bar_element_inner_radii(4,1) = Innerradiielementtype1;
    Bar_element_inner_radii(5,1) = Innerradiielementtype1;
    Bar_element_inner_radii(6,1) = Innerradiielementtype1;
    Bar_element_inner_radii(7,1) = Innerradiielementtype1;
    Bar_element_inner_radii(8,1) = Innerradiielementtype1;
    Bar_element_inner_radii(9,1) = Innerradiielementtype1;
    Bar_element_inner_radii(10,1) = Innerradiielementtype1;
    Bar_element_inner_radii(11,1) = Innerradiielementtype1;
    Bar_element_inner_radii(12,1) = Innerradiielementtype1;
    Bar_element_inner_radii(13,1) = Innerradiielementtype1;
    Bar_element_inner_radii(14,1) = Innerradiielementtype1;
    Bar_element_inner_radii(15,1) = Innerradiielementtype1;
    Bar_element_inner_radii(16,1) = Innerradiielementtype1;
    Bar_element_inner_radii(17,1) = Innerradiielementtype1;
    Bar_element_inner_radii(18,1) = Innerradiielementtype1;
    Bar_element_inner_radii(19,1) = Innerradiielementtype1;
    Bar_element_inner_radii(20,1) = Innerradiielementtype1;
    Bar_element_inner_radii(21,1) = Innerradiielementtype1;
    Bar_element_inner_radii(22,1) = Innerradiielementtype1;
    Bar_element_inner_radii(23,1) = Innerradiielementtype1;
    Bar_element_inner_radii(24,1) = Innerradiielementtype1;
    Bar_element_inner_radii(25,1) = Innerradiielementtype1;
    Bar_element_inner_radii(26,1) = Innerradiielementtype1;
    Bar_element_inner_radii(27,1) = Innerradiielementtype1;
    Bar_element_inner_radii(28,1) = Innerradiielementtype1;
    Bar_element_inner_radii(29,1) = Innerradiielementtype1;
    Bar_element_inner_radii(30,1) = Innerradiielementtype1;
    Bar_element_inner_radii(31,1) = Innerradiielementtype1;
    Bar_element_inner_radii(32,1) = Innerradiielementtype1;
    Bar_element_inner_radii(33,1) = Innerradiielementtype1;
    Bar_element_inner_radii(34,1) = Innerradiielementtype1;
    Bar_element_inner_radii(35,1) = Innerradiielementtype1;
    Bar_element_inner_radii(36,1) = Innerradiielementtype1;
    Bar_element_inner_radii(37,1) = Innerradiielementtype1;
    Bar_element_inner_radii(38,1) = Innerradiielementtype1;
    Bar_element_inner_radii(39,1) = Innerradiielementtype1;
    Bar_element_inner_radii(40,1) = Innerradiielementtype1;
    Bar_element_inner_radii(41,1) = Innerradiielementtype2;
    Bar_element_inner_radii(42,1) = Innerradiielementtype2;
    Bar_element_inner_radii(43,1) = Innerradiielementtype2;
    Bar_element_inner_radii(44,1) = Innerradiielementtype2;
    Bar_element_inner_radii(45,1) = Innerradiielementtype2;
    Bar_element_inner_radii(46,1) = Innerradiielementtype2;
    Bar_element_inner_radii(47,1) = Innerradiielementtype2;
    Bar_element_inner_radii(48,1) = Innerradiielementtype2;
    Bar_element_inner_radii(49,1) = Innerradiielementtype2;
    Bar_element_inner_radii(50,1) = Innerradiielementtype2;
    Bar_element_inner_radii(51,1) = Innerradiielementtype2;
    Bar_element_inner_radii(52,1) = Innerradiielementtype2;
    Bar_element_inner_radii(53,1) = Innerradiielementtype2;
    Bar_element_inner_radii(54,1) = Innerradiielementtype2;
    Bar_element_inner_radii(55,1) = Innerradiielementtype2;
    Bar_element_inner_radii(56,1) = Innerradiielementtype2;
    Bar_element_inner_radii(57,1) = Innerradiielementtype2;
    Bar_element_inner_radii(58,1) = Innerradiielementtype2;
    Bar_element_inner_radii(59,1) = Innerradiielementtype2;
    Bar_element_inner_radii(60,1) = Innerradiielementtype2;
    Bar_element_inner_radii(61,1) = Innerradiielementtype2;
    Bar_element_inner_radii(62,1) = Innerradiielementtype2;
    Bar_element_inner_radii(63,1) = Innerradiielementtype2;
    Bar_element_inner_radii(64,1) = Innerradiielementtype2;
    Bar_element_inner_radii(65,1) = Innerradiielementtype2;
    Bar_element_inner_radii(66,1) = Innerradiielementtype2;
    Bar_element_inner_radii(67,1) = Innerradiielementtype2;
    Bar_element_inner_radii(68,1) = Innerradiielementtype2;
    Bar_element_inner_radii(69,1) = Innerradiielementtype2;
    Bar_element_inner_radii(70,1) = Innerradiielementtype2;
    Bar_element_inner_radii(71,1) = Innerradiielementtype2;
    Bar_element_inner_radii(72,1) = Innerradiielementtype2;
    Bar_element_inner_radii(73,1) = Innerradiielementtype2;
    Bar_element_inner_radii(74,1) = Innerradiielementtype2;
    Bar_element_inner_radii(75,1) = Innerradiielementtype2;
    Bar_element_inner_radii(76,1) = Innerradiielementtype2;
    Bar_element_inner_radii(77,1) = Innerradiielementtype2;
    Bar_element_inner_radii(78,1) = Innerradiielementtype2;
    Bar_element_inner_radii(79,1) = Innerradiielementtype2;
    Bar_element_inner_radii(80,1) = Innerradiielementtype1;
    Bar_element_inner_radii(81,1) = Innerradiielementtype1;
    Bar_element_inner_radii(82,1) = Innerradiielementtype2;
    Bar_element_inner_radii(83,1) = Innerradiielementtype1;
    Bar_element_inner_radii(84,1) = Innerradiielementtype1;
    Bar_element_inner_radii(85,1) = Innerradiielementtype2;
    Bar_element_inner_radii(86,1) = Innerradiielementtype1;
    Bar_element_inner_radii(87,1) = Innerradiielementtype2;
    Bar_element_inner_radii(88,1) = Innerradiielementtype2;
    
    % Defining the moment of inertia of every element
    Bar_element_inertia = zeros(nelem,1);
    Bar_element_inertia(1,1) = inertiaelementtype1 ;
    Bar_element_inertia(2,1) = inertiaelementtype1;
    Bar_element_inertia(3,1) = inertiaelementtype1;
    Bar_element_inertia(4,1) = inertiaelementtype1;
    Bar_element_inertia(5,1) = inertiaelementtype1;
    Bar_element_inertia(6,1) = inertiaelementtype1;
    Bar_element_inertia(7,1) = inertiaelementtype1;
    Bar_element_inertia(8,1) = inertiaelementtype1;
    Bar_element_inertia(9,1) = inertiaelementtype1;
    Bar_element_inertia(10,1) =inertiaelementtype1;
    Bar_element_inertia(11,1) = inertiaelementtype1;
    Bar_element_inertia(12,1) = inertiaelementtype1;
    Bar_element_inertia(13,1) = inertiaelementtype1;
    Bar_element_inertia(14,1) = inertiaelementtype1;
    Bar_element_inertia(15,1) = inertiaelementtype1;
    Bar_element_inertia(16,1) = inertiaelementtype1;
    Bar_element_inertia(17,1) = inertiaelementtype1;
    Bar_element_inertia(18,1) = inertiaelementtype1;
    Bar_element_inertia(19,1) = inertiaelementtype1;
    Bar_element_inertia(20,1) = inertiaelementtype1;
    Bar_element_inertia(21,1) = inertiaelementtype1;
    Bar_element_inertia(22,1) = inertiaelementtype1;
    Bar_element_inertia(23,1) = inertiaelementtype1;
    Bar_element_inertia(24,1) = inertiaelementtype1;
    Bar_element_inertia(25,1) = inertiaelementtype1;
    Bar_element_inertia(26,1) = inertiaelementtype1;
    Bar_element_inertia(27,1) = inertiaelementtype1;
    Bar_element_inertia(28,1) = inertiaelementtype1;
    Bar_element_inertia(29,1) = inertiaelementtype1;
    Bar_element_inertia(30,1) = inertiaelementtype1;
    Bar_element_inertia(31,1) = inertiaelementtype1;
    Bar_element_inertia(32,1) = inertiaelementtype1;
    Bar_element_inertia(33,1) = inertiaelementtype1;
    Bar_element_inertia(34,1) = inertiaelementtype1;
    Bar_element_inertia(35,1) = inertiaelementtype1;
    Bar_element_inertia(36,1) = inertiaelementtype1;
    Bar_element_inertia(37,1) = inertiaelementtype1;
    Bar_element_inertia(38,1) = inertiaelementtype1;
    Bar_element_inertia(39,1) = inertiaelementtype1;
    Bar_element_inertia(40,1) = inertiaelementtype1;
    Bar_element_inertia(41,1) = inertiaelementtype2;
    Bar_element_inertia(42,1) = inertiaelementtype2;
    Bar_element_inertia(43,1) = inertiaelementtype2;
    Bar_element_inertia(44,1) = inertiaelementtype2;
    Bar_element_inertia(45,1) = inertiaelementtype2;
    Bar_element_inertia(46,1) = inertiaelementtype2;
    Bar_element_inertia(47,1) = inertiaelementtype2;
    Bar_element_inertia(48,1) = inertiaelementtype2;
    Bar_element_inertia(49,1) = inertiaelementtype2;
    Bar_element_inertia(50,1) = inertiaelementtype2;
    Bar_element_inertia(51,1) = inertiaelementtype2;
    Bar_element_inertia(52,1) = inertiaelementtype2;
    Bar_element_inertia(53,1) = inertiaelementtype2;
    Bar_element_inertia(54,1) = inertiaelementtype2;
    Bar_element_inertia(55,1) = inertiaelementtype2;
    Bar_element_inertia(56,1) = inertiaelementtype2;
    Bar_element_inertia(57,1) = inertiaelementtype2;
    Bar_element_inertia(58,1) = inertiaelementtype2;
    Bar_element_inertia(59,1) = inertiaelementtype2;
    Bar_element_inertia(60,1) = inertiaelementtype2;
    Bar_element_inertia(61,1) = inertiaelementtype2;
    Bar_element_inertia(62,1) = inertiaelementtype2;
    Bar_element_inertia(63,1) = inertiaelementtype2;
    Bar_element_inertia(64,1) = inertiaelementtype2;
    Bar_element_inertia(65,1) = inertiaelementtype2;
    Bar_element_inertia(66,1) = inertiaelementtype2;
    Bar_element_inertia(67,1) = inertiaelementtype2;
    Bar_element_inertia(68,1) = inertiaelementtype2;
    Bar_element_inertia(69,1) = inertiaelementtype2;
    Bar_element_inertia(70,1) = inertiaelementtype2;
    Bar_element_inertia(71,1) = inertiaelementtype2;
    Bar_element_inertia(72,1) = inertiaelementtype2;
    Bar_element_inertia(73,1) = inertiaelementtype2;
    Bar_element_inertia(74,1) = inertiaelementtype2;
    Bar_element_inertia(75,1) = inertiaelementtype2;
    Bar_element_inertia(76,1) = inertiaelementtype2;
    Bar_element_inertia(77,1) = inertiaelementtype2;
    Bar_element_inertia(78,1) = inertiaelementtype2;
    Bar_element_inertia(79,1) = inertiaelementtype2;
    Bar_element_inertia(80,1) =inertiaelementtype1;
    Bar_element_inertia(81,1) = inertiaelementtype1;
    Bar_element_inertia(82,1) = inertiaelementtype2;
    Bar_element_inertia(83,1) = inertiaelementtype1;
    Bar_element_inertia(84,1) = inertiaelementtype1;
    Bar_element_inertia(85,1) = inertiaelementtype2;
    Bar_element_inertia(86,1) = inertiaelementtype1;
    Bar_element_inertia(87,1) = inertiaelementtype2;
    Bar_element_inertia(88,1) = inertiaelementtype2;
    % Defining the polar moment of inertia of every element
    Bar_polar_element_inertia = zeros(nelem,1);
    Bar_polar_element_inertia(1,1) = polarelementype1 ;
    Bar_polar_element_inertia(2,1) = polarelementype1;
    Bar_polar_element_inertia(3,1) = polarelementype1;
    Bar_polar_element_inertia(4,1) = polarelementype1;
    Bar_polar_element_inertia(5,1) = polarelementype1;
    Bar_polar_element_inertia(6,1) = polarelementype1;
    Bar_polar_element_inertia(7,1) = polarelementype1;
    Bar_polar_element_inertia(8,1) = polarelementype1;
    Bar_polar_element_inertia(9,1) = polarelementype1;
    Bar_polar_element_inertia(10,1) =polarelementype1;
    Bar_polar_element_inertia(11,1) = polarelementype1;
    Bar_polar_element_inertia(12,1) = polarelementype1;
    Bar_polar_element_inertia(13,1) = polarelementype1;
    Bar_polar_element_inertia(14,1) = polarelementype1;
    Bar_polar_element_inertia(15,1) = polarelementype1;
    Bar_polar_element_inertia(16,1) = polarelementype1;
    Bar_polar_element_inertia(17,1) = polarelementype1;
    Bar_polar_element_inertia(18,1) = polarelementype1;
    Bar_polar_element_inertia(19,1) = polarelementype1;
    Bar_polar_element_inertia(20,1) = polarelementype1;
    Bar_polar_element_inertia(21,1) = polarelementype1;
    Bar_polar_element_inertia(22,1) = polarelementype1;
    Bar_polar_element_inertia(23,1) = polarelementype1;
    Bar_polar_element_inertia(24,1) = polarelementype1;
    Bar_polar_element_inertia(25,1) = polarelementype1;
    Bar_polar_element_inertia(26,1) = polarelementype1;
    Bar_polar_element_inertia(27,1) = polarelementype1;
    Bar_polar_element_inertia(28,1) = polarelementype1;
    Bar_polar_element_inertia(29,1) = polarelementype1;
    Bar_polar_element_inertia(30,1) = polarelementype1;
    Bar_polar_element_inertia(31,1) = polarelementype1;
    Bar_polar_element_inertia(32,1) = polarelementype1;
    Bar_polar_element_inertia(33,1) = polarelementype1;
    Bar_polar_element_inertia(34,1) = polarelementype1;
    Bar_polar_element_inertia(35,1) = polarelementype1;
    Bar_polar_element_inertia(36,1) = polarelementype1;
    Bar_polar_element_inertia(37,1) = polarelementype1;
    Bar_polar_element_inertia(38,1) = polarelementype1;
    Bar_polar_element_inertia(39,1) = polarelementype1;
    Bar_polar_element_inertia(40,1) = polarelementype1;
    Bar_polar_element_inertia(41,1) = polarelementype2;
    Bar_polar_element_inertia(42,1) = polarelementype2;
    Bar_polar_element_inertia(43,1) = polarelementype2;
    Bar_polar_element_inertia(44,1) = polarelementype2;
    Bar_polar_element_inertia(45,1) = polarelementype2;
    Bar_polar_element_inertia(46,1) = polarelementype2;
    Bar_polar_element_inertia(47,1) = polarelementype2;
    Bar_polar_element_inertia(48,1) = polarelementype2;
    Bar_polar_element_inertia(49,1) = polarelementype2;
    Bar_polar_element_inertia(50,1) = polarelementype2;
    Bar_polar_element_inertia(51,1) = polarelementype2;
    Bar_polar_element_inertia(52,1) = polarelementype2;
    Bar_polar_element_inertia(53,1) = polarelementype2;
    Bar_polar_element_inertia(54,1) = polarelementype2;
    Bar_polar_element_inertia(55,1) = polarelementype2;
    Bar_polar_element_inertia(56,1) = polarelementype2;
    Bar_polar_element_inertia(57,1) = polarelementype2;
    Bar_polar_element_inertia(58,1) = polarelementype2;
    Bar_polar_element_inertia(59,1) = polarelementype2;
    Bar_polar_element_inertia(60,1) = polarelementype2;
    Bar_polar_element_inertia(61,1) = polarelementype2;
    Bar_polar_element_inertia(62,1) = polarelementype2;
    Bar_polar_element_inertia(63,1) = polarelementype2;
    Bar_polar_element_inertia(64,1) = polarelementype2;
    Bar_polar_element_inertia(65,1) = polarelementype2;
    Bar_polar_element_inertia(66,1) = polarelementype2;
    Bar_polar_element_inertia(67,1) = polarelementype2;
    Bar_polar_element_inertia(68,1) = polarelementype2;
    Bar_polar_element_inertia(69,1) = polarelementype2;
    Bar_polar_element_inertia(70,1) = polarelementype2;
    Bar_polar_element_inertia(71,1) = polarelementype2;
    Bar_polar_element_inertia(72,1) = polarelementype2;
    Bar_polar_element_inertia(73,1) = polarelementype2;
    Bar_polar_element_inertia(74,1) = polarelementype2;
    Bar_polar_element_inertia(75,1) = polarelementype2;
    Bar_polar_element_inertia(76,1) = polarelementype2;
    Bar_polar_element_inertia(77,1) = polarelementype2;
    Bar_polar_element_inertia(78,1) = polarelementype2;
    Bar_polar_element_inertia(79,1) = polarelementype2;
    Bar_polar_element_inertia(80,1) = polarelementype1;
    Bar_polar_element_inertia(81,1) = polarelementype1;
    Bar_polar_element_inertia(82,1) = polarelementype2;
    Bar_polar_element_inertia(83,1) = polarelementype1;
    Bar_polar_element_inertia(84,1) = polarelementype1;
    Bar_polar_element_inertia(85,1) = polarelementype2;
    Bar_polar_element_inertia(86,1) = polarelementype1;
    Bar_polar_element_inertia(87,1) = polarelementype2;
    Bar_polar_element_inertia(88,1) = polarelementype2;

    % Local element stiffness matrices
    Keloc = Local_element_stiffness_matrices(Nodal_coordinates,Connect_table,Bar_element_outer_radii,Bar_element_inner_radii, Bar_element_inertia,Bar_polar_element_inertia,Elastic_modulii,Shear_modulii);

    % Rotation matrices
    R = Rotation_matrices(Nodal_coordinates,Connect_table);

    % Global element stiffness matrices
    Ke = Global_element_stiffness_matrices(Keloc,R);

    % Assemblage matrix
    Ka = Assemblage_stiffness_matrix(nnode,ndof_per_node,Connect_table,Ke);

    % Known external loads
    Fa = zeros(nnode*ndof_per_node,1);

    % Drop impact forces (in y direction) at node 21, 22, 33, 34

    Fa(122,1) = -(maxForce/4.44822)/4;
    Fa(128,1) = -(maxForce/4.44822)/4;
    Fa(194,1) = -(maxForce/4.44822)/4;
    Fa(200,1) = -(maxForce/4.44822)/4;


    % Boundary conditions, nodes 3,12,43,44,6,13,14,15, 17, 18, 45, 46, 23, 24, 25, 26, 27, 28, 35, 36, 37, 38, 39 and 40 are all fixed in all
    % Directions
    BC = zeros(nnode,ndof_per_node);
    BC(3,1:6) = 1;    % 1 means fixed dof
    BC(12,1:6) = 1;
    BC(43,1:6) = 1;
    BC(44,1:6) = 1;
    BC(6,1:6) = 1;
    BC(13,1:6) = 1;
    BC(14,1:6) = 1;
    BC(15,1:6) = 1;
    BC(17,1:6) = 1;
    BC(18,1:6) = 1;
    BC(45,1:6) = 1;
    BC(46,1:6) = 1;
    BC(23,1:6) = 1;
    BC(24,1:6) = 1;
    BC(25,1:6) = 1;
    BC(26,1:6) = 1;
    BC(27,1:6) = 1;
    BC(28,1:6) = 1;
    BC(35,1:6) = 1;
    BC(36,1:6) = 1;
    BC(37,1:6) = 1;
    BC(38,1:6) = 1;
    BC(39,1:6) = 1;
    BC(40,1:6) = 1;

    % Modifying Ka into KaSol and Fa into FaSol to get solution
    beta = max(max(Ka))*10e9;
    KaSol = Ka;
    FaSol = Fa;
    for i = 1:nnode
        for j = 1:ndof_per_node
            if BC(i,j) == 1
                KaSol((i-1)*ndof_per_node + j,(i-1)*ndof_per_node + j) = Ka((i-1)*ndof_per_node + j,(i-1)*ndof_per_node + j) + beta;
                FaSol((i-1)*ndof_per_node + j,1) = beta*0;
            end
        end
    end

    % Global displacement solution
    U = KaSol\FaSol;


    % Processing of results
    Reaction_force = [];
    Ueloc = zeros(2*ndof_per_node,nelem);
    Ue = zeros(2*ndof_per_node,nelem);
    Feloc = zeros(2*ndof_per_node,nelem);
    norm_stress_1 = zeros(nelem,1);


    Ua = U;
    Fa = Ka*Ua;
    k = 1;
    for i = 1:nnode
        for j = 1:ndof_per_node
            if BC(i,j) == 1
                Reaction_forces(k,1) = Fa((i-1)*ndof_per_node + j,1);
                k = k + 1;
            end
        end
    end
    Reaction_forces;

    A = Cross_sectional_areas_of_elements(Bar_element_outer_radii,Bar_element_inner_radii);
    L = Length_of_elements(Nodal_coordinates,Connect_table);
    E = Elastic_modulii_of_elements(Elastic_modulii,Connect_table);
    I = Moment_inertia_of_elements(Bar_element_inertia);
    G = Shear_modulii_of_elements(Shear_modulii,Connect_table);
    J = Polar_moment_inertia_of_elements(Bar_polar_element_inertia);
    for i = 1:nelem
        Rot = R(:,:,i);
        for j = 1:ndof_per_node
            Ue(j,i) = Ua((Connect_table(i,1) - 1)*ndof_per_node + j,1);
            Ue(ndof_per_node + j,i) = Ua((Connect_table(i,2) - 1)*ndof_per_node + j,1);
        end
        Ueloc(:,i) = Rot*Ue(:,i); % Local displacement vector
        Feloc(:,i) = Keloc(:,:,i)*Ueloc(:,i);   % Local force vector
        norm_stress_1(i,1) = -Feloc(1,i)/A(i,1); % Axial Stress vector
        shear_stress_y(i,1) = (2*Feloc(2,i))/A(i,1); % Shear stress in y' vector
        shear_stress_z(i,1) = (2*Feloc(3,i))/A(i,1); % Shear stress in z' vector
        Torsion_stress_x(i,1) = (Feloc(10,i)*Bar_element_outer_radii(i,1))/Bar_polar_element_inertia(i,1); % Torsional stress vector
        bending_stress_y(i,1) = ((Feloc(11,i) + Feloc(5,i))*Bar_element_outer_radii(i,1))/Bar_element_inertia(i,1); % Bending stress y vector
        bending_stress_z(i,1) = ((Feloc(12,i) + Feloc(6,i))*Bar_element_outer_radii(i,1))/Bar_element_inertia(i,1); % Bending stress z vector


    end

    % Calculating critical buckling stress vector
    for i = 1:nelem

        critical_buckling_stress(i,1) = ((pi^2)*E(i,1)*I(i,1))/A(i,1)*(L(i,1)*(L(i,1)));
    end

    [max_num,max_idx] = max(norm_stress_1*0.00689476);

    critical_buckling_chosen = critical_buckling_stress(max_idx,1);


    % Stress calculations
    tensile = min(norm_stress_1*0.00689476);
    compressive = max(norm_stress_1*0.00689476);
    shear_y = max(abs(shear_stress_y*0.00689476));
    shear_z = max(abs(shear_stress_z*0.00689476));
    torsion = max(abs(Torsion_stress_x*0.00689476));
    bending_y = max(abs(bending_stress_y*0.00689476));
    bending_z = max(abs(bending_stress_z*0.00689476));


    % Safety factor calculations
    n_tensile = abs(460/tensile);
    n_compressive = critical_buckling_chosen/compressive;
    n_shear_y = 460/shear_y;
    n_shear_z = 460/shear_z;
    n_torsion = 460/torsion;
    n_bending_y = 460/bending_y;
    n_bending_z = 460/bending_z;

    n_vector = [n_tensile;n_compressive;n_shear_y;n_shear_z;n_torsion;n_bending_y;n_bending_z];

    dropTestSF = min(n_vector);


    Ux = U(1:6:end)*25.4; % Displacement in x
    Uy = U(2:6:end)*25.4; % Displacement in y
    Uz = U(3:6:end)*25.4; % Displacement in z
    Mx = U(4:6:end)*25.4; % Rotation along x axis
    My = U(4:6:end)*25.4; % Rotation about y axis
    Mz = U(4:6:end)*25.4; % Rotation about z axis


end

% Length vector calculation
function L = Length_of_elements(Nodal_coordinates,Connect_table)
    [nelem,~] = size(Connect_table);
    L = zeros(nelem,1);
    for i = 1:nelem
        
        L(i,1) = sqrt((Nodal_coordinates(Connect_table(i,1),1) - Nodal_coordinates(Connect_table(i,2),1))^2 + (Nodal_coordinates(Connect_table(i,1),2) - Nodal_coordinates(Connect_table(i,2),2))^2 + (Nodal_coordinates(Connect_table(i,1),3) - Nodal_coordinates(Connect_table(i,2),3))^2);
    end
end

% Area vector calculation
function A = Cross_sectional_areas_of_elements(Bar_element_outer_radii, Bar_element_inner_radii);
    [nelem,~] = size(Bar_element_inner_radii);
    A = zeros(nelem,1);
    for i = 1:nelem
        A(i,1) = pi*((Bar_element_outer_radii(i,1)^2)-(Bar_element_inner_radii(i,1)^2));
    end
end

% Elastic modulii vector calculation
function E = Elastic_modulii_of_elements(Elastic_modulii,Connect_table)
    [nelem,~] = size(Connect_table);
    E = zeros(nelem,1);
   for i = 1:nelem
    
    E(i,1) = Elastic_modulii(1,1);
   end
end

% Moment of inertia vector calculation
function I = Moment_inertia_of_elements(Bar_element_inertia);
    [nelem,~] = size(Bar_element_inertia);
    I = zeros(nelem,1);
    for i = 1:nelem
            I(i,1) = Bar_element_inertia(i,1);
     end
end

% Shear modulii vector calculation
function G = Shear_modulii_of_elements(Shear_modulii,Connect_table);
    [nelem,~] = size(Connect_table);
    G = zeros(nelem,1);
   for i = 1:nelem
    
    G(i,1) = Shear_modulii(1,1);
   end 
end

% Polar moment of inertia calculation
function J = Polar_moment_inertia_of_elements(Bar_polar_element_inertia);
    [nelem,~] = size(Bar_polar_element_inertia);
    J = zeros(nelem,1);
    for i = 1:nelem
            J(i,1) = Bar_polar_element_inertia(i,1);
     end
end

% Local stiffness matrix
function Keloc = Local_element_stiffness_matrices(Nodal_coordinates,Connect_table,Bar_element_outer_radii,Bar_element_inner_radii, Bar_element_inertia,Bar_polar_element_inertia,Elastic_modulii,Shear_modulii);
    [nelem,~] = size(Connect_table);
    Keloc = zeros(12,12,nelem);
    % Cross sectional areas of elements
    A = Cross_sectional_areas_of_elements(Bar_element_outer_radii, Bar_element_inner_radii);
    % Lengths of elements
    L = Length_of_elements(Nodal_coordinates,Connect_table);
    % Elastic modulii of elements
    E = Elastic_modulii_of_elements(Elastic_modulii,Connect_table);
    % Moment of inertia of elements
    I = Moment_inertia_of_elements(Bar_element_inertia);
    % Shear modulii of elements
    G = Shear_modulii_of_elements(Shear_modulii,Connect_table);
    % Polar moment of inertia of elements
    J = Polar_moment_inertia_of_elements(Bar_polar_element_inertia); 
    for i = 1:nelem
       % First Row
        Keloc(1,1,i) = A(i,1)*E(i,1)/L(i,1);
        Keloc(1,7,i) = -A(i,1)*E(i,1)/L(i,1);        
        
        % Second Row
        Keloc(2,2,i) = 12*E(i,1)*I(i,1)/(L(i,1)*L(i,1)*L(i,1));
        Keloc(2,6,i) = 6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        Keloc(2,8,i) = -12*E(i,1)*I(i,1)/(L(i,1)*L(i,1)*L(i,1));
        Keloc(2,12,i) = 6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
   
        % Third Row
        Keloc(3,3,i) = 12*E(i,1)*I(i,1)/(L(i,1)*L(i,1)*L(i,1));
        Keloc(3,5,i) = -6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        Keloc(3,9,i) = -12*E(i,1)*I(i,1)/(L(i,1)*L(i,1)*L(i,1));
        Keloc(3,11,i) = -6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        
        % Fourth Row
        Keloc(4,4,i) = G(i,1)*J(i,1)/L(i,1);
        Keloc(4,10,i) = -G(i,1)*J(i,1)/L(i,1);
        
        % Fifth Row
        Keloc(5,3,i) = -6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        Keloc(5,5,i) = 4*E(i,1)*I(i,1)/L(i,1);
        Keloc(5,9,i) = 6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        Keloc(5,11,i) = 2*E(i,1)*I(i,1)/L(i,1); 
        
        % Sixth Row
        Keloc(6,2,i) = 6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        Keloc(6,6,i) = 4*E(i,1)*I(i,1)/L(i,1);
        Keloc(6,8,i) = -6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        Keloc(6,12,i) = 2*E(i,1)*I(i,1)/L(i,1);
        
        % Seventh Row
        Keloc(7,1,i) = -A(i,1)*E(i,1)/L(i,1);
        Keloc(7,7,i) = A(i,1)*E(i,1)/L(i,1);
        
        % Eight Row
        Keloc(8,2,i) = -12*E(i,1)*I(i,1)/(L(i,1)*L(i,1)*L(i,1));
        Keloc(8,6,i) = -6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        Keloc(8,8,i) = 12*E(i,1)*I(i,1)/(L(i,1)*L(i,1)*L(i,1));
        Keloc(8,12,i) = -6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        
        % Ninth Row
        Keloc(9,3,i) = -12*E(i,1)*I(i,1)/(L(i,1)*L(i,1)*L(i,1));
        Keloc(9,5,i) = 6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        Keloc(9,9,i) = 12*E(i,1)*I(i,1)/(L(i,1)*L(i,1)*L(i,1));
        Keloc(9,11,i) = 6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        
        % Tenth Row
        Keloc(10,4,i) = -G(i,1)*J(i,1)/L(i,1);
        Keloc(10,10,i) = G(i,1)*J(i,1)/L(i,1);
        
        % Elenventh Row
        Keloc(11,3,i) = -6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        Keloc(11,5,i) = 2*E(i,1)*I(i,1)/L(i,1);
        Keloc(11,9,i) = 6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        Keloc(11,11,i) = 4*E(i,1)*I(i,1)/L(i,1); 
        
        % Twelth Row
        Keloc(12,2,i) = 6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        Keloc(12,6,i) = 2*E(i,1)*I(i,1)/L(i,1);
        Keloc(12,8,i) = -6*E(i,1)*I(i,1)/(L(i,1)*L(i,1));
        Keloc(12,12,i) = 4*E(i,1)*I(i,1)/L(i,1);
        
        Keloc(:,:,i);
    end
end

% Rotation matrix definition
function R = Rotation_matrices(Nodal_coordinates,Connect_table)
    [nelem,~] = size(Connect_table);
    
    R = zeros(12,12,nelem);
    L = Length_of_elements(Nodal_coordinates,Connect_table);
    

    for i = 1:nelem
       
        if (Nodal_coordinates(Connect_table(i,1),1) == Nodal_coordinates(Connect_table(i,2),1) & Nodal_coordinates(Connect_table(i,1),2) == Nodal_coordinates(Connect_table(i,2),2))
           if (Nodal_coordinates(Connect_table(i,2),3) > Nodal_coordinates(Connect_table(i,1),3))
              R(1:3,1:3,i) = [0 0 1;0 1 0; -1 0 0];
           else 
               R(1:3,1:3,i) = [0 0 -1;0 1 0;1 0 0];
               
           end
        else    
        
        R(1,1,i) = (Nodal_coordinates(Connect_table(i,2),1) - Nodal_coordinates(Connect_table(i,1),1))/L(i,1);
     
        R(1,2,i) = (Nodal_coordinates(Connect_table(i,2),2) - Nodal_coordinates(Connect_table(i,1),2))/L(i,1);
     
        R(1,3,i) = (Nodal_coordinates(Connect_table(i,2),3) - Nodal_coordinates(Connect_table(i,1),3))/L(i,1);
       
     
        
      Ly = sqrt((R(1,1,i)*R(1,1,i))+(R(1,2,i)*R(1,2,i)));
     
      R(2,1,i) = -R(1,2,i)/Ly;
      R(2,2,i) = R(1,1,i)/Ly;
      R(2,3,i) = 0;
      
      R(3,1,i) = -R(1,1,i)*R(1,3,i)/Ly;
      R(3,2,i) = -R(1,2,i)*R(1,3,i)/Ly;
      R(3,3,i) = Ly;
        
        end
        
     % Defining the transformation matrix
     T3D = R(1:3,1:3,i);
     
     % Defining the other non zero values of the rotation matrix      
        R(4:6,4:6,i) = T3D;
        R(7:9,7:9,i) = T3D; 
        R(10:12,10:12,i) = T3D;
         
       R(:,:,i); 
    end
end

% Global stiffness matrix definition
function Ke = Global_element_stiffness_matrices(Keloc,R)
    [sizeKe,~,nelem] = size(Keloc);
    Ke = zeros(sizeKe,sizeKe,nelem);
    for i = 1:nelem         
        Rot = R(:,:,i);
        Ke(:,:,i) = Rot'*Keloc(:,:,i)*Rot;
    end
end

% Assemblage matrix definition
function Ka = Assemblage_stiffness_matrix(nnode,ndof_per_node,Connect_table,Ke)
    Ka = zeros(nnode*ndof_per_node,nnode*ndof_per_node);
    [~,~,nelem] = size(Ke);
    
   
    for ii = 1:nnode
        for jj = 1:nnode
            for k = 1:nelem
                if ii == Connect_table(k,1) && jj == Connect_table(k,1)
                    for i = 1:ndof_per_node
                        for j = 1:ndof_per_node
                            Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) = Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) + Ke(i,j,k);
                        end
                    end
                elseif ii == Connect_table(k,2) && jj == Connect_table(k,2)
                    for i = 1:ndof_per_node
                        for j = 1:ndof_per_node
                            Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) = Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) + Ke(i + ndof_per_node,j + ndof_per_node,k);
                        end
                    end
                elseif ii == Connect_table(k,1) && jj == Connect_table(k,2)
                    for i = 1:ndof_per_node
                        for j = 1:ndof_per_node
                            Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) = Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) + Ke(i,j + ndof_per_node,k);
                        end
                    end
                elseif ii == Connect_table(k,2) && jj == Connect_table(k,1)
                    for i = 1:ndof_per_node
                        for j = 1:ndof_per_node
                            Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) = Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) + Ke(i + ndof_per_node,j,k);
                        end
                    end
                end
            end
        end            
     end
end
