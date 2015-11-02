#!/bin/bash

install_dir='/usr/local/tools'
tool_location='https://github.com/vcftools/vcftools/releases/download/v0.1.14/vcftools-0.1.14.tar.gz'
tool_name='vcftools'
md5='a110662535651caa6cc8c876216a9f77'

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
dependencies=(wget gcc g++ zlib1g-dev pkg-config)
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

if [ ! -f vcftools-0.1.14.tar.gz ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 vcftools-0.1.14.tar.gz
tar xvzf vcftools-0.1.14.tar.gz
mv vcftools-0.1.14 default
cd default
./configure --prefix=$install_dir/$tool_name/default
make; make install

# Cleanup
cd ../
rm vcftools-0.1.14.tar.gz
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default/bin ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
