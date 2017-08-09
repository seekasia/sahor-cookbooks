aws_elastic_lb 'Deregister Node from ELB' do
  name node['deploy']['elb']
  action :deregister 
end
Chef::Log.info("********** Deregistered instance from '#{node['deploy']['elb']}' **********")