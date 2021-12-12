set -e 
DOCKER_COMPOSE_VERSION=1.29.2
REQS=ca-certificates curl gnupg lsb-release
DOCKER=docker-ce docker-ce-cli containerd.io
echo
echo "================================================================================"
echo
echo "Installing docker-ce
apt-get update -qq > /dev/null 
apt-get install -y -qq $REQS > /dev/null
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -qq > /dev/null
apt-get install -y -qq $DOCKER > /dev/null
echo
echo "================================================================================"
echo
echo "Installing docker-compose"
curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod 775 /usr/local/bin/docker-compose
echo
echo "================================================================================"
echo
echo "Following versions were installed:"
docker --version && docker-compose --version
echo
echo "================================================================================"
echo
echo "Add docker autostart to .bashrc"
echo "RUNNING=`ps auxf | grep dockerd | grep -v grep`" >> ~/.bashrc
echo "   if [ -z "$RUNNING" ]; then" >> ~/.bashrc
echo "      dockerd > /dev/null 2>&1 &" >> ~/.bashrc
echo "      disown" >> ~/.bashrc
echo "   fi" >> ~/.bashrc
echo "Finished"


