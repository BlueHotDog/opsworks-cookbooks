
# Override node the version
default['nodejs']['version'] = '0.12.0'
default['nodejs']['install_method'] = 'binary'

default['nodebin']['location'] = '/usr/local/nodejs-binary/bin'
default['nodebin']['opsworks_location'] = '/usr/local/bin'



case node[:platform_family]
  when 'debian'
    default[:nginx][:dir] = '/etc/nginx'
    default[:nginx][:log_dir] = '/var/log/nginx'
    default[:nginx][:user] = 'www-data'
    default[:nginx][:binary] = '/usr/sbin/nginx'
    if node[:platform_version] == '14.04'
      default[:nginx][:pid_file] = '/run/nginx.pid'
    else
      default[:nginx][:pid_file] = '/var/run/nginx.pid'
    end
  when 'rhel'
    default[:nginx][:dir] = '/etc/nginx'
    default[:nginx][:log_dir] = '/var/log/nginx'
    default[:nginx][:user] = 'nginx'
    default[:nginx][:binary] = '/usr/sbin/nginx'
    default[:nginx][:pid_file] = '/var/run/nginx.pid'
  else
    Chef::Log.error 'Cannot configure nginx, platform unknown'
end

default[:nginx][:log_format] = {}

# increase if you accept large uploads
default[:nginx][:client_max_body_size] = "4m"

default[:nginx][:gzip] = "on"
default[:nginx][:gzip_static] = "on"
default[:nginx][:gzip_vary] = "on"
default[:nginx][:gzip_disable] = "MSIE [1-6].(?!.*SV1)"
default[:nginx][:gzip_http_version] = "1.0"
default[:nginx][:gzip_comp_level] = "2"
default[:nginx][:gzip_proxied] = "any"
default[:nginx][:gzip_types] = ["application/x-javascript",
                                "application/xhtml+xml",
                                "application/xml",
                                "application/xml+rss",
                                "text/css",
                                "text/javascript",
                                "text/plain",
                                "text/xml"]
# NGinx will compress "text/html" by default

default[:nginx][:keepalive] = 'on'
default[:nginx][:keepalive_timeout] = 65

default[:nginx][:worker_processes] = 10
default[:nginx][:worker_connections] = 1024
default[:nginx][:server_names_hash_bucket_size] = 64

default[:nginx][:proxy_read_timeout] = 60
default[:nginx][:proxy_send_timeout] = 60
#
# default['nginx']['repo_source'] = 'passenger'
# default['nginx']['package_name'] = 'nginx-extras'
# default['nginx']['passenger']['install_method'] = 'package'

default['nginx']['passenger']['nodejs'] = "#{default['nodebin']['opsworks_location']}/node"
default['nginx']['passenger']['install_rake'] = false