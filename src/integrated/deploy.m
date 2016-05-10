function [status]=deploy(topology_name)
% deploys a topology (system) with a blueprint provided on the testing cluster

% Authors: Pooyan Jamshidi (pooyan.jamshidi@gmail.com)
% The code is released under the FreeBSD License.
% Copyright (C) 2016 Pooyan Jamshidi, Imperial College London

global config_folder deployment_service

% retrieve the yaml file
dirpath=config_folder;
yaml_file=strcat(dirpath,config_name);
configs = ReadYaml(yaml_file);

% runs the deployment service to deploy the system with the current config
data=configs;
service_url = [deployment_service 'deploy'];
options = weboptions('MediaType','application/json');

% call the restfull api and return the status
status = webwrite(service_url,data,options);

end