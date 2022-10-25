# Demo - Webapp - Tetris 

## Demo Overview

A Static Website containing a JavaScript based Tetris game, deployed on Cloud Based simple storage service. Showcase Torque's ability to orchestrate deployment of a simple static storage based website on different Cloud Providers and using different technologies. 

> Due to the simple nature of the deployed infrastructure, this demo deploys extremely quickly and is very useful for quick demonstrations.

### Variants
- Webgame on S3 (TF)
- Webgame on S3 (CFN + TF)
- Webgame on Azure Storage (TF)

## Demo Procedure

### 1. Login

1. Navigate to the following URL `https://portal.qtorque.io/login`

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/197870923-deaaa125-4435-4feb-b3fe-0e3fb5a688a6.png">
</p>

Here you can utilize one of 3 methods to login. 
1. You can utilize `Basic Authentication` with Username and Password
2. You can use `Federated` account access via Github or Gitlab
3. You can utilze `Single Sign-On`

Select one of the methods for authentication. 

------

### 2. Environment Dashboard

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/197872674-b4e574fe-4f97-4872-8ab5-c78e1b95d203.png">
</p>

The SaaS application utilizes Role Based Access Control (RBAC) to determine the view configuration. There are several items that will be subject to the role used to login to the active session. 

1. Accounts. If a user is provisioned mulitple accounts, then this suite of account access is provided in a drop down view. 

<p align="center">
<img width="150" alt="image" src="https://user-images.githubusercontent.com/8760590/197873315-adc4ff04-813f-41fd-9ea7-5d29d9e52fb6.png">
</p>

> This feature ensures that in instances where there is structured hierarchy of access to possibly different clients or different accounts across multiple teams that access can be provisioned accordingly. 

2. Spaces. If a user needs to be provisioned access to a particular environment where other environments need to be concealed this can also be enabled. 

<p align="center">
<img width="150" alt="image" src="https://user-images.githubusercontent.com/8760590/197873932-a0f015ae-4094-4aeb-8c36-fe57c0b3d8dd.png">
</p>

3. Privledges. If a user is an Admin vs. a Member the view will be represented here. 

<p align="center">
<img width="150" alt="image" src="https://user-images.githubusercontent.com/8760590/197874628-b0a4c76f-920e-4799-a861-b07a9e92795b.png">
</p>



