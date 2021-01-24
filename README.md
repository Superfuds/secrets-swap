# Secrets Swap

Github Action to get secrets from S3 on EKS deployments

## How to use it

### Secrets in eks deployment manifests

If you need to add secrets in you deployment manifests to be accessible inside the pods as env vars you should add them with the following format:
```
s3keyring:[GROUP].[KEY_NAME]
```
`GROUP` and `NAME` are the same config used when stored the secret using s3keyring set [GROUP] [KEY_NAME] [VALUE]

For example:
```
  spec:
      containers:
        - name: 
          env:
            ...
            - name: SECRET
              value: "s3keyring:jelti.db_password"
```

### Add the action to your github pipeline

`.github/workflows/pipeline.yml`

```hcl
  steps:
    ...
    - name: Get s3keyring secrets
      id: s3keyring
      uses: Superfuds/secrets-swap@1.0.0
      env:
        app: [APP]
        environment: [ENVIRONMENT]
        aws_access_key_id: ${{ secrets.BOT_AWS_ACCESS_KEY }}
        aws_secret_access_key: ${{ secrets.BOT_AWS_SECRET_ACCESS_KEY }}
        aws_region: sa-east-1
```

- APP: The name of your app, should be consistent with your deployment manifest. `[APP]-deployment.yaml`
- ENVIRONMENT: Use `staging` or `production`
