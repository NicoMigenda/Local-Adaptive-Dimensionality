%normalized mahalanobis distance
function [p,units] = vconstpot(p,units,k)
if( p.columns == units{k}.outdimension )
    p.r(k, :) = [k, units{k}.y' * (units{k}.y ./ units{k}.eigenvalue) * sqrt(prod(units{k}.eigenvalue))];
else
    %2. Formel Schenck Diss Seite 93 - Lambda Stern (Restvarianz)
    p.lambda_rest = units{k}.sigma ./ (p.columns - units{k}.outdimension);
    if( p.lambda_rest <= 0.0 )
        p.lambda_rest_vol = p.logArgMinLimit;
        fprintf( 'lambda_rest: %e\n', p.lambda_rest );
    else
        p.lambda_rest_vol = p.lambda_rest;
    end  
    % Volumenunabhängige Mahalnobisdistanz nach Gleichung 3.9 Schenck Diss
    p.r(k, :) = [k, ...
        (units{k}.y' * (units{k}.y ./ units{k}.eigenvalue)                                      ...
        + (1 ./ p.lambda_rest) * (units{k}.x_c' * units{k}.x_c - units{k}.y' * units{k}.y))     ...
        * prod(units{k}.eigenvalue)^(1/p.columns) * p.lambda_rest_vol^((p.columns-units{k}.outdimension)/p.columns)];
end


