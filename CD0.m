function CD0 = CD0(condition,tail,fuselage,nacelle,wing,Swet)

FF_Q = component_drag(condition, nacelle, fuselage, wing, tail);

%% Nacelle
cd_nacelle = cf(condition,nacelle.length,'turbulent') * FF_Q(1) * Swet(1);


%% Fuselage
cd_fuselage = cf(condition,fuselage.length,'turbulent') * FF_Q(2) * Swet(2);


%% Wing
cd_wing = cf(condition,wing.meanChord,'turbulent') * FF_Q(3) * Swet(3);


%% Tail
cd_vtail = cf(condition,tail.meanChord,'turbulent') * FF_Q(4) * Swet(4);
cd_htail = cf(condition,tail.meanChord,'turbulent') * FF_Q(4) * Swet(4);


%% Total

CD0_total = (cd_nacelle + cd_fuselage + cd_wing + cd_vtail + cd_htail);%/wing.Sref;
CD0 = [cd_nacelle ; cd_fuselage ; cd_wing ; cd_vtail ; cd_htail ; CD0_total]/wing.Sref;


end