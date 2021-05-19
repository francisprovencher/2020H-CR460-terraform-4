resource "google_compute_instance" "chien" {
  name         = "chien"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  tags         = ["web-public"]


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }


  network_interface {
    subnetwork = google_compute_subnetwork.prod-dmz.name
    access_config {

    }
  }


  metadata_startup_script = "apt-get -y update && apt-get -y upgrade && apt-get -y install apache2 && systemctl start apache2"
}

resource "google_compute_health_check" "http-health-check" {
  name = "http-health-check"

  timeout_sec        = 1
  check_interval_sec = 4
  healthy_threshold   = 5
  unhealthy_threshold = 3

  http_health_check {
    port = 80
  }
}

resource "google_compute_instance" "chat" {
  name         = "chat"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  tags         = ["interne"]

  boot_disk {
    initialize_params {
      image = "fedora-coreos-cloud/fedora-coreos-stable"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.prod-interne.name
    access_config {

    }
  }
}


resource "google_compute_instance" "hamster" {
  name         = "hamster"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  tags         = ["traitement"]

  boot_disk {
    initialize_params {
      image = "fedora-coreos-cloud/fedora-coreos-stable"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.prod-traitement.name

  }
}





resource "google_compute_instance" "perroquet" {
  name         = "perroquet"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  tags         = ["cage"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.prod-traitement.name

  }
}
