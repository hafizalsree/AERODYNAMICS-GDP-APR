clear 
clc
close all

%% Flight Condition

condition.M = 0.45;
condition.WingLoading = 3332;
condition.cruisealt = 25000;
[T, a, P, rho] = atmosisa(convlength(condition.cruisealt,'ft','m'));
condition.tas = condition.M * a;
condition.rho = rho;
condition.rho0 = 1.225; % Sea level
condition.visc = 1.56e-5;

%% Wing
wing.xtcMax = .4;
wing.tc = .18;
wing.sweep = 0;
wing.meanChord = 3.59;
wing.Sref = 109;

%% Nacelle Paramters
nacelle.l_nacelle = 2.5;
nacelle.d_nacelle = 0.7;

%% Fuselage Parameters
fuselage.l_fuselage = 20;
fuselage.d_fuselage = 2.8;

%% Tail Parameters
tail.xtcMax = 0.3;
tail.tc = 0.12;
tail.sweep = 9.7;
tail.meanChord = 3;

%% CD0 Calculation
Swet=ones(4,1);
CD0 = CD0(condition,tail,fuselage,nacelle,wing,Swet);
vpa(CD0)
