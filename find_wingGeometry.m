function [Sref, c_y,span_disc,quarterchord,MACpos,c_bar,span] = find_wingGeometry(AR, Sweep, Taper, Sref, discret)
%(AR, Sweep, Taper, c_bar) 

% c_Bar - meanchord
% 
span = sqrt(AR * Sref);
c_bar = Sref/span;
span_disc = [0:discret:span/2];
syms croot;
eqn = (croot+Taper*croot)*(span/2) == Sref;
croot = double(solve(eqn,croot));
c_y =  (Taper-1)*croot/(span/2).*span_disc + croot;
MACposind = find(abs(c_y-c_bar) == min(abs(c_y-c_bar)));
MACpos = c_y(MACposind);
quarterchord =  span_disc .* tand(Sweep);


% s_1 = 0.25 * AR * (1+Taper); %_1 using 1 as reference root chord length
% Sref_1 = (1 + Taper) * s_1;
% span_disc_1 = [0:0.01:s_1];
% c_y_1 = 1 - ((1-Taper)/s_1) * span_disc_1;
% c_bar_1 = 2*trapz(span_disc_1,(c_y_1).^2)/Sref_1;
% ratio = c_bar/c_bar_1; % dimensionalize using c_bar, can be changed later to root or tip chord length
% s = ratio*s_1;
% Sref = ratio * (1 + Taper) * s;
% span_disc = [0:0.01:s];
% c_y =  (1 - ((1-Taper)/s) * span_disc)*ratio;
% temp1 = (c_y - c_bar).^2;
% MACpos = find(temp1 == min(temp1));
% quarterchord =  span_disc .* tand(Sweep);
end