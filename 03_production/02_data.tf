module "production" {
  source = "../01_module"

  # data of values
  region      = "ap-northeast-2"
  name        = "simon"
  cidr        = "0.0.0.0/0"
  cidr_main   = "10.0.0.0/16"
  key         = "simon-key"
  avazone     = ["a","c"]
  public_s    = ["10.0.0.0/24", "10.0.2.0/24"]
  private_s   = ["10.0.1.0/24", "10.0.3.0/24"]
  private_dbs = ["10.0.4.0/24", "10.0.5.0/24"]
  private_ip = "10.0.0.11"
}