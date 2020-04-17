function [p,units] =set_data_distribution(p,units,loop)
%-------------------------------------------------------------------------%
% FIRST PART OF MAIN LOOP: SET AND PLOT DATA DISTRIBUTION                 %
%-------------------------------------------------------------------------%
% exchange data distribution
    % plot data and show initial title
    if loop == p.Change
      load benchmark_dataset_overlap
      p.shape = p.secondDataset;
      p.clusterCenter = clusterCenter;
      p.colorVector = colorVector;
      [p.rows, p.columns2] = size(p.shape);
      if(p.columns2 ~= p.columns)
        error('Data dimensionality has to be the same for D1 and D2.');
      end
    end
    if p.plt == 1
        figure;
        if p.Plot3D == 0
            plot(p.shape(:,1), p.shape(:,2), 'c.');
        else
            scatter3(p.shape(:,1),p.shape(:,2),p.shape(:,3),20,'filled')
        end
    hold on;
    p.ht = title( sprintf('t = %i', p.t_show) );
    xlabel('X');
    ylabel('Y');
    axis equal;
    axis manual;
    for k = 1:p.N
        %Ellipsoid graphic handle
        if p.Plot3D == 0
            units{k}.H = plot_ellipse(units{k}.weight(1:2,1:2), sqrt(abs(units{k}.eigenvalue(1:2))), units{k}.center(1:2));
        else
            units{k}.H3 = plot3_ellipse(units{k}.center(1:3), sqrt(abs(units{k}.eigenvalue(1:3))),units{k}.weight(1:2,1:2));
        end
        %Text inside the each ellipsoid
        units{k}.HT = text('Position', units{k}.center(1:2),...
                           'String', sprintf('%u', k),      ...
                           'Color', 'r',                    ...
                           'Visible', 'on');
    end
    % draw plot and initial ellipses
    drawnow;
    end


