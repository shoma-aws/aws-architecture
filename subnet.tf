#PublicSubnetを作成
resource "aws_subnet" "public_a" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.1.0/24"
	availability_zone = "ap-northeast-1a"
	tags = {
		Name = "public-subnet-a"
	}
}
resource "aws_subnet" "public_c" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.2.0/24"
	availability_zone = "ap-northeast-1c"
	tags = {
		Name = "public-subnet-c"
	}
}

#PrivateSubnetを作成
resource "aws_subnet" "private_a" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.11.0/24"
	availability_zone = "ap-northeast-1a"
	tags = {
		Name = "private-subnet-a"
	}
}
resource "aws_subnet" "private_c" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.12.0/24"
	availability_zone = "ap-northeast-1c"
	tags = {
		Name = "private-subnet-c"
	}
}

#DBSubnetを作成
resource "aws_subnet" "db_a" {
	vpc_id = aws_vpc.main.id
	cidr_block = "10.0.21.0/24"
	availabirity_zone = "ap-northeast-1a"
	tags = {
		Name = "db-subnet-a"
	}
}
resource "aws_subnet" "db_c" {
	vpc_id            = aws_vpc.main.id
	cidr_block        = "10.0.22.0/24"
	availability_zone = "ap-northeast-1c"
	tags = {
		Name = "db-subnet-c"
	}
}
