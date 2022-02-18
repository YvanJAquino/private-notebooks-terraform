
variable "name" {
    type = string
    default = "private-notebooks"
}

variable "project_id" {
    type = string
    # Use the google_client_config    
    default = null
}

variable "region" {
    type = string
    default = "us-central1"
}