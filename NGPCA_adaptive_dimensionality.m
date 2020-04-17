close all
clear variables

%% 0.1: PREALLOCATION AND INITIALIZATION
[Parameter, units] = Init; 
repetitions = 1;
dim = 2 * ones(Parameter.N,repetitions,Parameter.T );
figure
for f = 1:repetitions
    rng(18,'twister') % Reproducability!
    [Parameter, units] = Init; 
    index = 1;
    %% MAIN LOOP
    for loop = 1:Parameter.T  
         %% 1: SET DATASET
         if loop == 1 || loop == Parameter.Change
             [Parameter, units] = set_data_distribution(Parameter,units,loop);
         end
         %% 2: DETERMINE UNIT RANKING ORDER
         [Parameter, units] = unit_ranking_order(Parameter,units);
         %% 3: UNIT ADAPTATION
         [Parameter, units,k] = unit_adaptation(Parameter,units);   
         %% 4: UNIT RESET HEURISTIC   
         if( mod(loop, Parameter.t_resetCheck) == 0)   
            [minVal, minIndex] = min( Parameter.allAges );
            if minVal < 0
              [Parameter, units] = unit_reset(Parameter,units,minIndex);
            end
         end
         for y = 1:size(dim,1)
             if units{y}.protect == 0 
                [Parameter, units] = UnitSpecificDimensionLineFitting(Parameter,units,y,loop);  
             else
                units{y}.protect = units{y}.protect - 1;
             end
         end
         %% 0.2: DRAW CURRENT NETWORK STATE
         if(Parameter.plt == 1 && loop > 0 && mod(loop, Parameter.t_show) == 0)
            [Parameter, units] = drawupdate(Parameter,units,loop);
         end
         if loop >= Parameter.Gamma
            for j = 1:Parameter.N
                currentCenter = repmat(units{j}.center,1,Parameter.N)';
                [~, closestIndex] = min(abs( currentCenter - Parameter.clusterCenter ));  
                %(:,1:units{j}.outdimension)
                dim(closestIndex,f,loop) = units{j}.outdimension;
            end
         end
         if Parameter.PlotResult == 1
             if loop == 49999 || loop == 55000 || loop == 65000 || loop == 75000 || loop == 85000 || loop == 100000
                 hold on
                 subplot(2,3,index)
                 xlabeling = ['a)'; 'b)'; 'c)'; 'd)'; 'e)'; 'f)' ];
                 [Parameter, units] = Plot_UnitAdaptation(Parameter,units,loop);
                 xlabel(num2str(xlabeling(index,:)),'Interpreter','Latex');
                 alpha(0.1)
                 index = index + 1;
             end
         end
    end 
end
if Parameter.PlotResult == 1
    export_fig  verlauf -transparent -pdf
end
%% SAVE NETWORK
if repetitions == 100
    figure
    for i = 1:4
        subplot(2,2,i)
        plot(dim(i,:,end),'*')
    end
    path = 'C:\Users\NicoMIgenda\sciebo\Fachlich\Ausarbeitung\Veröffentlichungen\adaptiveLocalDimensionalityReductionNGPCA_Migenda\Entwicklung\NGPCA\Benchmark\';
    fname = [path 'Dim_' num2str(Parameter.columns) '_Cluster_' num2str(Parameter.N) '_Length_' num2str(Parameter.T) '_Threshold_' num2str(Parameter.dimThreshold*100) '_Overlap'];
    save(fname,'dim')
end