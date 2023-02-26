# About
This project simulates an Org that is using Google Cloud resources. Terraform is used as much as possible

# Org Structure
The Organisation consists of:
- The CEO & GCP project owner i.e. you
- 2 Data Scientists
- 1 MLOPs engineer
- 1 Infrastructure engineer  
![Org Structure](./Org%20structure.jpg)


# Roles
## Data Scientists
There are 3 Data Scientists in 2 teams.  
DS Team 1 has (limited) access to repositories on Google Cloud i.e. Google Cloud Source Repositories  
DS Team 2 has (limited) access to repositories on Google Cloud and an in-house GitLab


## MLOps Engineer
The MLOps Engineer is in charge of DevOps practices, i.e. developing & maintaining CI CD pipelines for the Data Scientists  
He develops scripts for use in Jenkins & Google Cloud Build, as well as regulates access to these by the Data Scientists


## Infrastructure Engineer
The Infrastructure Engineer (she) is in charge of maintaining & setting up:
- GitLab for the ML team 'ds-ml-app2
- Jenkins setup & maintenance
- GKE clusters & operators


## CEO
The CEO is the owner & admin of any & all GCP projects created