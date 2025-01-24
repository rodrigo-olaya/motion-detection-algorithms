% Define all input parameters for the main func

%uncomment below to choose file

%dirstring = 'walk';
%dirstring = 'trees';
%dirstring = 'movecam';
%dirstring = 'getout';
%dirstring = 'getin';
%dirstring = 'AShipDeck';
%dirstring = 'APossum';
%dirstring = 'ADeerBackyard';
%dirstring = 'AAnts';

dir_list = dir(dirstring);
dir_list = dir_list(~ismember({dir_list.name}, {'.', '..', '.DS_Store'}));

maxframenum = length(dir_list);
abs_diff_threshold = 35; % set this to somewhere in the middle to start testing
alpha_parameter = .3; % set in the middle to start testing
gamma_parameter = 15; %set in the middle to start testing

proj3main(dirstring, maxframenum, abs_diff_threshold, alpha_parameter, gamma_parameter);

