variable "aws_region" {
  description = "AWS Region for deploying services"
  default     = "eu-west-1"
}

variable "db_password" {
  description = "Password for the database"
  type        = string
  default = "admin123"
}

variable "wordpress_password" {
  description = "Password for the WordPress database"
  type        = string
  default     = "wp-admin123"
}
