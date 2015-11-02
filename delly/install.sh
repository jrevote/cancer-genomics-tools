#!/bin/bash

install_dir='/usr/local/tools'
tool_location='https://github.com/tobiasrausch/delly/releases/download/v0.7.1/delly_v0.7.1_linux_x86_64bit'
tool_name='delly'
md5='0bbf22b8f89ea523c0c02c7a1cab8143'

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
dependencies=(unzip wget)
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

if [ ! -f delly_v0.7.1_linux_x86_64bit ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 delly_v0.7.1_linux_x86_64bit
mkdir default
mv delly_v0.7.1_linux_x86_64bit default/delly
chmod a+x default/delly
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
