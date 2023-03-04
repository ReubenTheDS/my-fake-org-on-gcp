# use the created infra bucket as a remote backend
# ref: https://developer.hashicorp.com/terraform/language/settings/backends/gcs#configuration-variables
terraform {
  backend "gcs" {
    bucket  = "my-fake-infra-on-gcp-bucket"
    prefix  = "terraform/state"
  }
}


provider "google" {
  region      = "us-east1"
  zone        = "us-east1-b"
  project     = "my-org-infra"
}


# a VPC for Jenkins master & slaves
# ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "jenkins_network" {
  name  = "jenkins-network"
  auto_create_subnetworks = false
}

# a subnet in that VPC for Jenkins master & slaves
# ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "jenkins_subnetwork" {
  name          = "jenkins-subnetwork"
  ip_cidr_range = "10.0.0.0/16"
  region        = "us-east1"
  network       = google_compute_network.jenkins_network.id
}


# A VM for the Jenkins master
# ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
resource "google_compute_instance" "jenkins_master_compute_instance" {
  name = "jenkins-master"
  machine_type = "e2-medium"  # TODO: try with cheaper machines
  zone = "us-east1-b" # same as the zone being used throughout

  tags = ["jenkins-master"]    # for targetting VMs by label

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"    # latest widely supported Linux OS
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.jenkins_subnetwork.name

    access_config {
      # Include this section to give the VM an external IP address
    }
  }

  # to allow the Infra engineer to SSH into the Jenkins master:
  #  upload the public SSH key, tying it to the user 'infra_engineer' on the VM
  metadata = {
    ssh-keys = "infra_engineer:${file("~/.ssh/infra_engr/id_rsa.pub")}"
  }

  # installation of Jenkins will take about 10 minutes
  metadata_startup_script = "${file("install_jenkins_master.sh")}"
}


# create a firewall to allow pings to the Jenkins master from anywhere
# ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
resource "google_compute_firewall" "jenkins_master_firewall_rule_ping" {
  name = "jenkins-master-firewall-ping"
  network = google_compute_network.jenkins_network.name

  direction = "INGRESS"   # this rule applies to incoming traffic

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"] # from anywhere on the Internet

  target_tags = ["jenkins-master"]  # apply this rule to VM tagged "jenkins-master"
}

# create a firewall to allow SSH access to the Jenkins master from anywhere
resource "google_compute_firewall" "jenkins_master_firewall_rule_ssh" {
  name = "jenkins-master-firewall-ssh"
  network = google_compute_network.jenkins_network.name

  direction = "INGRESS"   # this rule applies to incoming traffic

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["jenkins-master"]  # apply this rule to VM tagged "jenkins-master"
}

# create a firewall to allow HTTP traffic to the Jenkins master on port 8080 (default port by Jenkins) from anywhere
resource "google_compute_firewall" "jenkins_master_firewall_rule_http" {
  name = "jenkins-master-firewall-http"
  network = google_compute_network.jenkins_network.name

  direction = "INGRESS"   # this rule applies to incoming traffic

  allow {
    protocol = "tcp"
    ports = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["jenkins-master"]  # apply this rule to VM tagged "jenkins-master"
}


# print the IP address of the VM provisioned for Jenkins master
output "jenkins_master_IP" {
  value = google_compute_instance.jenkins_master_compute_instance.network_interface.0.access_config.0.nat_ip
}

output "jenkins_master_URL" {
  value = join ("", 
    [
      "http://", 
      google_compute_instance.jenkins_master_compute_instance.network_interface.0.access_config.0.nat_ip, 
      ":", 
      "8080"
    ]
  )
}


# A VM for the Jenkins agent
resource "google_compute_instance" "jenkins_agent_compute_instance" {
  name = "jenkins-agent"
  machine_type = "e2-medium"  # TODO: try with cheaper machines
  zone = "us-east1-b" # same as the zone being used throughout

  tags = ["jenkins-agent"]    # for targetting VMs by label

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"    # latest widely supported Linux OS
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.jenkins_subnetwork.name

    access_config {
      # Include this section to give the VM an external IP address
    }
  }

  # upload the public SSH key, tying it to the user 'infra_engineer' on the VM
  metadata = {
    ssh-keys = "infra_engineer:${file("~/.ssh/infra_engr/id_rsa.pub")}"
  }

  # installation of Java & other dependencies will take about 10 minutes
  metadata_startup_script = "${file("install_jenkins_agent.sh")}"
}


# create a firewall to allow SSH access to the Jenkins agent from anywhere
resource "google_compute_firewall" "jenkins_agent_firewall_rule_ssh" {
  name = "jenkins-agent-firewall-ssh"
  network = google_compute_network.jenkins_network.name

  direction = "INGRESS"   # this rule applies to incoming traffic

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["jenkins-agent"]  # apply this rule to VM tagged "jenkins-agent"
}


# print the internal IP address of the VM provisioned for Jenkins agent
# ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#network_interface.0.network_ip
output "jenkins_agent_internal_IP" {
  value = google_compute_instance.jenkins_agent_compute_instance.network_interface.0.network_ip
}


# print the external IP address of the VM provisioned for Jenkins agent
# ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#network_interface.0.access_config.0.nat_ip
output "jenkins_agent_external_IP" {
  value = google_compute_instance.jenkins_agent_compute_instance.network_interface.0.access_config.0.nat_ip
}
