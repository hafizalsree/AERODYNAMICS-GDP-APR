clear
clc
close all

condition.rho0 = 1.225; % Sea level
visc0 = 1.716e-5; % Constants for air
T0 = 273; % Constants for air
S_mu = 111; % Constants for air
condition.cruisealt = 25000;
condition.M = 0.45;
[T, a, P, rho] = atmosisa(convlength(condition.cruisealt,'ft','m'));
condition.tas = condition.M * a;
condition.rho = rho;
condition.visc = visc0 * (T/T0)^1.5 * (T0 + S_mu)/(T + S_mu); % Sutherland's law
condition.M = 0.45;

fuselage.diameter = 2 + .07*2;
distance_fuselage = 0;

wing.AR = 8.5; % Constant 
wing.xtcMax = .4; % Constant
wing.tc = .18; % Constant
wing.sweep = 0; % Constant 
wing.Sref = 91; % Variable
discret = 0.001;
wing.taper = 0.83;
wing.e = 0.781711714;
wing.cl = 0.7312; % cl for 3d wing
[wing.Sref, wing.chordDist,~,~,~,wing.meanChord,wing.span] = find_wingGeometry(wing.AR, wing.sweep, wing.taper, wing.Sref, discret);

for i = 1:length(wing.chordDist)-1
    wing.semiSpan(i) = wing.span/2/length(wing.chordDist);
    wing.rootChord(i) = wing.chordDist(i);
    wing.tipChord(i) = wing.chordDist(i+1);
    wing.area(i) = (wing.rootChord(i)+wing.tipChord(i))*wing.semiSpan(i)/2;
    wing.meanChord(i) = wing.area(i)/wing.semiSpan(i);

    distance_fuselage = wing.semiSpan(i) + distance_fuselage;
    wing.span_i(i) = distance_fuselage;

    if distance_fuselage > fuselage.diameter/2
        %% Swet
        sWings(i) = 2.05*wing.area(i);

        %% FF
        FF_wing = (1 + .6/(wing.xtcMax)*wing.tc + 100*(wing.tc)^4)*(1.34*(condition.M^.18)*cosd(wing.sweep)^.28);
        % Q 
        Q_wing = 1.02; %
        component_wing = FF_wing * Q_wing;

        %% CD0
        cd_winglam(i) = cf(condition,wing.meanChord(i),'laminar') * component_wing * sWings(i)/wing.Sref;
        cd_wingtur(i) = cf(condition,wing.meanChord(i),'turbulent') * component_wing * sWings(i)/wing.Sref;
        lamRatio = 0.5;
        cd_wing(i) = cd_winglam(i) * lamRatio + cd_wingtur(i) * (1-lamRatio);
    end
end

plot(wing.span_i,cd_wing)
sum(cd_wing)

