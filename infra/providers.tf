provider "aws" {
  region = var.home_region
  alias  = "home"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east"
}

provider "aws" {
  region = "us-west-2"
  alias  = "us_west"
}
