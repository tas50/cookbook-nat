include_recipe "sysctl"

sysctl_param "net.ipv4.ip_forward" do
  value 1
end

include_recipe "iptables"

iptables_rule "masquerade" do
  source "masquerade.erb"
  variables({ :cidr => node[:nat][:cidr] })
end
