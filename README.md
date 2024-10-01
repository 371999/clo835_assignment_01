# 170994230_clo835_assignment_01

Step 1: Deploy the Infrastructure.

#Navigate to clo835_assignment_01/terraform_config/dev/instances

Commands:
#1: alias tf=terraform
#2: tf init
#3: tf fmt
#4: tf validate
#5: tf plan
#6: tf apply --auto-approve


Step 2: Trigger the Workflow.

#Navigate to clo835_assignment_01
#Switch to dev branch

Commands:
#1: git commit --allow-empty -m "Trigger GitHub Actions workflow"
#2: git push origin dev

#Create a pull request from "dev" to "main".
#Confirm merge request.


Step 3: Login to EC2 and make configurations.

#Navigate to clo835_assignment_01/terraform_config/dev/instances

Commands:
#1: ssh -i week_04_dev <elastic_ip_of_ec2>
#2: sudo yum update -y
#3: sudo yum install docker -y
#4.1: sudo systemctl start docker
#4.2: sudo systemctl status docker
#5: docker --version
#6: sudo usermod -a -G docker ec2-user
#7: docker info


#If docker info command does not respond then -> restart ssh session.
#To restart first run (#1) exit, (#2)ssh -i week_04_dev <elastic_ip_of_ec2>, and (#3) docker info


#docker info should run this time. If not -> restart again.

#8: aws ecr describe-repositories

#If system prompt to set region. Follow the below commands.

#9.1: aws configure #(Now, enter AWS Access Key ID, Secret Access Key, and default region name as "us-east-1". Leave default output format empty)
#9.2: vi ~/.aws/credentials (ENTER aws access key id, secret access key, and session token)
#9.3: cat ~/.aws/credentials
#9.4: aws ecr get-login-password --region us-east-1 | docker login -u AWS 835512929652.dkr.ecr.us-east-1.amazonaws.com/clo835_week_04_assignment_01_db --password-stdin


#10: docker network create clo_835_assignment_01_network
#11: docker network ls
#12: docker inspect <network_id_of_clo_835_assignment_01_network>
#13: docker run -d -e MYSQL_ROOT_PASSWORD=db_clo835 --name mysql-db --network clo_835_assignment_01_network 835512929652.dkr.ecr.us-east-1.amazonaws.com/clo835_week_04_assignment_01_db:v1.0
#14: docker ps


#15: docker run -d -p 8081:8080 -e APP_COLOR=blue -e DBPORT=3306 -e DBHOST=mysql-db -e dbuser=root -e DBPWD=db_clo835 --network clo_835_assignment_01_network --name blue_app 835512929652.dkr.ecr.us-east-1.amazonaws.com/clo835_week_04_assignment_01_app:v1.0
#16: docker ps
#17: docker run -d -p 8082:8080 -e APP_COLOR=pink -e DBPORT=3306 -e DBHOST=mysql-db -e dbuser=root -e DBPWD=db_clo835 --network clo_835_assignment_01_network --name pink_app 835512929652.dkr.ecr.us-east-1.amazonaws.com/clo835_week_04_assignment_01_app:v1.0
#18: docker run -d -p 8083:8080 -e APP_COLOR=lime -e DBPORT=3306 -e DBHOST=mysql-db -e dbuser=root -e DBPWD=db_clo835 --network clo_835_assignment_01_network --name lime_app 835512929652.dkr.ecr.us-east-1.amazonaws.com/clo835_week_04_assignment_01_app:v1.0
#19: docker ps


#20: docker exec -it <mysql_container_id> bash
#20.1: mysql -pdb_clo835
#20.2: use employees;
#20.3: select * from employee;
#20.4: exit
#20.5: exit

#21: docker ps
#22: docker exec -it <blue_app_container_id> bash
#22.1: apt-get install iputils-ping -y
#22.2: ping -c 4 pink_app
#22.3: ping -c 4 lime_app
#22.4: exit

#Copy elastic_ip of EC2.
#Open 3 new tabs in browser and navigate to <EC2_elastic_ip>:8081, <EC2_elastic_ip>:8082, and <EC2_elastic_ip>:8083.

#Make small change in "addemp.html". (Hint: You can add some text as paragraph or heading.)
#Change version in "ecr.yml" from "v1.0" to "v2.0".
#Check git status, and make a commit.

Command:
#1: git commit -am "Update to version 2.0"
#2: git push origin dev

#Make a pull request. Confirm the merge.


## After Workflow Succeed: ##

Command:
#1: docker stop <blue_app_container_id>
#2: docker rm <blue_app_container_id>
#3: docker run -d -p 8081:8080 -e APP_COLOR=blue -e DBPORT=3306 -e DBHOST=mysql-db -e dbuser=root -e DBPWD=db_clo835 --network clo_835_assignment_01_network --name blue_app 835512929652.dkr.ecr.us-east-1.amazonaws.com/clo835_week_04_assignment_01_app:v2.0
