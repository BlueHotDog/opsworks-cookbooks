#
# Cookbook Name:: nodejs-0.12.0-wrapper
# Recipe:: default
#
# Copyright (C) 2015 Dimitar Pavlov
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nodejs'
include_recipe 'nodejs::nodejs_from_binary'
include_recipe 'nodejs-wrapper::create-symlink'
include_recipe 'nginx::source'
include_recipe 'nginx::passenger'

node[:deploy].each do |application, deploy|
  nginx_site "#{deploy[:application]}.conf" do
    enable true
    template 'nginx_site.erb'
    variables :deploy_to => deploy[:deploy_to]
  end
end
