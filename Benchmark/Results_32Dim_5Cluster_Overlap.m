clear variables
close all

load Dim_32_Cluster_5_Length_100000_Threshold_70_Overlap.mat
for i=1:5
    data70{i}.data = squeeze(dim(i,:,:));
    data70{i}.data(data70{i}.data(:,end) == 2,:) = [];
end
load Dim_32_Cluster_5_Length_100000_Threshold_80_Overlap.mat
for i=1:5
    data80{i}.data = squeeze(dim(i,:,:));
    data80{i}.data(data80{i}.data(:,end) == 2,:) = [];
end
load Dim_32_Cluster_5_Length_100000_Threshold_90_Overlap.mat
for i=1:5
    data90{i}.data = squeeze(dim(i,:,:));
    data90{i}.data(data90{i}.data(:,end) == 2,:) = [];
end
load Dim_32_Cluster_5_Length_100000_Threshold_95_Overlap.mat
for i=1:5
    data95{i}.data = squeeze(dim(i,:,:));
    data95{i}.data(data95{i}.data(:,end) == 2,:) = [];
end


lengthdata = length(data70{1}.data);
meanCluster = zeros(4,5);
stdCluster = zeros(4,5);
for i = 1:length(data70)
    meanCluster(1,i) = round(mean(data70{i}.data(:,lengthdata/4)),2);
    meanCluster(2,i) = round(mean(data70{i}.data(:,lengthdata/2)),2);
    meanCluster(3,i) = round(mean(data70{i}.data(:,lengthdata/4*3)),2); 
    meanCluster(4,i) = round(mean(data70{i}.data(:,end)),2);
    
    stdCluster(1,i) = round(std(data70{i}.data(:,lengthdata/4)),2);
    stdCluster(2,i) = round(std(data70{i}.data(:,lengthdata/2)),2);
    stdCluster(3,i) = round(std(data70{i}.data(:,lengthdata/4*3)),2);
    stdCluster(4,i) = round(std(data70{i}.data(:,end)),2);
end


varNames = {'Mean25','Std25','Mean50','Std50','Mean75','Std75','Mean','Std'};
Results70 = table(meanCluster(1,:)',stdCluster(1,:)',...
                  meanCluster(2,:)',stdCluster(2,:)',...
                  meanCluster(3,:)',stdCluster(3,:)',...
                  meanCluster(4,:)',stdCluster(4,:)',...
                  'VariableNames',varNames);
             
%------------------------------------------------------------------------------

lengthdata = length(data80{1}.data);
meanCluster = zeros(4,5);
stdCluster = zeros(4,5);
for i = 1:length(data80)
    meanCluster(1,i) = round(mean(data80{i}.data(:,lengthdata/4)),2);
    meanCluster(2,i) = round(mean(data80{i}.data(:,lengthdata/2)),2);
    meanCluster(3,i) = round(mean(data80{i}.data(:,lengthdata/4*3)),2); 
    meanCluster(4,i) = round(mean(data80{i}.data(:,end)),2);
    
    stdCluster(1,i) = round(std(data80{i}.data(:,lengthdata/4)),2);
    stdCluster(2,i) = round(std(data80{i}.data(:,lengthdata/2)),2);
    stdCluster(3,i) = round(std(data80{i}.data(:,lengthdata/4*3)),2);
    stdCluster(4,i) = round(std(data80{i}.data(:,end)),2);
end


varNames = {'Mean25','Std25','Mean50','Std50','Mean75','Std75','Mean','Std'};
Results80 = table(meanCluster(1,:)',stdCluster(1,:)',...
                  meanCluster(2,:)',stdCluster(2,:)',...
                  meanCluster(3,:)',stdCluster(3,:)',...
                  meanCluster(4,:)',stdCluster(4,:)',...
                  'VariableNames',varNames);
              
              
%------------------------------------------------------------------------------

lengthdata = length(data90{1}.data);
meanCluster = zeros(4,5);
stdCluster = zeros(4,5);
for i = 1:length(data90)
    meanCluster(1,i) = round(mean(data90{i}.data(:,lengthdata/4)),2);
    meanCluster(2,i) = round(mean(data90{i}.data(:,lengthdata/2)),2);
    meanCluster(3,i) = round(mean(data90{i}.data(:,lengthdata/4*3)),2); 
    meanCluster(4,i) = round(mean(data90{i}.data(:,end)),2);
    
    stdCluster(1,i) = round(std(data90{i}.data(:,lengthdata/4)),2);
    stdCluster(2,i) = round(std(data90{i}.data(:,lengthdata/2)),2);
    stdCluster(3,i) = round(std(data90{i}.data(:,lengthdata/4*3)),2);
    stdCluster(4,i) = round(std(data90{i}.data(:,end)),2);
end


varNames = {'Mean25','Std25','Mean50','Std50','Mean75','Std75','Mean','Std'};
Results90 = table(meanCluster(1,:)',stdCluster(1,:)',...
                  meanCluster(2,:)',stdCluster(2,:)',...
                  meanCluster(3,:)',stdCluster(3,:)',...
                  meanCluster(4,:)',stdCluster(4,:)',...
                  'VariableNames',varNames);
            
%------------------------------------------------------------------------------

lengthdata = length(data95{1}.data);
meanCluster = zeros(4,5);
stdCluster = zeros(4,5);
for i = 1:length(data95)
    meanCluster(1,i) = round(mean(data95{i}.data(:,lengthdata/4)),2);
    meanCluster(2,i) = round(mean(data95{i}.data(:,lengthdata/2)),2);
    meanCluster(3,i) = round(mean(data95{i}.data(:,lengthdata/4*3)),2); 
    meanCluster(4,i) = round(mean(data95{i}.data(:,end)),2);
    
    stdCluster(1,i) = round(std(data95{i}.data(:,lengthdata/4)),2);
    stdCluster(2,i) = round(std(data95{i}.data(:,lengthdata/2)),2);
    stdCluster(3,i) = round(std(data95{i}.data(:,lengthdata/4*3)),2);
    stdCluster(4,i) = round(std(data95{i}.data(:,end)),2);
end


varNames = {'Mean25','Std25','Mean50','Std50','Mean75','Std75','Mean','Std'};
Results95 = table(meanCluster(1,:)',stdCluster(1,:)',...
                  meanCluster(2,:)',stdCluster(2,:)',...
                  meanCluster(3,:)',stdCluster(3,:)',...
                  meanCluster(4,:)',stdCluster(4,:)',...
                  'VariableNames',varNames);