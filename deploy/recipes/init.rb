user "deploy" do
  home "/home/deploy"
  shell "/bin/bash"
end

app = search('aws_opsworks_app').first
app_path = "srv/www/#{app['shortname']}"

directory "/#{app_path}" do
  mode 0755
  owner 'root'
  group 'root'
  recursive true
  action :create
end
