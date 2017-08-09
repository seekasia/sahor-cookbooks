aws_elastic_lb 'Register Node to ELB' do
  name node['deploy']['elb']
  action :register
end
Chef::Log.info("********** Registered '#{node[:opsworks][:instance][:aws_instance_id]}' to '#{node['deploy']['elb']}' **********")