variable "amis" {
    type = map  # Variavel do tipo map, ou seja, estilo JSON

    default = {
        "us-east-1" = "ami-09e67e426f25ce0d7"
        "us-east-2" = "ami-00399ec92321828f5"
    }
  
}

variable "cidr_ips" {
    type = list

    default = ["177.80.2.137/32", "178.80.2.137/32"]

}

variable "keys" {

    default = "terraform-aws"
  
}