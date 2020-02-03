This project uses a centralized image repository to manage images built in the project. After a clean build, images are pushed to DockerHub.

When repo is used with CircleCI the Dockerfile and HTML is checked against a linter as part of a Continuous Integration step

Takes a Dockerfile and creates a Docker container in the pipeline.

Kubernetes cluster deploys docker container with CloudFormation using eksctl (run_aws.sh) or can be deployed locally with minikube (run_local_k8s.sh)

### To build the docker image locally:

- Clone the repo

- Run run_docker.sh shell script

- Access "localhost:8080" in browser


### To deploy AWS Cluster:

- Setup AWS CLI on your local machine (https://docs.aws.amazon.com/cli/latest/userguide/install-cliv1.html)

- Log into your AWS account using the CLI and make sure you are in the US-East-1 (N Virginia) Region

- Ensure you have created an SSH key pair for connecting to EC2 Instances (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair)

- If you haven't already setup kubectl (https://kubernetes.io/docs/tasks/tools/install-kubectl/)

- Clone the repo to your local machine (https://git-scm.com/docs/git-clone)

- Review contents of eksctl-parameters.yaml file to adjust name of the AWS EKS cluster you'll create in next steps, default is Travel-Blog-K8S-Cluster

- Start up AWS EKS cluster by running `eksctl create cluster -f eksctl-parameters.yaml`

- When returned to prompt run `kubectl get nodes` to see that you now have 3 nodes awaiting use.

- Run `kubectl apply -f my-travel-blog-deploy.yaml`

- Run `kubectl apply -f my-travel-blog-svc.yaml`

- Run `kubectl get services`.  Details for a service named "my-travel-blog" will be returned, copy the external IP field (e.g. a2ba2c93545dc11ea9e15162e9ff8081-158732718.us-east-1.elb.amazonaws.com) and paste into your web browser.  Travel blog should come up.

- Run `eksctl delete cluster -f eksctl-parameters.yaml' to delete the EKS cluster created

### Updating the site, linting and performing a "rolling update"

- Get an AWS EKS cluster running using the steps above

- On Github fork the repo then clone to your local machine

- Edit the /.circleci/config.yaml file to update the container name on line 5 

- In your CircleCI account, add your repo and under project settings add DOCKERHUB_USERNAME and DOCKERHUB_PASS environment variables so that it can push to docker hub once CI steps have been completed.

- Edit the index.html file in the travel-blog-site subfolder and on line 62 change the title of the blog to your own name

- Push index.html change up to your GitHub Repo

- Monitor CircleCI job for a pass

- Check DockerHub for an updated version of the container

- Run `kubectl apply -f my-travel-blog-deploy.yaml` to update the deployment

- If you haven't already started the service run `kubectl apply -f my-travel-blog-svc.yaml`