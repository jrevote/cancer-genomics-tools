#!/bin/bash

install_dir='/usr/local/tools'
tool_location='http://sourceforge.net/projects/samtools/files/tabix/tabix-0.2.6.tar.bz2'
tool_name='tabix'
md5='36a61ceac2f5bed36018434282bbcc5d'

function md5check {
  md5sum -c - <<< "$1  $2"
  if [ $? -ne 0 ]; then
    echo "MD5 mismatch on downloaded file, exiting ..."
    exit
  fi
}

##################
## Dependencies ##
##################
dependencies=(wget gcc zlib1g-dev)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

###########
## Delly ##
###########
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f tabix-0.2.6.tar.bz2 ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 tabix-0.2.6.tar.bz2
tar xvjf tabix-0.2.6.tar.bz2
mv tabix-0.2.6 default
cd default
make

# Cleanup
cd ../
rm tabix-0.2.6.tar.bz2
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
