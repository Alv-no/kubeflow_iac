# Kubeflow deployment - AWS integrated

Use this repository to facilitate the deployment of Kubeflow on AWS. The repository contains a Dockerfile and several scripts to make the Kubeflow deployment [guide provided by AWS](https://awslabs.github.io/kubeflow-manifests/release-v1.6.1-aws-b1.0.0/) even simpler to run.  

Here, we focus on the Kubeflow deployment version with the tightest integration with AWS. This is a deployment with the following integrated components: 

- [AWS Cognito](https://aws.amazon.com/cognito/) used as an identity provider.
- [AWS RDS](https://aws.amazon.com/rds/) used as a [KFP](https://www.kubeflow.org/docs/components/pipelines/v1/sdk/sdk-overview/) and [Katib](https://www.kubeflow.org/docs/components/katib/overview/) persistence layer.
- [AWS S3](https://aws.amazon.com/s3/) used as an artifact store.

This deployment is done relaying on **Terraform**. 

## Deployment prerequisites
To deploy Kubeflow in AWS there are some prerequisites which are covered when building the docker container.

### Setting up a docker environment
User the Dockerfile in the repository to build the image with the command: 

```
docker build --rm -t ubuntu/kubeflow_deploy:18.04 . 
```


## Configuration files
Before running with docker, we need to set up a couple of AWS configuration files. 
### AWS config and AWS credentials
To be able to interact with AWS via CLI, we need to set up the AWS region and AWS credentials for our existing AWS account. An option to do this is to run:

```
aws configure
``` 

and provide the information as indicated in the CLI prompt. If you have previously done this in your local machine, this information is saved by default under:
```
~/.aws/config
~/.aws/credentials
```

If you haven't run this command you can write this files yourself. They config file must look like this: 

```
[profile kubeflow]
region = us-east-1
```

The credentials file should look something like this:
```
[kubeflow]
aws_access_key_id = <Your Access Key ID>
aws_secret_access_key = <Your Secret Access Key>
```

