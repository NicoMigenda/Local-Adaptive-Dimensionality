function [p, units] = UnitSpecificDimensionLineFitting(p,units,k,loop)

if units{k}.variance < units{k}.totalVariance * p.dimThreshold && units{k}.outdimension < p.columns
    % Add n Dimensions
    % Transform eigenvalues into log scale
    logEigenvalues = log(units{k}.eigenvalue);
    x = (1:units{k}.outdimension)';

    % Fit line through the log eigenvalues
    P = polyfit(x,logEigenvalues,1);
    % Best Fit line to predict the initial values for new dimensions
    x1 = (max(x)+1:p.columns)';
    approximatedEigenvaluesLog = P(1)*x1+P(2);

    % Transform back into normal scale
    approximatedEigenvalues = exp(approximatedEigenvaluesLog);

    addedDim = find(cumsum(abs(approximatedEigenvalues)) + units{k}.variance > units{k}.totalVariance * p.dimThreshold,1);
    if units{k}.variance + sum(abs(approximatedEigenvalues)) < units{k}.totalVariance * p.dimThreshold
        addedDim = 1;
    end     
    if addedDim + units{k}.outdimension > p.columns -1
        addedDim = p.columns - units{k}.outdimension -1;
    end

    %units{k}.weight = [units{k}.weight orth(rand(p.columns, addedDim)) ] ;
    units{k}.weight = orth([units{k}.weight rand(p.columns, addedDim) ]) ;
    units{k}.eigenvalue = [units{k}.eigenvalue; approximatedEigenvalues(1:addedDim)];
    units{k}.outdimension = units{k}.outdimension + addedDim;
    units{k}.realDim = units{k}.outdimension;
    units{k}.y = zeros(units{k}.outdimension, 1);
    units{k}.mt = [units{k}.mt;repmat(0,addedDim,1)];
    units{k}.gy = zeros(units{k}.outdimension, 1);
    units{k}.protect = p.gamma;
    fprintf( '%i: Dimension: %i \n',loop,units{k}.outdimension);
    
elseif sum(units{k}.eigenvalue(1:end-1)) > units{k}.totalVariance * p.dimThreshold && units{k}.outdimension > 2
    units{k}.outdimension = units{k}.outdimension - 1;
    units{k}.weight(:,units{k}.outdimension+1:end) = [];      
    units{k}.eigenvalue(units{k}.outdimension+1:end) = [];   
    units{k}.y = repmat(units{k}.y(1:units{k}.outdimension), 1);
    units{k}.mt = repmat(units{k}.mt(1:units{k}.outdimension), 1);
    units{k}.gy = repmat(units{k}.gy(1:units{k}.outdimension), 1);
    units{k}.protect = p.gamma;
    fprintf( '%i: Dimension: %i \n',loop,units{k}.outdimension);
end