provider "google" {
  credentials = file("C:/path/to/your/cred/file.json") # path of file created when command "gcloud auth application-default login" was run
  region      = "us-east1"
  zone        = "us-east1-b"
}