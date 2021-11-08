userdata:

yum update -y
yum install git -y
git clone https://github.com/salihpehlivan/my-projects.git
mkdir /home/ec2-user/phonebookdir
cp -R my-projects/AWS/Project-004-Phonebook-Application/* /home/ec2-user/phonebookdir
cd /home/ec2-user/phonebookdir
sudo pip3 install flask
sudo pip3 install flask-mysql
