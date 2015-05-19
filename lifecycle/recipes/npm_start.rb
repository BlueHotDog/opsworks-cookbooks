#
# Cookbook Name:: pm2
# Recipe:: default

# Constants
#PM2_VERSION = node['pm2']['version']

# Install npm 0.12
# include_recipe 'pm2::nodejs'


node['deploy'].each do |application, deploy|
  if deploy[:application_type] != 'nodejs'
    Chef::Log.debug("Skipping deploy::nodejs-restart for application #{application} as it is not a node.js app")
    next
  end

  command = "source #{deploy['deploy_to']}/shared/app.env && cd #{deploy['deploy_to']}/current/ && npm start"
  Chef::Log.info(OpsWorks::ShellOut.shellout("sudo su - #{node[:deploy][application][:user]} -c '#{command}' 2>&1"))

end
