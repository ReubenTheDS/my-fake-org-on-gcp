# About
The Data Scientist in this team works on developing a model for [wine quality prediction](https://archive.ics.uci.edu/ml/datasets/wine+quality).


# Roles & responsibilties
## Model Development
All source code will be committed to the Google Cloud repository 'ml-app1' in the GCP project 'ds-ml-app1'. The Data Scientist can only read & write to the repository.  
For the source code itself, see the repository[my-fake-org-on-gcp-ml-app1](https://github.com/ReubenTheDS/my-fake-org-on-gcp-ml-app1)  


# CI CD
When a commit is made to the repository, a CI CD pipeline is triggered, running on Google Cloud Build.  
The source code for this pipeline is developed & maintained by the MLOps engineer in the GCP project 'my-org-mlops'.  
The Data Scientist can only view the logs of builds.  
At the end of the pipeline, a Docker image is pushed to Google Cloud Artifact Registry, and then deployed using [BentoML (web framework for ML models)](https://docs.bentoml.org/en/latest/) on a Google Cloud Compute Engine.  
The Data Scientist can interact with the web UI provided by the BentoML application for predictions.


# Infrastructure
The MLOps engineer is in charge of enabling APIs & maintaining Google Cloud Artifact Registry
