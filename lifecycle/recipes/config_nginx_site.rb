node['deploy'].each do |application, deploy|
  if deploy[:application_type] != 'nodejs'
    Chef::Log.debug("Skipping deploy::nodejs-restart for application #{application} as it is not a node.js app")
    next
  end

  template "#{node[:nginx][:dir]}/sites-available/#{application_name}" do
    Chef::Log.debug("Generating Nginx site template for #{application_name.inspect}")
    source params[:template]
    owner "root"
    group "root"
    mode 0644
    if params[:cookbook]
      cookbook params[:cookbook]
    end
    variables(
        :application => application,
        :application_name => application_name,
        :params => params
    )
    if File.exists?("#{node[:nginx][:dir]}/sites-enabled/#{application_name}")
      notifies :reload, "service[nginx]", :delayed
    end
  end

  file "#{node[:nginx][:dir]}/sites-enabled/default" do
    action :delete
    only_if do
      File.exists?("#{node[:nginx][:dir]}/sites-enabled/default")
    end
  end

  nginx_web_app deploy[:application] do
    docroot deploy[:absolute_document_root]
    server_name deploy[:domains].first
    server_aliases deploy[:domains][1, deploy[:domains].size] unless deploy[:domains][1, deploy[:domains].size].empty?
    rails_env deploy[:rails_env]
    mounted_at deploy[:mounted_at]
    ssl_certificate_ca deploy[:ssl_certificate_ca]
    cookbook "unicorn"
    deploy deploy
    template "nginx_unicorn_web_app.erb"
    application deploy
  end
end
