function Swet = Swet(nacelle,fuselage,wing,tail)

%% Fuselage
fradius = fuselage.diameter/2;
fFore = fuselage.foreLength;
fMid = fuselage.midLength;
fRear = fuselage.aftLength;
snose = 2*pi*(((fFore*fradius)^1.6+(fFore*fradius)^1.6+(fradius^2)^1.6)/3)^(1/1.6);
smid = pi*fuselage.diameter*fMid;
srear = pi*fradius*(fradius+fRear);

sFuselage = snose+smid+srear;

%% Wings
wingstart = fuselage.diameter/2;
wingchord = wing.rootChord - (wing.rootChord - wing.tipChord)/wing.semiSpan*2 * wingstart;
areablocked = wingstart*(wing.rootChord+wingchord)/2;
sWings = 2.05*(wing.Sref-areablocked*2);

%% Tailplane
svTail = tail.area*2.05; % From Errikos excel
shTail = tail.area*2.05; % From Errikos excel

%% Nacelle
nacellel = nacelle.length;
nacelled = nacelle.diameter;

sNacelle = (pi*nacelled*nacellel);

%% External Fuel Tanks
nacellel = nacelle.length;
nacelled = nacelle.diameter;

sNacelle = (pi*nacelled*nacellel);

%% Total
Swet = [sNacelle;sFuselage;sWings;svTail;shTail];

end