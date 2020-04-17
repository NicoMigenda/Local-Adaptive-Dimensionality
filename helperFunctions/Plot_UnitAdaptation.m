function [p,units] =Plot_UnitAdaptation(p,units,loop)
%-------------------------------------------------------------------------%
% FIRST PART OF MAIN LOOP: SET AND PLOT DATA DISTRIBUTION                 %
%-------------------------------------------------------------------------%
% exchange data distribution
    % plot data and show initial title
    hold off;
    if p.Plot3D == 0
        scatter(p.shape(:,1), p.shape(:,2),3,p.colorVector);
    else
        scatter3(p.shape(:,1),p.shape(:,2),p.shape(:,3),20,'filled')
    end
    hold on;
    p.ht = title(['$\kappa = $', num2str(loop)],'Interpreter','Latex');
    set(gca, 'FontName', 'Times new Roman')
    set(gca, 'defaultUicontrolFontName', 'Times new Roman')
    set(gca, 'defaultUitableFontName', 'Times new Roman')
    set(gca, 'defaultAxesFontName', 'Times new Roman')
    set(gca, 'defaultTextFontName', 'Times new Roman')
    set(gca, 'defaultUipanelFontName', 'Times new Roman')
    %axis equal;
    %axis manual;
    for k = 1:p.N
        %Ellipsoid graphic handle
        if p.Plot3D == 0
            units{k}.H = plot_ellipse(units{k}.weight(1:2,1:2), sqrt(abs(units{k}.eigenvalue(1:2))), units{k}.center(1:2));
        else
            units{k}.H3 = plot3_ellipse(units{k}.center(1:3), sqrt(abs(units{k}.eigenvalue(1:3))),units{k}.weight(1:2,1:2));
        end
        %Text inside the each ellipsoid
        %units{k}.HT = text('Position', units{k}.center(1:2),...
        %                   'String', sprintf('%u', k),      ...
        %                   'Color', 'r',                    ...
        %                   'Visible', 'on');
    end
    % draw plot and initial ellipses
    drawnow;


