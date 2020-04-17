function [Parameter,units] = Init


load benchmark_dataset
Parameter.firstDataset = data;
Parameter.clusterCenter = clusterCenter;
Parameter.colorVector = colorVector;

load benchmark_dataset_overlap
Parameter.secondDataset = data;

Parameter.Gamma = 1000;
Parameter.gamma = 500;
Parameter.tau = 0;
Parameter.sigmaMean = 0;
% number of time steps between enforced orthonormalization (on a per-unit basis)
Parameter.t_ortho = 100000;
% only adapt units above exp_thresh (0.0 = soft clustering, 1.0 = hard clustering)
Parameter.expThreshold = 1;
% number of time steps between unit reset
Parameter.t_resetCheck = 15;
% Number of ellipses
Parameter.N = 5;
% Init Dimension
Parameter.StartDim = 2;
% Dimension Threshold
Parameter.dimThreshold = 0.8;
% Number of total iterationens
Parameter.T = 100000;
Parameter.Change = Parameter.T / 2;
% Learningrate
Parameter.epsilon_init = 0.5;
Parameter.epsilon_final = 0.001;
% Neighborhood range
Parameter.rho_init = 2; % 
Parameter.rho_final = 0.01;
% initial variance
Parameter.lambda_init = 1500.0;
% Maximum Age of a cluster
Parameter.ageMax = Parameter.t_resetCheck * Parameter.N;
% plots the current state every t_show iteration steps
Parameter.t_show = 5000;
% set initial shape to work with
Parameter.shape = Parameter.firstDataset;
% number of data points and input dimension
[Parameter.rows, Parameter.columns] = size(Parameter.shape);
% 2D / 3D Plot
Parameter.Plot3D = 0;
Parameter.plt = 0;
Parameter.PlotResult = 1;

% Adaptive Lernratensteuerung fur Neural Gas Principal Component Analysis.
Parameter.mu = 0.005;
Parameter.xvalue = 0;
Parameter.x = 0;
Parameter.logArgMinLimit = 1e-323;
Parameter.phi = 2.0;
Parameter.udmLogBase = 10.0;
Parameter.log_precomp = log( Parameter.udmLogBase );
Parameter.DtAllUnits = 0 ;
Parameter.lambdaSum = 0;
Parameter.sigmaSum = 0;


%-------------------------------------------------------------------------%
% UNIT INITIALIZATION                                                     %
%-------------------------------------------------------------------------%

% init data structure for units
units = cell(Parameter.N, 1);

for k = 1:Parameter.N

    %Unit specific Output Dimension
    units{k}.outdimension = Parameter.StartDim;
    units{k}.suggestedOutdimension = Parameter.StartDim;
    units{k}.realDim = Parameter.StartDim;
    
    % init centers by choosing N data points at random 
    units{k}.center = Parameter.shape(ceil(Parameter.rows .* rand), :)';
    
    % first m principal axes (weights)
    % orhonormal (as needed by distance measure)        
    units{k}.weight = orth(rand(Parameter.columns, units{k}.outdimension));
    
    % first m eigenvalues                                
    units{k}.eigenvalue = repmat(Parameter.lambda_init, units{k}.outdimension, 1);
    
    % residual variance in the minor (d - m) eigendirections
    units{k}.sigma = Parameter.lambda_init;
    
    % deviation between input and center
    units{k}.x_c = zeros(Parameter.columns, 1);
    
    % unit output (activation) for input x_c
    units{k}.y = zeros(units{k}.outdimension, 1);
    
    % unit "age" (for unit reset heuristic)
    Parameter.allAges(k) = Parameter.ageMax;
    
    % unit matching measure
    units{k}.mt = zeros(units{k}.outdimension, 1);
    
    % unit summarized matching measure
    units{k}.Dt = 1.0;
    
    % adapt steps for this unit                       
    units{k}.t = 0;

    % global learning rate 
    units{k}.alpha = Parameter.epsilon_init;
    
    % protect
    units{k}.protect = Parameter.Gamma;
    
    % Unit variance
    units{k}.variance = 0;
    
    % Unit total variance
    units{k}.totalVariance = 0;
    
    units{k}.x_c = zeros(Parameter.StartDim,1);
   
end

% init ranking-vector
Parameter.r = zeros(Parameter.N, 2);