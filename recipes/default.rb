include_recipe "awscli"

instance_region = `curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | grep -Po "(us|sa|eu|ap)-(north|south)?(east|west)?-[0-9]+"`.strip
instance_id = `curl -s http://169.254.169.254/latest/meta-data/instance-id`

execute "Disable Source/Dest. check" do
  command <<-EOH
    aws ec2 --region "#{instance_region}" \
      modify-instance-attribute \
      --instance-id "#{instance_id}" \
      --source-dest-check false
  EOH
end

directory "/usr/local/sbin" do
  owner "ubuntu"
  group "admin"
  mode 0644
  action :create
end

template "/usr/local/sbin/configure-pat.sh" do
  source "sudoers.erb"
  mode 0744
  owner "ubuntu"
  group "admin"
end

execute "Configure IP masquerading and forwarding" do
  command "/usr/local/sbin/configure-pat.sh"
end
