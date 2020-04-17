function [p, units] = drawupdate(p,units, t)
%-------------------------------------------------------------------------%
% DRAWING FUNCTION                                                        %
%-------------------------------------------------------------------------%

for k = 1:p.N
    if p.Plot3D == 0
        delete(units{k}.H);
        units{k}.H = plot_ellipse(units{k}.weight(1:2,1:2), sqrt(abs(units{k}.eigenvalue(1:2))), units{k}.center(1:2));
        set(units{k}.HT, 'Position', units{k}.center(1:2),'Color','red' ,'String' ,sprintf('%u(%u)', k,units{k}.outdimension));
    else
        delete(units{k}.H3);
        units{k}.H3 = plot3_ellipse(units{k}.center(1:3), sqrt(abs(units{k}.eigenvalue(1:3))),units{k}.weight(1:2,1:2));
    end
end
set(p.ht, 'String', sprintf('t = %d', t));
pause(0.001)
