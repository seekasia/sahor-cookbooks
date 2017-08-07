require 'json'
include_recipe 'aws'

app = search('aws_opsworks_app').first
app_path = "srv/www/#{app['shortname']}"
src_url = "#{app['app_source']['url']}"
access_key = "#{app['app_source']['user']}"
secret_key = "#{app['app_source']['password']}"
s3_data = src_url.split('/').drop(3)

rds_db_instance = search('aws_opsworks_rds_db_instance').first

database = {
  'database' => {
    'driver' => rds_db_instance['engine'],
    'host' => rds_db_instance['address'],
    'port' => rds_db_instance['port'],
    'username' => rds_db_instance['db_user'],
    'password' => rds_db_instance['db_password'],
    'name' => app['data_sources'][0]['database_name']
  }
}

arg = {'arg' => (database.merge(app['environment']))}
profile = app['environment']['profile'] || 'stage'

aws_s3_file "/#{app_path}/app.jar" do
  owner "deploy"
  group "deploy"
  mode "0755"
  bucket s3_data[0]
  remote_path s3_data.drop(1).join("/")
  aws_access_key_id access_key
  aws_secret_access_key secret_key
  action :create
end
 
 execute "run app.jar in directory" do
   user "deploy"
   cwd "/#{app_path}"
   command "java -jar app.jar --spring.profiles.active=#{profile} --spring.application.json='#{arg.to_json}' &"
   action :run
 end
  
Chef::Log.info("********** The app's URL is '#{src_url}' **********")
Chef::Log.info("********** The app's path is '#{app_path}' **********")
Chef::Log.info("********** The app's s3 data is '#{s3_data}' **********")
Chef::Log.info("********** The app's secret key is '#{secret_key}' **********")
Chef::Log.info("********** The app's access key is '#{access_key}' **********")
