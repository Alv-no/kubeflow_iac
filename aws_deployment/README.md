# Kubeflow deployment - AWS integrated

Use this repository to facilitate the deployment of Kubeflow on AWS. The repository contains a Dockerfile and several scripts to make the Kubeflow deployment [guide provided by AWS](https://awslabs.github.io/kubeflow-manifests/release-v1.6.1-aws-b1.0.0/) even simpler to run.  

Here, we focus on the Kubeflow deployment version with the tightest integration with AWS. This is a deployment with the following integrated components: 

- [AWS Cognito](https://aws.amazon.com/cognito/) used as an identity provider.
- [AWS RDS](https://aws.amazon.com/rds/) used as a [KFP](https://www.kubeflow.org/docs/components/pipelines/v1/sdk/sdk-overview/) and [Katib](https://www.kubeflow.org/docs/components/katib/overview/) persistence layer.
- [AWS S3](https://aws.amazon.com/s3/) used as an artifact store.

This deployment is done relaying on **Terraform**. 

## Deployment prerequisites
To deploy Kubeflow in AWS three prerequisites must be fulfilled:

1. Setting up a docker environment
2. 
3. 
