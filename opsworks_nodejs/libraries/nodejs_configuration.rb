module OpsWorks
  module NodejsConfiguration
    def self.npm_install(app_name, app_config, app_root_path, npm_install_options)
      if File.exists?("#{app_root_path}/package.json")
        Chef::Log.info("package.json detected. Running npm #{npm_install_options}.")
        shared_path = "#{app_root_path}/../../shared"
        command = "mkdir -p #{shared_path}/node_modules/"
        Chef::Log.info(OpsWorks::ShellOut.shellout("sudo su - #{app_config[:user]} -c '#{command}' 2>&1"))
        command = "rsync -a --delete-delay #{shared_path}/node_modules/ #{app_root_path}/node_modules/"
        Chef::Log.info(OpsWorks::ShellOut.shellout("sudo su - #{app_config[:user]} -c '#{command}' 2>&1"))
        command = "cd #{app_root_path} && npm prune --production"
        Chef::Log.info(OpsWorks::ShellOut.shellout("sudo su - #{app_config[:user]} -c '#{command}' 2>&1"))
        command = "cd #{app_root_path} && npm install --production"
        Chef::Log.info(OpsWorks::ShellOut.shellout("sudo su - #{app_config[:user]} -c '#{command}' 2>&1"))
        command = "rsync -a --delete-delay #{app_root_path}/node_modules/ #{shared_path}/node_modules/"
        Chef::Log.info(OpsWorks::ShellOut.shellout("sudo su - #{app_config[:user]} -c '#{command}' 2>&1"))

        #Chef::Log.info(OpsWorks::ShellOut.shellout("sudo su - #{app_config[:user]} -c 'cd #{app_root_path} && npm #{npm_install_options}' 2>&1"))
      end
    end
  end
end