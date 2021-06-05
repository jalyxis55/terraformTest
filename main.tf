// This is a test to deploy an EC2 server with Terraform

// Configure AWS as provider and deploy in us-east-2 data center
provider "aws" {
	region = "us-east-2"
}

// Specify resource to deploy (EC2 instance in this case)
/* resource "PROVIDER_TYPE" "NAME" {
	    [CONFIG ...]
} */
resource "aws_instance" "exampleServer" {
	ami				= "ami-0c55b159cbfafe1f0"
	instance_type 	= "t2.micro"
}