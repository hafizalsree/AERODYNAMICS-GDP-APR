function component_drag = component_drag(condition, nacelle, fuselage, wing, tail)

%% Nacelle
% FF
f_nacelle = nacelle.length / nacelle.diameter;
FF_nacelle = 1 + (0.35/f_nacelle);

% Q
Q_nacelle = 1;

component_nacelle = FF_nacelle * Q_nacelle;
%% Fuselage
% FF
f_fuselage = fuselage.length / fuselage.diameter;
FF_fuselage = 1 + 60/f_fuselage^3 + f_fuselage/400;

% Q
Q_fuselage = 1;

component_fuselage = FF_fuselage * Q_fuselage;
%% Wing
% FF
FF_wing = (1 + .6/(wing.xtcMax)*wing.tc + 100*(wing.tc)^4)*(1.34*(condition.M^.18)*cosd(wing.sweep)^.28);

% Q
Q_wing = 1;

component_wing = FF_wing * Q_wing;
%% Tail
% FF
FF_tail = (1 + .6/(tail.xtcMax)*tail.tc + 100*(tail.tc)^4)*(1.34*(condition.M^.18)*cosd(tail.sweep)^.28);

% Q
Q_tail = 1;

component_tail = FF_tail * Q_tail;

component_drag = [component_nacelle;component_fuselage;component_wing;component_tail];

end