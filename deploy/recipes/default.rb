require 'json'
include_recipe 'aws'

deploy_user = node['deploy']['user'] || 'deploy'
deploy_group = node['deploy']['group'] || 'deploy'
paths = node['deploy']['path'] || {}

app = search('aws_opsworks_app','deploy:true').first
src_url = "#{app['app_source']['url']}"
access_key = "#{app['app_source']['user']}"
secret_key = "#{app['app_source']['password']}"
s3_data = src_url.split('/').drop(3)
datasource = app['data_sources'][0]

database = {}

if datasource['type'] == "RdsDbInstance"
  rds_db_instance = search('aws_opsworks_rds_db_instance', "id:#{datasource['arn'].gsub(':', '_')}").first
  
  database['database'] = {
    'driver' => rds_db_instance['engine'],
    'host' => rds_db_instance['address'],
    'port' => rds_db_instance['port'],
    'username' => rds_db_instance['db_user'],
    'password' => rds_db_instance['db_password'],
    'name' => app['data_sources'][0]['database_name']
  }
end

app['environment']['log_path'] = paths['log']
arg = {'arg' => (database.merge(app['environment']))}
profile = app['environment']['profile'] || 'stage'

aws_s3_file "#{paths['app']}/app.jar" do
  owner deploy_user
  group deploy_group
  mode "0755"
  bucket s3_data[0]
  remote_path s3_data.drop(1).join("/")
  aws_access_key_id access_key
  aws_secret_access_key secret_key
  action :create
end

execute "start application" do
  user deploy_user
  group deploy_group
  cwd paths['app']
  command "java -jar app.jar --spring.profiles.active=#{profile} --spring.application.json='#{arg.to_json}' &"
  action :run
end

Chef::Log.info("********** The app's source URL is '#{src_url}' **********")
Chef::Log.info("********** The app's path is '#{paths['app']}' **********")
Chef::Log.info("********** The app's s3 data is '#{s3_data}' **********")
Chef::Log.info("********** The app's access key is '#{access_key}' **********")
