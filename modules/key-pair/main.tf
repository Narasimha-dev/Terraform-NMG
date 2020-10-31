resource "aws_key_pair" "main" {
        key_name          = var.key_name
        public_key        = file(var.PATH_TO_PUBLIC_KEY)
}
