deploy_user = node['deploy']['user'] || 'deploy'
deploy_group = node['deploy']['group'] || 'deploy'
paths = node['deploy']['path'] || {}

user "#{deploy_user}" do
  home "/home/#{deploy_user}"
  shell "/bin/bash"
end

paths.each do |key, value|
  directory "#{value}" do
   mode 0755
   owner deploy_user
   group deploy_group
   recursive true
   action :create
  end
  Chef::Log.info("********** Created path '#{key}' at '#{value}' **********")
end
