## Softwares/ Tools
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fseekasia%2Fsahor-cookbooks.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fseekasia%2Fsahor-cookbooks?ref=badge_shield)

** (Avoid changing code in submodules - forked repo) **
 - Jenkins
 - Sahor Stack
 

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

## OpsWorks
### 1. Jenkins
#### Layers

- Master (Jenkins)

#### Instances

- For Jenkins, kindly use at least T2 Small instance type. 

### 2. Sahor Stack
#### Configuration
```
{  
   "java":{  
      "install_flavor":"oracle",
      "jdk_version":"8",
      "oracle":{  
         "accept_oracle_download_terms":true
      }
   },
   "timezone_iii":{  
      "timezone":"Asia/Singapore"
   },
   "deploy":{  
      "user":"sahor",
      "group":"sahor",
      "path":{  
         "app":"/srv/www/sahor",
         "log":"/mnt/logs"
      }
   }
}
```

#### Layers
##### Java
###### Setup
```
timezone_iii::amazon, java::default, deploy::init
```
###### Configure
```
deploy::shutdown, deploy::default
```


## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fseekasia%2Fsahor-cookbooks.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fseekasia%2Fsahor-cookbooks?ref=badge_large)