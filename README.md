# minecraft-packer-ansible-terraform
Creation of a minecraft server using packer, ansible and terraform on scaleway

## Table of contents

* [General info](#general-info)
* [Deployment](#deployment)
* [Environment Variables](#environment-variables)
* [Packer](#packer)
* [Terraform](#terraform)
* [Systemd](#systemd)
* [Author Information](#author-information)


## General info
This project is using scaleway cloud service to create an instance with a running minecarft server.

We use Packer to create an image of our instance that runs the ansible list of commands.

Then we use Terraform to create an instance with the previously created image and runs the minecraft server.


## Deployment:

### Environment Variables
Create environment variables with API keys for packer and terraform:
```
# for packer
export SCW_DEFAULT_PROJECT_ID=<your organization id>
export SCALEWAY_API_TOKEN=<your scaleway api token>
export SCW_ACCESS_KEY=<your scaleway api token>
export SCW_SECRET_KEY=<your scaleway secret key>
```
### Packer:

This will run the packer.json file and create an image of the instance.

You need to be in the packer folder to use this.

```
cd ../packers/

packer build packer.json. 
```

### Ansible:

Make sure the ```minecraft-server.service``` file is in the same directory then what is written line 35 of the ``` /ansible/minecraft.yaml ``` file 

### Terraform:

These command will run terraform and use the previously created image to create the minecraft server and run it.

You need to be in the mc-server-launcher folder to use this.

```
cd ../mc-server-launcher

terraform init
terraform plan
terraform apply
```


### Systemd: 
Commande to control the minecraft server 
```
systemctl daemon-reload                         #Reload daemon (changes in the systemd folder)
systemctl start minecraft-server                #Start the minecraft server: 
systemctl status minecraft-server               #Check the status of the minecraft server: 
systemctl stop minecraft-server                 #Stop the minecraft server: 
nmap -p 25565 localhost                         #Check for the default Minecraft port: 
```
## Author Information:

NLM-fr

Contact: [nmougel4@gmail.com](mailto:nmougel4@gmail.com)
