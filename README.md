# Terraform AWS 基本構成

AWS の基本的なネットワーク構成（VPC / Subnet）を
Terraform で理解・実装するための学習用リポジトリです。

## 現在の構成
- VPC
- Public / Private / DB Subnet
- 2AZ 構成
- Internet Gateway
- Public Route Table
- Application Load Balancer
- Target Group



## 設計方針
- 理解を優先し、リソースは明示的に定義
- 後続で count / locals によるリファクタを予定
- drow.ioにて既に構成図作成済み


![VPC](./VPC.drawio.png)
