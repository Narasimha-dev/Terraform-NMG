variable PATH_TO_PUBLIC_KEY {
        default         = "mykey.pub"
        description     = "Public key file path location"
}

variable key_name {
        description     = "The key name to use for the instance"
        type            = string
        default         = "mykey"
}
