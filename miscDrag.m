function cdmiscDrag = miscDrag(nacelle,fuselage,wing)

%% Undercarriage

% cduc = 0.18*fuselage.uc.diameter*fuselage.uc.length/wing.Sref; % 0.18 constant wheel type A in gudmanson

%% High Lift Devices

% cdflaps = 0.0023*(wing.flap.span/wing.span)*wing.flap.deflection; % Must specific takeoff, landing or approach
% cdslats = 0.0023*(wing.slat.span/wing.span)*wing.slat.deflection; 
% cdhld = cdflaps + cdslats;

%% Windmilling Engine

sigma = 0.04 * 4; % Estimated from Gaymer for blade AR of 8 will give solidity = 0.4 x 4 blades
nacelle_area = pi*(nacelle.diameter/2)^2;
cdwmnacelle = 0.1*sigma*nacelle_area/wing.Sref; % 0.1 is for feathered prop

%% Fuselage Upsweep

% cdupsweep = 3.83*(pi*fuselage.diameter^2)*(upsweep^(2.5))/(4*wing.Sref);


%% Base Drag (rear of fuselage)


%% Total

% cdmiscDrag = cduc + cdhld + cdwnacelle + cdupsweep;
cdmiscDrag = cdwmnacelle;
% cdmiscDrag = 0;

end