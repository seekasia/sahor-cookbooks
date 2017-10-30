## Softwares/ Tools

 - Jenkins
 ** (Avoid changing code in submodules - forked repo) **

## Security groups

Default OpsWork security gruop is very strict and limitted to centain protocal and ports, kindly create an custom security ports base on the needs. 


## IAM roles (To be reviewed)

IAM roles are very important. Using this roles we give the automation a restriction on which services they can automate and have control over. IAM roles are defined via policies. We have created one role named `opsworks-elasticsearch-ec2-role` with below policy:

```

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:DescribeRegions",
                "ec2:DescribeTags",
                "ec2:DescribeSecurityGroups",
                "ec2:CreateTags",
                "cloudwatch:PutMetricData"
            ],
            "Resource": "*"
        }
    ]
}

```

Policy name: `OpsWorksElasticsearchEC2Discovery`


### Layers

- Master (Jenkins)


#### Layer recipes configuration

- Chef cookbooks
- One master wrapper cookbook
- All the necessary dependencies in one repo 
- Cookbook folder `es-elk` will have more documentation on recipes and dependencies
- For our ELK implementation we can run below recipes for each of the layers.


### Instances

- For Jenkins, kindly use at least T2 Small instance type. 
