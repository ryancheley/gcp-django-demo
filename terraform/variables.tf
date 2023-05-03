variable "project" {
  description = "The ID of the GCP project"
}

variable "region" {
  description = "The GCP region to create the instance in"
  default     = "us-west1"  
}

variable "zone" {
  description = "The GCP zone to create the instance in"
  default     = "us-west1-a"
}

variable "machine_type" {
  description = "The GCP Machine Type to create the instance in"
  default     = "e2-standard-2"
}

variable "cloud" {
  description = "The name of the cloud being used"
  default     = "gcp"
}

variable "app_name" {
  description = "The name of the app"
  default     = "django"
}

variable "environment" {
  description = "The name of the environment"
  default     = "d" # (p)rod, (t)est, (d)ev
}

variable "password" {
    description = "An insecure password"
    default = "b!gdumbh4t"
}

variable "instance_count" {
    description = "how many vms will you create"
    default = 1
}
