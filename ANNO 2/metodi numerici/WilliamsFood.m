numRaws = 5;
vegs = 1:2;
oils = 3:5;
numPeriods = 6;
capVeg = 200;
capOil = 250;
maxOnHand = 1000;
initOnHand = 500;
endOnHand = 500;
invCharge = 5;
salePrice = 150;
maxHard = 6;
minHard = 3;
hardness = [8.8 6.1 2.0 4.2 5.0];
rawPrices = [ 
    110  120  130  110  115
    130  130  110   90  115
    110  140  130  100   95
    120  110  120  120  125
    100  120  150  110  105
     90  100  140   80  135 ]';
 
prob = optimproblem('ObjectiveSense','max');
buyRaw = optimvar('buyRaw', numRaws, numPeriods, 'LowerBound', 0);
onHand = optimvar('onHand', numRaws, numPeriods, 'LowerBound', 0, 'UpperBound', maxOnHand);
useRaw = optimvar('useRaw', numRaws, numPeriods, 'LowerBound', 0);
sell = optimvar('sell', numPeriods, 1, 'LowerBound', 0);

prob.Objective = salePrice*sum(sell) - ...
    invCharge*sum(onHand,'all') - sum(rawPrices.*buyRaw,'all');
prob.Constraints.capVeg = sum(useRaw(vegs,:)) <= capVeg;
prob.Constraints.capOil = sum(useRaw(oils,:)) <= capOil;

minHardConstr = optimconstr(numPeriods,1);
maxHardConstr = optimconstr(numPeriods,1);
for t = 1:numPeriods
    minHardConstr(t) = dot(hardness,useRaw(:,t)) >= minHard*sell(t);
    maxHardConstr(t) = dot(hardness,useRaw(:,t)) <= maxHard*sell(t);
end
prob.Constraints.minHardConstr = minHardConstr;
prob.Constraints.maxHardConstr = maxHardConstr;
prob.Constraints.endInv = onHand(:,numPeriods) ==  endOnHand;
prob.Constraints.conservation = sum(useRaw) == sell';

invConstr = optimconstr(numRaws,numPeriods);
for k = 1:numRaws
    invConstr(k,1) = onHand(k,1) == initOnHand - useRaw(k,1) + buyRaw(k,1);
end
for t = 2:numPeriods
    for k = 1:numRaws
        invConstr(k,t) = onHand(k,t) == onHand(k,t-1) - useRaw(k,t) + buyRaw(k,t);
    end
end
prob.Constraints.invConstr = invConstr;
show(prob);

%% solve problem 1
options = optimoptions('linprog','Display','iter');
[sol,value,exitflag,output] = solve(prob,'Options',options);


%% solve problem 2
maxRaws = 3;
minUseRaws = 20;
delta = optimvar('delta',numRaws,numPeriods,'Type','integer','LowerBound',0,'UpperBound',1);
prob.Constraints.bigMveg = useRaw(vegs,:) <= capVeg * delta(vegs,:);
prob.Constraints.bigMoil = useRaw(oils,:) <= capOil * delta(oils,:);
prob.Constraints.minUseRaws = useRaw >= minUseRaws * delta;
%prob.Constraints.recipe1 = delta(1,:) <= delta(5,:);
%prob.Constraints.recipe2 = delta(2,:) <= delta(5,:);
prob.Constraints.recipe = delta(1,:) + delta(2,:) <= 2*delta(5,:);
prob.Constraints.maxRaws = sum(delta) <= maxRaws;

show(prob);
%options = optimoptions('linprog','Display','iter');
[sol2,value2,exitflag,output] = solve(prob);%,'Options',options);





