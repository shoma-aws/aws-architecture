#VPCを10.0.0.0～10.0.255.255の範囲で作成
resource "aws_vpc" "main" {
	cidr_block = "10.0.0.0/16"
	enable_dns_support = true
	enable_dns_hostnames = true

	tags = {
		Name = "sample-vpc"
		Environment = "dev"
		ManagedBy = "terraform"
	}
}
