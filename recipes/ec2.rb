include_recipe "awscli"

instance_region = `curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | grep -Po "(us|sa|eu|ap)-(north|south)?(east|west)?-[0-9]+"`.strip
instance_id = `curl -s http://169.254.169.254/latest/meta-data/instance-id`

execute "Disable Source/Dest. check" do
  command <<-EOH
    aws ec2 --region "#{instance_region}" \
      modify-instance-attribute \
      --instance-id "#{instance_id}" \
      --no-source-dest-check
  EOH
end
