
# Override node the version
default['nodejs']['version'] = '0.12.0'
default['nodejs']['install_method'] = 'binary'

default['nodebin']['location'] = '/usr/local/nodejs-binary/bin'
default['nodebin']['opsworks_location'] = '/usr/local/bin'

default['nginx']['passenger']['nodejs'] = "#{default['nodebin']['opsworks_location']}/node"