provider "aws" {
  access_key = var.v-access-key
  secret_key = var.v-secret-key
  region     = var.region
}

module "vpc" {
  source       = "./vpc"
  v-access-key = var.v-access-key
  v-secret-key = var.v-secret-key
  region       = var.region
}

module "web" {
  source       = "./web"
  v-access-key = var.v-access-key
  v-secret-key = var.v-secret-key
  region       = var.region
  v_vsgi       = module.vpc.vpc_security_group_ids
  v_si         = module.vpc.subnet_id
}

module "db" {
  source       = "./db"
  v-access-key = var.v-access-key
  v-secret-key = var.v-secret-key
  region       = var.region
  v_vsgi       = module.vpc.vpc_security_group_ids
  v_si         = module.vpc.subnet_id
}
