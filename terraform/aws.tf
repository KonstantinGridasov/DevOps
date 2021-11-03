provider "aws" {

  region = "us-central-1"
  shared_credentials_file = "~/credentional/credentional_aws"
   
 } 
  

resource "aws_instanse" "my_webserver" {
  
}