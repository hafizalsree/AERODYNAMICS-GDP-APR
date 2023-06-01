function component_drag = component_drag(condition, nacelle, fuselage, wing, vtail,htail)

%% Nacelle
% FF
f_nacelle = nacelle.length / nacelle.diameter;
FF_nacelle = 1 + (0.35/f_nacelle);

% Q
% From distance fuselage to wing tip
%  1.5000    1.4139    1.3279    1.1064    1.0418    1.0000 
Q_nacelle = 1.3; % Need to know position and geometry

component_nacelle = FF_nacelle * Q_nacelle;
%% Fuselage
% FF
f_fuselage = fuselage.length / fuselage.diameter;
FF_fuselage = 1 + 60/f_fuselage^3 + f_fuselage/400;

% Q
Q_fuselage = 1; % Never change

component_fuselage = FF_fuselage * Q_fuselage;
%% Wing
% FF
FF_wing = (1 + .6/(wing.xtcMax)*wing.tc + 100*(wing.tc)^4)*(1.34*(condition.M^.18)*cosd(wing.sweep)^.28);

% Q
Q_wing = 1.02; % 

component_wing = FF_wing * Q_wing;
%% Tail
% FF
FF_vtail = (1 + .6/(vtail.xtcMax)*vtail.tc + 100*(vtail.tc)^4)*(1.34*(condition.M^.18)*cosd(vtail.sweep)^.28);

% Q
Q_vtail = 1.05;

component_vtail = FF_vtail * Q_vtail;

% FF
FF_htail = (1 + .6/(htail.xtcMax)*htail.tc + 100*(htail.tc)^4)*(1.34*(condition.M^.18)*cosd(htail.sweep)^.28);

% Q
Q_htail = 1.05;

component_htail = FF_htail * Q_htail;

%% Total
component_drag = [component_nacelle;component_fuselage;component_wing;component_vtail;component_htail];

end