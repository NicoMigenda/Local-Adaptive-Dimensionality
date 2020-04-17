function [p,units,k] = unit_adaptation(p,units)
%-------------------------------------------------------------------------%
% THIRD PART OF MAIN LOOP: UNIT ADAPTATION                                %
%-------------------------------------------------------------------------%

% for each rank j...
for j = 1:p.N
      % get corresponding unit index
      k = uint32(p.r(j, 1)); 
        
      %% Neural Gas update step based on Schenck dissertation Eq. (3.8)
      % calculate rank-depending exponential value h
      % ensures that not only the best-matching unit is updated, but every unit with a factor exponentially decreasing with their rank
      % (this is an important difference to the hard-clustering method K-means).
      % Für diese Zeile muss sortiert werden! soft clustering!
      h = exp((1 - j) / p.rho);
      if(h < p.expThreshold )
        break;
      end
        
      units{k}.epsilon = (p.epsilon_init - p.epsilon_final) * units{k}.Dt^p.phi + p.epsilon_final;
      % Alpha = epsilon * h (substitute for easier use)
      units{k}.alpha = units{k}.epsilon .* h;
      
      % Update the center of a unit, Eq. (3.8) Schenck dissertation (Neural Gas Step)
      units{k}.center = units{k}.center + units{k}.alpha .* units{k}.x_c;
      
      units = eforrlsa(units,k); 
      units{k}.eigenvalue = sort(units{k}.eigenvalue,'descend');
      units{k}.variance = sum(units{k}.eigenvalue);
      
      %%
      % increase adaptation counter for current unit
      units{k}.t = units{k}.t + 1;

      % orthonormalization of eigendirections
      if(mod(units{k}.t, p.t_ortho) == 0)
        % alternatively, in the OpenCL/C implementation the Gram-Schmidt
        % algorithm can be used at this point
        units{k}.weight = units{k}.weight / (chol(units{k}.weight' * units{k}.weight));
      end

      % update residual variance/spread 
      if(p.columns ~= units{k}.outdimension)
          units{k}.sigma = units{k}.sigma + units{k}.alpha * (units{k}.x_c' * units{k}.x_c - units{k}.y' * units{k}.y - units{k}.sigma);
          if units{k}.sigma < 0
             units{k}.sigma = p.logArgMinLimit;
          end
          units{k}.totalVariance = units{k}.variance + units{k}.sigma;
      else
          units{k}.totalVariance = units{k}.variance;
      end
      
      % update unit age for unit reset heuristic
      p.allAges(k) = min( p.allAges(k) + floor(h*p.allAges(k)), p.ageMax );
      
      units{k}.Dt = 0.0;
      a_lowpass = p.mu * h;
      for i = 1:units{k}.outdimension
        units{k}.mt(i) = units{k}.mt(i)*(1-a_lowpass) ...
                       + units{k}.y(i)*units{k}.y(i)/units{k}.eigenvalue(i)*a_lowpass;
        if units{k}.mt(i) > p.logArgMinLimit
          units{k}.Dt = units{k}.Dt ...
                      + min( abs(log(units{k}.mt(i))/p.log_precomp), 1.0 );
        else
          units{k}.Dt = units{k}.Dt + 1.0;
        end
      end
      units{k}.Dt = units{k}.Dt / units{k}.outdimension;
end


