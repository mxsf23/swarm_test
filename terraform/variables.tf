variable "zone" {
  default = "ru-central1-a"
  description = "Cloud Zone name"
  type = string
}

variable "folder_id" {
  description = "Account folder ID"
  type = string
}


variable "cloud_id" {
  description = "Cloud ID"
  type = string
}


variable "secgroup_id" {
  description = "Security group ID. This variable doesn't apply to anything. Used as a mark for furture. It's always Default yet."
  default = "default"
  type = string
}

variable "sa_id" {
  description = "Service Account ID"
  type = string
}

variable "access_key" {
  description = "Access key for S3 Storage"
  type = string
}
variable "secret_key" {
  description = "Secret key for S3 Storage"
  type = string
}

variable "v4_cidr_blocks" {
  type = list (string)
  description = "IPv4 network for private subnet"
  default = ["192.168.20.0/24"]
}

variable "network_name" {
  type = string
  description = "Private network name"
  default = "network1"
}

variable "subnet_name" {
  type = string
  description = "Private subnet name"
  default = "subnet1"
}

variable "ssh_port" {
  description = "SSH Port"
  type = number
  default = 22
}

variable "image" {
  description = "Compute Image"
  type = string
}
