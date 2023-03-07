# About
This project simulates an Org that is using Google Cloud resources. Terraform is used as much as possible

# Org Structure
The Organisation consists of:
- The CEO & GCP project(s) owner
- 1 Infrastructure engineer
- 1 MLOPs engineer
- 3 Data Scientists  
![Org Structure](./Org%20structure.jpg)
  
  
# Roles
## CEO
The CEO is the owner & admin of any & all GCP projects created. Only the CEO has access to billing accounts.  
All operations to be run by the CEO are in the folder [ceo](./ceo/)
  
  
## Infrastructure Engineer
The Infrastructure Engineer (she) is in charge of maintaining & setting up:
- Jenkins for CI CD pipelines in projects being developed by the Data Scientists
- in-house GitLab
- GKE clusters & operators
- to some extent, operations between GCP projects
  
All operations to be run by the Infrastructure engineer are in the folder [infra-engineer](./infra-engineer/)
  
  
## MLOps Engineer
The MLOps Engineer is in charge of DevOps practices, i.e. developing & maintaining CI CD pipelines for the Data Scientists  
He develops scripts for use in Jenkins & Google Cloud Build, as well as regulates access to these by the Data Scientists  
  
  
## Data Scientists
There are 3 Data Scientists in 2 teams.  
DS Team 1 has (limited) access to repositories on Google Cloud i.e. Google Cloud Source Repositories  
DS Team 2 has (limited) access to repositories on Google Cloud and an in-house GitLab  
All operations to be run by the Data Scientists are in the folder [data-scientists](./data-scientists/)
  
  
# Steps
Start off with the folder [ceo](./ceo/)
