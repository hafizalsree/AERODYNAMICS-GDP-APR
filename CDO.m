function CD0 = CDO(condition,cf,component_drag,Swet)

%% Nacelle
cd_nacelle = cf(nacelle.l_nacelle,condition.M,'turbulent') * component_drag(1) * Swet(1);


%% Fuselage
cd_fuselage = cf(fuselage.l_fuselage,condition.M,'turbulent') * component_drag(2) * Swet(2);


%% Wing
cd_wing = cf(wing.meanChord,condition.M,'turbulent') * component_drag(3) * Swet(3);


%% Tail
cd_vtail = cf(vTail.meanChord,condition.M,'turbulent') * component_drag(4) * Swet(4);
cd_htail = cf(hTail.meanChord,condition.M,'turbulent') * component_drag(4) * Swet(4);


%% Total

CD0 = (cd_nacelle + cd_fuselage + cd_wing + cd_tail)/Sref;

end