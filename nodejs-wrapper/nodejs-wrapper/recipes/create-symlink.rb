#
# Cookbook Name:: nodejs-0.12.0-wrapper
# Recipe:: create-symlink
#
# Copyright (C) 2015 Dimitar Pavlov
#
# All rights reserved - Do Not Redistribute
#

%w(node npm).each do |name|
  link "#{node['nodebin']['opsworks_location']}/#{name}" do
    to "#{node['nodebin']['location']}/#{name}"
  end
end