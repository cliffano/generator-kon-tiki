terraform {
  backend "s3" {
    bucket = "{{project_id}}bucket"
    key    = "kon-tiki/{{project_id}}.tfstate"
    region = "ap-southeast-2"
  }
}
