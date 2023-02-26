# gcloud CLI installation
Pre-requisites:
- Git Bash installed
- a GCP account

Ref: https://cloud.google.com/sdk/docs/install  

# Steps

1. If Python is installed but not on Path, or multiple Python versions are installed, add the path to the the Windows system env variable.  
Alternatively, add the following line to the file `.bash_profile`
```
export CLOUDSDK_PYTHON="C:/enter/path/to/your/python"
```


2. Optional: If using a proxy/corporate VPN, add the following line to the file `.bash_profile`
```
export HTTPS_PROXY="https://url/to/your/proxy"
```


3. Download the installer from [the official link](https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe) & run it


4. Optional: If using custom CA certs (usually in a corporate environment) SSL/TLS certificate, add it to gcloud config:
```
gcloud config set core/custom_ca_certs_file="C:/path/to/your/cert/file.crt"
```


5. To set a proxy for use by gcloud SDK itself, run the commands below with your values:
```
gcloud config set proxy/type http
gcloud config set proxy/address 1.234.56.78
gcloud config set proxy/port 8080
```


6. Authorize gcloud to obtain Google user credentials
```
gcloud auth application-default login
```
[Difference between two `gcloud auth` commands](https://stackoverflow.com/questions/53306131/difference-between-gcloud-auth-application-default-login-and-gcloud-auth-logi)


7. Check that the last step worked by listing credentials
```
gcloud auth list
```


8. Create a project & set it as the default for further `gcloud` commands
```
gcloud projects create --set-as-default 'my-fake-org-on-gcp'
```
[Reference](https://cloud.google.com/sdk/gcloud/reference/projects/create)


9. Verify that the project has been created
```
gcloud projects list
```


10. Enable billing on the project 'my-fake-org-on-gcp' using Google Console
