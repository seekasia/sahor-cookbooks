deploy_user = node['deploy']['user'] || 'deploy'

app = search('aws_opsworks_app','deploy:true').first
management_port = app['environment']['management_port'] || 8080

execute "shutdown service" do
  user deploy_user
  ignore_failure true
  command "curl -XPOST http://localhost:#{management_port}/shutdown"
  action :run
end
