clear variables
close all

load Dim_32_Cluster_5_Length_50000_Threshold_80_Overlap.mat

figure
scatter(1:50000,squeeze(mean(dim(1,:,:))),3,'filled')
hold on
scatter(1:50000,squeeze(mean(dim(2,:,:))),3,'filled')
scatter(1:50000,squeeze(mean(dim(3,:,:))),3,'filled')
scatter(1:50000,squeeze(mean(dim(4,:,:))),3,'filled')
scatter(1:50000,squeeze(mean(dim(5,:,:))),3,'filled')
%ylim([1.9 3.1])
ylabel('Dimensionality $m$','Interpreter','Latex')
xlabel('Training steps $\kappa$','Interpreter','Latex')
set(gca, 'FontName', 'Times new Roman')
set(gca, 'defaultUicontrolFontName', 'Times new Roman')
set(gca, 'defaultUitableFontName', 'Times new Roman')
set(gca, 'defaultAxesFontName', 'Times new Roman')
set(gca, 'defaultTextFontName', 'Times new Roman')
set(gca, 'defaultUipanelFontName', 'Times new Roman')
legend('a)','b)','c)','d)','e)')

export_fig  Adaptionsverlauf_NoOverlap -transparent -pdf
