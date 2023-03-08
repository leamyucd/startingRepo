function obj = addVarsToObj(obj, vars)
% **********************************************************************************************
%% THIS function will add an arbitrary number of variables [vars] to a specified object [obj]
%
% Inputs:
%   obj:      a class instance (struct, table, some custom class)
%   vars:     an arbitrary number of variables to be added to obj
%
% Outputs:
%   obj:      same as input obj, but with each vars specified added to it
%
% Calls:      (null)
% Callers:    ParBond
% Created By: leamyucd on 08/03/2023 for CCML
% **********************************************************************************************
%% Input Validation & Setup
arguments; obj = struct; end
arguments (Repeating); vars; end

% get # of input vars
nVars = numel(vars);

%% Main Function
% iterate across each var, and add it to obj
for i = 1:nVars
    % get ith var input name
    inputNameCurr = inputname(i + 1);
    
    % add ith var to obj as inputNameCurr field name
    obj.(inputNameCurr) = vars{i};
end
