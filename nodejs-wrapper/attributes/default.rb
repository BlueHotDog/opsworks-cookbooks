
# Override node the version
default['nodejs']['version'] = '0.12.0'
default['nodejs']['install_method'] = 'binary'

default["nodebin"]["location"] = '/usr/local/nodejs-binary'
default["nodebin"]["opsworks_location"] = '/usr/local/bin/node'