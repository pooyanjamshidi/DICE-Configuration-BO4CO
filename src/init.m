function init()
global exp_name domain options topology config_template config_folder save_folder deployment_service ci_service mon_service exp_budget initial_design polling_time exp_time sleep_time storm summary_folder kafka topic blueprint application storm_ui zookeeper hadoop replication
config % global parameters initialized

% read configuration parameters
yamlfile='conf/expconfig.yaml';
if isdeployed
    appRoot = ctfroot;
    copyfile(yamlfile,[appRoot '/main/conf'],'f'); % copy the local configs to the deployment
end

[params, runConfig, services, application_detail] = readConfig(yamlfile); % Read parameter settings both for the experimental runs and configuration parameters

if ~isdeployed
    application=application_detail;
    
    topology=application_detail.name;
    % init the experiment name with time stamp
    exp_name=strcat(topology,'_exp_',num2str(datenum(datetime('now')),'%bu'));
    
    config_template=runConfig.conf;
    config_folder=runConfig.confFolder;
    save_folder=runConfig.saveFolder;
    summary_folder=runConfig.summaryFolder;
    exp_budget=runConfig.numIter;
    initial_design=runConfig.initialDesign;
    polling_time=runConfig.metricPoll;
    exp_time=runConfig.expTime;
    sleep_time=runConfig.sleep_time;
    topic=runConfig.topic;
    blueprint=runConfig.blueprint;
    replication=runConfig.replication;
    
    options=params.param_options;
    domain=options2domain(options);
    
    deployment_service=services{1,1};
    ci_service=services{1,2}.URL;
    mon_service=services{1,3}.URL;
    storm=services{1,4}.URL;
    storm_ui=services{1,4};
    kafka=services{1,5}.URL;
    zookeeper=services{1,6};
    hadoop=services{1,7};
else
    setmcruserdata('application',application_detail);
    
    setmcruserdata('topology',application_detail.name);
    setmcruserdata('exp_name',strcat(application_detail.name,'_exp_',num2str(datenum(datetime('now')),'%bu')));
    
    setmcruserdata('config_template',runConfig.conf);
    setmcruserdata('config_folder',runConfig.confFolder);
    setmcruserdata('save_folder',runConfig.saveFolder);
    setmcruserdata('summary_folder',runConfig.summaryFolder);
    setmcruserdata('exp_budget',runConfig.numIter);
    setmcruserdata('initial_design',runConfig.initialDesign);
    setmcruserdata('polling_time',runConfig.metricPoll);
    setmcruserdata('exp_time',runConfig.expTime);
    setmcruserdata('sleep_time',runConfig.sleep_time);
    setmcruserdata('topic',runConfig.topic);
    setmcruserdata('blueprint',runConfig.blueprint);
    setmcruserdata('replication',runConfig.replication);

    setmcruserdata('options',params.param_options);
    setmcruserdata('domain',options2domain(params.param_options));
    
    setmcruserdata('deployment_service',services{1,1});
    setmcruserdata('ci_service',services{1,2}.URL);
    setmcruserdata('mon_service',services{1,3}.URL);
    setmcruserdata('storm',services{1,4}.URL);
    setmcruserdata('storm_ui',services{1,4});
    setmcruserdata('kafka',services{1,5}.URL);
    setmcruserdata('zookeeper',services{1,6});
    setmcruserdata('hadoop',services{1,7});
end

% setup the python path (for deployment service)
set_python_path;