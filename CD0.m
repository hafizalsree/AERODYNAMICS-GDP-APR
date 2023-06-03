function CD0 = CD0(condition,vtail,htail,fuselage,nacelle,wing,strut,Swet)

FF_Q = component_drag(condition, nacelle, fuselage, wing, vtail,htail,strut);
cdmisc = miscDrag(condition, nacelle,fuselage,wing);

%% Nacelle
cd_nacellelam = cf(condition,nacelle.length,'laminar') * FF_Q(1) * Swet(1)/wing.Sref;
cd_nacelletur = cf(condition,nacelle.length,'turbulent') * FF_Q(1) * Swet(1)/wing.Sref;
lamRatio = 0.5;
cd_nacelle = cd_nacellelam * lamRatio + cd_nacelletur * (1-lamRatio);

%% Fuselage
cd_fuselagelam = cf(condition,fuselage.length,'laminar') * FF_Q(2) * Swet(2)/wing.Sref;
cd_fuselagetur = cf(condition,fuselage.length,'turbulent') * FF_Q(2) * Swet(2)/wing.Sref;
lamRatio = fuselage.foreLength/fuselage.length;
cd_fuselage = cd_fuselagelam * lamRatio + cd_fuselagetur * (1-lamRatio);

%% Wing
cd_winglam = cf(condition,wing.meanChord,'laminar') * FF_Q(3) * Swet(3)/wing.Sref;
cd_wingtur = cf(condition,wing.meanChord,'turbulent') * FF_Q(3) * Swet(3)/wing.Sref;
lamRatio = 0.5;
cd_wing = cd_winglam * lamRatio + cd_wingtur * (1-lamRatio);


%% Horizontal Tail
cd_htaillam = cf(condition,htail.meanChord,'laminar') * FF_Q(4) * Swet(4)/wing.Sref;
cd_htailtur = cf(condition,htail.meanChord,'turbulent') * FF_Q(4) * Swet(4)/wing.Sref;
lamRatio = 0.3;
cd_htail = cd_htaillam * lamRatio + cd_htailtur * (1-lamRatio);

%% Vertical Tail
cd_vtaillam = cf(condition,vtail.meanChord,'laminar') * FF_Q(5) * Swet(5)/wing.Sref;
cd_vtailtur = cf(condition,vtail.meanChord,'turbulent') * FF_Q(5) * Swet(5)/wing.Sref;
lamRatio = 0.1;
cd_vtail = cd_vtaillam * lamRatio + cd_vtailtur * (1-lamRatio);

%% Strut
if strut.area == 0
    cd_strut = 0;
else
    cd_strutlam = cf(condition,strut.meanChord,'laminar') * FF_Q(6) * Swet(6)/wing.Sref;
    cd_struttur = cf(condition,strut.meanChord,'turbulent') * FF_Q(6) * Swet(6)/wing.Sref;
    lamRatio = 0.5;
    cd_strut = cd_strutlam * lamRatio + cd_struttur * (1-lamRatio);
end

%% Total

CD0_total = 1.02*(cd_nacelle*2 + cd_fuselage + cd_wing + cd_vtail + cd_htail + cdmisc + cd_strut);
CD0 = [cd_nacelle*2 ; cd_fuselage ; cd_wing ; cd_vtail ; cd_htail ; cd_strut ; cdmisc ; CD0_total];

end