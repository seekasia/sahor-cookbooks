include_recipe 'aws'

app = search(:aws_opsworks_app).first
app_path = "/srv/#{app['shortname']}"
src_url = "#{app['app_source']['url']}"
access_key = "#{app['app_source']['user']}"
secret_key = "#{app['app_source']['password']}"
s3_data = src_url.split('/').last(2)

aws_s3_file "/#{app_path}/app.jar" do
  bucket s3_data[0]
  remote_path s3_data[1]
  aws_access_key_id access_key
  aws_secret_access_key secret_key
end

execute "run app.jar in directory" do
  command "java -jar app.jar &"
  cwd "/#{app_path}"
  action :run
end

Chef::Log.info("********** The app's URL is '#{src_url}' **********")
Chef::Log.info("********** The app's path is '#{app_path}' **********")
Chef::Log.info("********** The app's s3 data is '#{s3_data}' **********")
Chef::Log.info("********** The app's secret key is '#{secret_key}' **********")
Chef::Log.info("********** The app's access key is '#{access_key}' **********")