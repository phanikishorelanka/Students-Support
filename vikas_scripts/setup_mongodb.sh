cd /etc/yum.repos.d/
wget https://raw.githubusercontent.com/phanikishorelanka/docker-k8s-pklanka/master/mongo.repo
cp /etc/security/limits.conf /etc/security/limits.conf.orig
echo mongod soft nofile 64000  >>/etc/security/limits.conf
mongod hard nofile 64000 >>/etc/security/limits.conf
sysctl -p

yum -y install mongodb-org

echo "testing Mongo db status"
mongo < sample.js

