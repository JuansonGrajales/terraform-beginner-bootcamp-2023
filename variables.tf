# variable "user_uuid" {
#   type        = string
#   description = "The UUID of the user"
#   validation {
#     condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]", var.user_uuid))
#     error_message = "The user_uuid value must be a valid."
#   }
# }
