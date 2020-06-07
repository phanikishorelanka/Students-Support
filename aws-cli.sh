######################################################

echo ====Creating working directory====
mkdir -p ~/aws_work

echo ========Installing python 3.6=====
sudo yum install dnf
sudo yum install python36

echo =======Creaing Virtual Environment and activating it=========
python36 -m venv ~/aws_work/
#source aws_work/bin/activate

echo ========Installing PIP and upgrade========
python36 -m pip install --user --upgrade pip

echo =======Installing aws cli===========
pip3 install requests awscli certifi boto3 bs4 requests-ntlm wheel

echo ========CLI version=====
aws --version
