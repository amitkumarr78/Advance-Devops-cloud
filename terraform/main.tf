 module "backend" {
  source = "./modules/backend"

  bucket_name    = var.bucket_name
  dynamodb_table = var.dynamodb_table
}
module "vpc" {
  source = "./modules/vpc"

  region           = "us-west-2"
  vpc_cidr         = "10.0.0.0/16"

  public_subnet_1  = "10.0.1.0/24"
  public_subnet_2  = "10.0.2.0/24"

  private_subnet_1 = "10.0.3.0/24"
  private_subnet_2 = "10.0.4.0/24"
}
module "compute" {
  source = "./modules/compute"

  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_1_id
  private_subnet_id = module.vpc.private_subnet_1_id

  ami_id = "ami-00563078bca04e287"
}
module "monitoring" {
  source = "./modules/monitoring"

  instance_id = module.compute.public_instance_id
}
module "EKS" {
  source = "./modules/EKS"
}