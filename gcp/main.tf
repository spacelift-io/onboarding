provider "google" {
  project = "green-mercury-339114"
}

resource "google_storage_bucket" "MULTI_REGIONAL" {
  name     = "testspaceliftmatsumoto"
  storage_class = "MULTI_REGIONAL"
  location = "us"
}