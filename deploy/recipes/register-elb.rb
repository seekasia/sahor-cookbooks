aws_elastic_lb 'Register Node to ELB' do
  name node['deploy']['elb']
  action :register
end
Chef::Log.info("********** Registered instance to '#{node['deploy']['elb']}' **********")