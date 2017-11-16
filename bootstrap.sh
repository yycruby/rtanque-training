  #!/bin/bash
set -x; #echo on

#Ruby dependencies (https://gorails.com/setup/ubuntu/17.10):
sudo apt-get update

sudo apt-get install -q -y htop git jq;

#Add a GUI
sudo apt-get install -q -y xorg gnome-core gnome-system-tools gnome-app-install

sudo apt-get install -q -y git-core curl zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libffi-dev openssl
sudo apt-get install -q -y build-essential libsdl2-dev libsdl2-ttf-dev libpango1.0-dev libgl1-mesa-dev libopenal-dev libsndfile-dev libmpg123-dev libgmp-dev
sudo apt-get autoremove
sudo apt-get clean

cd
wget http://ftp.ruby-lang.org/pub/ruby/2.3/ruby-2.3.5.tar.gz
tar -xzvf ruby-2.3.5.tar.gz
cd ruby-2.3.5/
./configure
make
sudo make install
ruby -v
rm ruby-2.3.5.tar.gz

sudo gem install bundler --no-ri --no-rdoc



#Gosu dependencies ():
sudo apt-get install -q -y libsdl2-dev libsdl2-ttf-dev libpango1.0-dev libgl1-mesa-dev libfreeimage-dev libopenal-dev libsndfile-dev
#texplay dependencies:
sudo apt-get install -q -y freeglut3-dev

cd /vagrant;
bundler install;
