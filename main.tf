# Terraform state will be stored in S3
terraform {
  backend "s3" {
    bucket = "terraform-bucket-mineman"
    key    = "terraform.tfstate"
    region = "sa-east-1"
  }
}

# Use AWS Terraform provider
provider "aws" {
  region = "sa-east-1"
  access_key = "ASIA5A4BVS7TAUMOABJW"
  secret_key = "FcBUnui4tw3c6FgqbY65bQLCstA8/mPsodGnyBhg"
  token = "IQoJb3JpZ2luX2VjEIn//////////wEaCXVzLWVhc3QtMSJHMEUCIBLyk+SVoiS00qxjMHoclUvMOb37SrH+vaS7KJHXSs0xAiEAw90WP9JN+DoDbSfdt/7NxlzmZVIFtWR4+6KcNYjBVrEqvQIIkv//////////ARAAGgw4OTUyMzU3NTgwNTQiDOB74cZQTm+1e0EcgSqRAlUYA71O4+BUbbPrYDYFPfrY0JCsmvZ1Wa6y3W/9DZTwx8b9UbdTEwsVwZUysBFPmX7rgci3frzqt0P8qnzAvJeHyQkj5pD753T90Y1oEuTELgrO4GPqN7HrfooMuuEpQyQEbuWqTYth13iCb3Qg0ZDPaJPwWwLUopa1pY3yfJO1uCc1OcGc87dxLGU8HruUZhsSDe2QWSLf6igHyPgmYCug0ehyPJIm5qXOhB2dpWHqUi8XOHsqDKeJgQzi/6uLp2qwmnlEaTYdHLbkA6t7d/3jgzUognG6aiSD47t82FMu52/hzGBatEFnZz3WtXFL9PYQupQqpLZf8OL7J6ICYok/NA3+nhMwatEdLC2VbZsaYTDIl6j0BTrpAeeCjEf5GmiKdlhSn8GYmi6ZsVVEbB5LEMTybxX2oaQP8BHv8L9gpvQD2IQVrib45POUwomed4zG0R22bSGzlO6orq3zhRdVl2LGTovDq40cZriQJDmVPxafqU7ExiZLvsww2EsYUly0Y00xNrLcKFvJ//FfKPTkM4fBYB7LJILjVsnuYwLUoFQYHP4f0U8Qzp/pItr381C5yB3Woywzd+rPNGx/RejyllKLM+J7Pe+3mn09XS0qygXWNVZAwOB9Op5kpiK2JB11GZfARARzlhII7eG2uUYuByJ1TGnoUcbkfTwybCs66iLj"
  
}

# Create EC2 instance
resource "aws_instance" "default" {
  ami                    = var.ami
  count                  = var.instance_count
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.default.id]
  source_dest_check      = false
  instance_type          = var.instance_type

  tags = {
    Name = "terraform-default"
  }
}

# Create Security Group for EC2
resource "aws_security_group" "default" {
  name = "terraform-default-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
