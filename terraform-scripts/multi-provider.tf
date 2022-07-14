provider "aws" {
  access_key="AKIATBZFGW2Q5YK3CYSP"
  secret_key="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"
  region  = "ap-south-1"
}
provider "aws" {
  alias= "sing"
  access_key="AKIATBZFGW2Q5YK3CYSP"
  secret_key="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"
  region  = "ap-southeast-1"
}