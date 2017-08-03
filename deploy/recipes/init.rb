user "deploy" do
  home "/home/deploy"
  shell "/bin/bash"
end

directory "/srv/app/" do
  mode 0755
  owner 'root'
  group 'root'
  recursive true
  action :create
end
