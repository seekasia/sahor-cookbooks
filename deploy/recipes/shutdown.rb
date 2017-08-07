execute "shutdown service" do
   user "deploy"
   ignore_failure true
   command "curl -XPOST http://localhost:8088/shutdown"
   action :run
 end
