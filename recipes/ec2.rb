include_recipe "awscli"

execute "Disable Source/Dest. check" do
  command <<-EOH
    aws ec2 --region "#{node['ec2']['placement_availability_zone'].chop}" \
      modify-instance-attribute \
      --instance-id "#{node['ec2']['instance_id']}" \
      --no-source-dest-check
  EOH
end
