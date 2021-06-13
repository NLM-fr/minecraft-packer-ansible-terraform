# minecraft-packer-ansible-terraform
Creation of a minecraft server using packer, ansible and terraform


Here is a list of commande to use:

Packer:

packer build packer.json. 

This will run the packer.json file and create an image of the instance 


Terraform:

terraform init 
terraform plan
terraform apply

These command will run terraform and use the previously created image to create the minecraft server and run it 

Ansible: 

systemctl daemon-reload                         #Reload daemon (changes in the systemd folder)
systemctl start minecraft-server                #Start the minecraft server: 
systemctl status minecraft-server               #Check the status of the minecraft server: 
systemctl stop minecraft-server                 #Stop the minecraft server: 
nmap -p 25565 localhost                         #Check for the default Minecraft port: 
