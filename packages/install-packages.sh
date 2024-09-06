#Uses centos OS.
#install ansible 
python3 -m ensurepip --upgrade
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install --include-deps ansible
pip install kubernetes

#install kubectl
sudo yum install -y curl gnupg
sudo tee /etc/yum.repos.d/kubernetes.repo <<EOF
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/Release.key
EOF
sudo yum makecache
sudo yum install -y kubectl-1.30.1-150500.1.1

#install terraform
curl -LO https://releases.hashicorp.com/terraform/1.6.5/terraform_1.6.5_linux_amd64.zip
unzip terraform_1.6.5_linux_amd64.zip 
sudo mv terraform /usr/local/bin

#install awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip "awscliv2.zip"
./aws/install

#install git
sudo yum install -y git

#install helm
