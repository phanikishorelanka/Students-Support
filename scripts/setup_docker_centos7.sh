#script for setting docker 
#script owner - phanikishorelanka@gmail.com

#setup oracle vm virtualbox
wget https://download.virtualbox.org/virtualbox/5.2.22/VirtualBox-5.2-5.2.22_126460_el7-1.x86_64.rpm
rpm -ivh VirtualBox-5.2-5.2.22_126460_el7-1.x86_64.rpm


#setup docker 

yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum-config-manager --enable docker-ce-edge

yum-config-manager --enable docker-ce-test

yum -y install docker-ce 

sudo systemctl start docker

echo "setting docker at system startup"

chkconfig docker on 
