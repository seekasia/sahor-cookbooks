aws_elastic_lb 'Deregister Node from ELB' do
  name node['deploy']['elb']
  action :deregister 
end
Chef::Log.info("********** Deregistered '#{node[:opsworks][:instance][:aws_instance_id]}' from '#{node['deploy']['elb']}' **********")