clear
clc
close all

load('airfoilDB.mat');

%% Define alpha & beta

alpha=1;
beta=10;

%% Field Type

comparedFields = {'clDes'};

%% Iterate through all airfoils and Re to find max & min

for fieldNo = 1:length(comparedFields)
    for reNo = 1:length(airfoilDB(1).reDB)
        maxValues(reNo).(comparedFields{fieldNo}) = -inf;
        minValues(reNo).(comparedFields{fieldNo}) = inf;
        for airfoilNo = 1:length(airfoilDB)
            if airfoilDB(airfoilNo).reDB(reNo).(comparedFields{fieldNo}) > maxValues(reNo).(comparedFields{fieldNo})
                maxValues(reNo).(comparedFields{fieldNo}) = airfoilDB(airfoilNo).reDB(reNo).(comparedFields{fieldNo});
                indexMax = [airfoilNo, reNo];
            end
            
            if airfoilDB(airfoilNo).reDB(reNo).(comparedFields{fieldNo}) < minValues(reNo).(comparedFields{fieldNo})
                minValues(reNo).(comparedFields{fieldNo}) = airfoilDB(airfoilNo).reDB(reNo).(comparedFields{fieldNo});
                indexMin = [airfoilNo, reNo];
            end
        end
    end
end

%% Find min, max and Calculate R for all

A = min([minValues.clDes]);
B = max([maxValues.clDes]);


for airfoilNo = 1:length(airfoilDB)
    for reNo = 1:length(airfoilDB(1).reDB)
        x = airfoilDB(airfoilNo).reDB(reNo).(comparedFields{1});
        if isempty(x)
            R(airfoilNo,reNo) = NaN;
        else
            R(airfoilNo,reNo) = (beta*(x-A)-alpha*(x-B))/(B-A);
        end
    end
end

highest_MI = max(R)
highest_MI_Airfoil = airfoilDB(find(R(:,1)==max(R))).naca
