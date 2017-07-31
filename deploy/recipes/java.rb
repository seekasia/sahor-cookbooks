include_recipe 'aws'

aws_s3_file "/hklo/app.jar" do
  bucket "sahor"
  remote_path "onboarding-0.0.1-SNAPSHOT.jar"
  aws_access_key_id node[:custom_access_key]
  aws_secret_access_key node[:custom_secret_key]
end

execute "run app.jar in directory" do
  command "java -jar app.jar &"
  cwd "/hklo"
  action :run
end