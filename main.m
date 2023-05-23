clear 
clc
close all

%% Flight Condition

condition.M = 0.45;
condition.WingLoading = 3332;
condition.cruisealt = 25000;
[T, a, P, rho] = atmosisa(convlength(condition.cruisealt,'ft','m'));
condition.rho = rho;
condition.rho0 = 1.225; % Sea level

%% Wing
wing.xtcMax = 0;
wing.tc = 0;
wing.sweep = 0;

%% Nacelle Paramters
nacelle.l_nacelle = 0;
nacelle.d_nacelle = 0;

%% Fuselage Parameters
fuselage.l_fuselage = 0;
fuselage.d_fuselage = 0;

%% Tail Parameters
tail.xtcMax = 0;
tail.tc = 0;
tail.sweep = 0;

%% CD0 Calculation

CD0 = CDO(cf,component_drag,Swet)
