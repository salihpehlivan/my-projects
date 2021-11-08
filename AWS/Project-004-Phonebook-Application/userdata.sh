        UserData: 
          Fn::Base64:  
            !Sub |
              #!/bin/bash
              yum update -y
              yum install git -y
              git clone https://github.com/salihpehlivan/my-projects.git
              mkdir /home/ec2-user/phonebookdir
              cp -R my-projects/AWS/Project-004-Phonebook-Application/* /home/ec2-user/phonebookdir
              cd /home/ec2-user/phonebookdir
              sudo pip3 install flask
              sudo pip3 install flask-mysql
              export DB_CONNECTION="${myDB.Endpoint.Address}"
              echo $DB_CONNECTION > /home/ec2-user/dbserver.endpoint
              sudo python3 /home/ec2-user/phonebookdir/phonebook-app.py

Note: 
-	!Sub must be used to force EC2 to wait DB`s creation to learn DB`s endpoint name
-	learn DB endpoint and save it in dbserver.endpoint file. phonebook-app.py will check DB`s hostname from this file.
-	database clarusway_phonebook should be created while creating MySQL instance
		DBName: clarusway_phonebook