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

### Route 53 
In order to be able to access your kubeflow deployment, you will need a domain. The simplest solution is to use AWS Route 53 to set this up. In this way, you don't need to worry about subdomains, for example. The ".link" is the cheapest option available on AWS and you can register a ".link" domain for about 5 usd. To see instructions on how to registrer your domain with Route 53, check this [link](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-register.html). 

We will use the name of the domain you registered in a leter step. 

### IAM user for the Minio client
We will need to set up an IAM user for the Minio client. In order to do this, follow [this instructions](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_cliwpsapi). We need to grant this user permissions to get bucket locations and allow read and write access to objects in an S3 bucket where you want to store the Kubeflow artifacts. 
Store the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY for the IAM user that was just created. We will use it in a later step. 

## Route 53, IAM Minio client, and enviroment variables

Next, we will write a configuration with the information for our domain, IAM minio client, and some additional environment variables necessary for our deployment. 

The should look like this: 
```
cluster_name="kubeflow_cluster"
cluster_region="us-east-1"
generate_db_password="true"
aws_route53_root_zone_name="<the domain you have registered with Route 53>"
aws_route53_subdomain_zone_name="platform.<your Route 53 domain>"
cognito_user_pool_name="kubeflow_cognito_pool"
use_rds="true"
use_s3="true"
use_cognito="true"
load_balancer_scheme="internet-facing"

# The below values are set to make cleanup easier but are not recommended for p>
deletion_protection="false"
secret_recovery_window_in_days="0"
force_destroy_s3_bucket="true"
```

**Save this file as `sample.auto.tfvars` in the path:**

```
/kubeflow-manifests/deployments/cognito-rds-s3/terraform
``` 

**inside the docker container**.



### Export IAM Minio credentials
We will need to run a shell script to export the Minio IAM credentials. The file should look like this: 
```
export TF_VAR_minio_aws_access_key_id=<Your Minio AWS access key id>
export TF_VAR_minio_aws_secret_access_key=<Your Minio AWS secret key>
```

**Before you continue to the next step, execute this exports**.

## Preview of the Terraform configuration
If you want to see a preview of the configuration we are about to apply, run:
```
terraform output -raw kubeflow_platform_domain
```

## Deploy with Terraform
Lay back and relax, running the command to deploy Kubeflow will take a long time. To deploy, run this command:

```
make deploy
```

## Connecting to the Kubeflow dashboard
To connect to the main Kubeflow dashboard, you will have to head to the Cognito user pool created by the deployment. Create a new user. **THIS USER MUST HAVE E-MAIL ``user@example.com``. This is so that you can access the right namespace in the deployment. 

To get the link to the main Kubeflow dashboard, run: 
``` 
terraform output -raw kubeflow_platform_domain
``` 

Finally, open the link your browser and connect using the credentials that you just configured. 

# Cleanup
To destroy or the deployed resources on AWS, run:

```
make delete
```

