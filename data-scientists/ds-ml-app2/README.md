# About
The Data Scientists in this team work on developing a model for the [IRIS data set](https://archive.ics.uci.edu/ml/datasets/iris).


# Roles & responsibilties
## Model Development
All source code will be committed to the Google Cloud repository 'ml-app2' in the GCP project 'ds-ml-app2'. The Data Scientists can only read & write to the repository.  
For the source code itself, see the repository[my-fake-org-on-gcp-ml-app2](https://github.com/ReubenTheDS/my-fake-org-on-gcp-ml-app2)  

# CI CD
When a commit is made to the repository, a CI CD pipeline is triggered, running on Google Cloud Build.  
The source code for this pipeline is developed & maintained by the MLOps engineer in the GCP project 'my-org-mlops'.  
The Data Scientists can only view the logs of builds.  
At the end of the pipeline, a Docker image is pushed to Google Cloud Artifact Registry, and then deployed using [Google Cloud Vertex AI](https://cloud.google.com/vertex-ai).  
The Data Scientist can interact with the web UI provided by the application for predictions.


# Infrastructure
The MLOps engineer is in charge of enabling APIs & maintaining Google Cloud Artifact Registry
