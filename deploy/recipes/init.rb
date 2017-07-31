user "deploy" do
  home "/home/deploy"
  shell "/bin/bash"
end

directory "/srv/sahor/" do
  mode 0755
  owner 'root'
  group 'root'
  recursive true
  action :create
end