name             "nat"
maintainer       "Christopher Chow"
maintainer_email "chris@chowie.net"
license          "Apache 2.0"
description      "Setup NAT instances on Amazon VPCs"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "1.0.0"

depends          "awscli"
depends          "sysctl"
depends          "iptables"
