aws configure

Access key ID: XXXXXXXXXXXXXXXXXXX
Secret access key: XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Default region name [None]: us-east-1
Default output format [None]: json

	1. Security Groupların oluşturulması:

	aws ec2 create-security-group \
	    --group-name CLI_roman_number \
	    --description "This Sec Group is to allow ssh and http from anywhere"
	
	We can check the security Group with these commands:
	
	aws ec2 describe-security-groups --group-names CLI_roman_number
	
	You can check IPs with this command into the EC2:
	
	curl https://checkip.amazonaws.com

	2. Create Rules
	aws ec2 authorize-security-group-ingress \
	    --group-name CLI_roman_number \
	    --protocol tcp \
	    --port 22 \
	    --cidr 0.0.0.0/0

	aws ec2 authorize-security-group-ingress \
	    --group-name CLI_roman_number \
	    --protocol tcp \
	    --port 80 \
	    --cidr 0.0.0.0/0

	3. After creating security Groups, Well create our EC2s. Latest AMI id should be used.
	# AMI was ami-01cc34ab2709337aa in us-east-1
	
	Bu en son AMIyi bulmak için kullanılacak komuttur.
	- ilk olarak son ami bilgilerini çekelim.
	
	aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --region us-east-1

	- ikinci aşamada query çalıştırarak son ami numarasını parse edelim. 
	
	aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --region us-east-1 --query 'Parameters[0].[Value]' --output text

	- sonra bu değeri bir variable a atayalım:
	
	LATEST_AMI=$(aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --region us-east-1 --query 'Parameters[0].[Value]' --output text)

	- Calistigimiz cihazda userdata.sh scripti olusturalim.
	- Simdi de instance ı çalıştıralım: 

	# aws ec2 run-instances --image-id $LATEST_AMI --count 1 --instance-type t2.micro --key-name xxxxxxx --security-groups CLI_roman_number --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=roman_numbers}]' --user-data file:///Users/ODG/Desktop/git_dir/serdar-cw/porfolio_lesson_plan/week_6/CLI_solution/userdata.sh
	
	aws ec2 run-instances --image-id $LATEST_AMI --count 1 --instance-type t2.micro --key-name last_key_pair_211020 --security-groups CLI_roman_number --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=roman_numbers}]' --user-data file:///home/ec2-user/userdata.sh

veya

	aws ec2 run-instances \
	    --image-id $LATEST_AMI \
	    --count 1 \
	    --instance-type t2.micro \
	    --key-name xxxxxxxx \
	    --security-groups CLI_roman_number \
	    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=roman_numbers}]' \
	    --user-data file:///home/ec2-user/userdata.sh

	-  To see the each instances IP we\'ll use describe instance CLI command:

	aws ec2 describe-instances --filters "Name=tag:Name,Values=roman_numbers"

	- You can run the query to find Public IP and instance_id of instances:

	aws ec2 describe-instances --filters "Name=tag:Name,Values=roman_numbers" --query 'Reservations[].Instances[].PublicIpAddress[]'

	aws ec2 describe-instances --filters "Name=tag:Name,Values=roman_numbers" --query 'Reservations[].Instances[].InstanceId[]'

	4. To delete instances:

	aws ec2 terminate-instances --instance-ids xxxxxxxxxxxx

	5. To delete security groups:

	aws ec2 delete-security-group --group-name CLI_roman_number