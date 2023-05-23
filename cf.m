function cf = cf(condition,length,flow_state)
% Input: Re , length , M , flow_state
% Notes: This is for flat plate calculation, curved shaped needs to include
% the form factor afterwards
% Skin Friction Drag formula
% Re - Reynolds number
% Length - Length of model
% M - Mach number
% flow_state - laminar or turbulent

Re=condition.rho*condition.tas*length/condition.visc; % Calculate local Re

K=2.08*10^-5; % Smooth painted surface constant
length=convlength(length,'m','ft'); % Convert length from meter to feet

Re_cutoff=38.21*(length/K)^1.053; % Maximum operating Re
if Re>Re_cutoff % Ensure Re will not exceed Re cutoff (Re Max)
    Re=Re_cutoff;
end

% Calculate skin friction for either turbulent or laminar
if strcmp (flow_state,'turbulent')
    cf=.455/((log10(Re)^2.58)*(1+.144*condition.M^2)^.65);
elseif strcmp (flow_state,'laminar')
    cf=1.328/sqrt(Re);
end

end