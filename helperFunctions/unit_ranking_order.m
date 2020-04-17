function [p,units] = unit_ranking_order(p,units)
%-------------------------------------------------------------------------%
% SECOND PART OF MAIN LOOP: DETERMINE UNIT RANKING ORDER                  %
%-------------------------------------------------------------------------%
    % randomly select current input vector (stimulus)
    p.xvalue = ceil(p.rows .* rand);
    p.x = p.shape(p.xvalue, :)';
    
    % set lambdaSum and sigmaSum to zero; these variables are accumulated
    % in the following loop (required for unit reset heuristic)
    p.lambdaSum = 0;
    p.sigmaSum = 0;
    p.DtAllUnits = 0;
    % for each unit k...

    for k = 1:p.N
        
      % calculate neuron input and output (activation)
      units{k}.x_c = p.x - units{k}.center;
      units{k}.y   = units{k}.weight' * units{k}.x_c;

      % calculate distance between input and unit (for ranking)
      % In some form related to Schenck dissertation Eq. 3.9/3.10
      % It is the sum of a normalized Mahalanobis distance plus reconstruction error
      [p, units] = vconstpot(p,units,k);

      % compute sum of all lambda and sigma values (required for unit reset heuristic Part 4)
      %p.lambdaSum = p.lambdaSum + mean( units{k}.eigenvalue);  - SLOW
      p.lambdaSum = p.lambdaSum + sum(units{k}.eigenvalue) / units{k}.outdimension;
      p.sigmaSum = p.sigmaSum + units{k}.sigma;

      p.DtAllUnits = p.DtAllUnits + units{k}.Dt;
    end
    
    % every unit gets "older" with every time step
    p.allAges = p.allAges - 1;
   
    p.DtAllUnits = p.DtAllUnits / p.N;
    p.rho = (p.rho_init - p.rho_final) * p.DtAllUnits^p.phi + p.rho_final;

    % perform ranking (for the soft-competition between units)
    p.r = sortrows(p.r, 2);


