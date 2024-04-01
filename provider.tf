terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.21.0"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = file("martins-juice-shop-1ca8bd5dd91e.json")
  project = "martins-juice-shop"
  region = "us-central1"
}