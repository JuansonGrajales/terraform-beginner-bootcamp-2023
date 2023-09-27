variable "user_uuid" {
  type        = string
  description = "The UUID of the user"
  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]", var.user_uuid))
    error_message = "The user_uuid value must be a valid."
  }
}

variable "bucket_name" {
  description = "Name for the S3 bucket"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]+$", var.bucket_name))
    error_message = "Bucket name must only contain letters, numbers, hyphens, and periods."
  }
}

variable "index_html_filepath" {
  description = "The file path for index.html"
  type = string

  validation {
    condition = fileexists(var.index_html_filepath)
    error_message = "The provided path for index.html does not exist"
  }
}

variable "error_html_filepath" {
  description = "The file path for error.html"
  type = string

  validation {
    condition = fileexists(var.error_html_filepath)
    error_message = "The provided path for error.html does not exist"
  }
}

variable "content_version" {
  description = "The content version. Should be positive integer starting at 1."
  type = number

  validation {
    condition = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "The content_version must be a positive integer starting at 1"
  }
}

variable "assets_path" {
  description = "Path to assets folder"
  type = string
}