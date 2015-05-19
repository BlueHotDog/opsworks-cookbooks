#
# Cookbook Name:: pm2
# Recipe:: default

# Constants
PM2_VERSION = node['pm2']['version']

# Install npm 0.12
# include_recipe 'pm2::nodejs'


node['deploy'].each do |application, deploy|
  if deploy[:application_type] != 'nodejs'
    Chef::Log.debug("Skipping deploy::nodejs-restart for application #{application} as it is not a node.js app")
    next
  end

  execute "npm start" do
    cwd "#{deploy['deploy_to']}/current/"
    command "npm start"
  end
end
