// This is a test to deploy an EC2 server with Terraform

// Configure AWS as provider and deploy in us-east-2 data center
provider "aws" {
	region = "us-east-2"
}

/* variable "NAME" {
	[CONFIG ...]
}
variable "server_port" {
	description	= "The port used for HTTP requests by server"
	type 		= number
	default		= 8080
}*/

// Specify resource to deploy (EC2 instance in this case)
/* resource "PROVIDER_TYPE" "NAME" {
	    [CONFIG ...]
} */
resource "aws_instance" "exampleServer" {
	ami						= "ami-0c55b159cbfafe1f0"
	instance_type 			= "t2.micro"
	vpc_security_group_ids 	= [aws_security_group.instance.id]

	user_data		= <<-EOF
					  #!/bin/bash
					  echo "Hello, World!" > index.html
					  nohup busybox httpd -f -p 8080 &
					  EOF

	tags = {
		Name = "terraform-example"
	}
}

resource "aws_security_group" "instance" {
	name = "terraform-example-instance"

	ingress {
		from_port	= 8080
		to_port		= 8080
		protocol	= "tcp"
		cidr_blocks	= ["0.0.0.0/0"]
	}
}

/* This outputs the public IP of the EC2 instance when running "terraform apply" */
/* output = "NAME" {
	value = <VALUE>
	[CONFIG...]
} */
output "public_ip" {
	value = aws_instance.exampleServer.public_ip
	description = "The public IP of the web server"
}