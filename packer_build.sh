#!/bin/sh

if [ ! -d windows ]
then
  git clone https://github.com/boxcutter/windows
fi 

WIN10_KEY=`cat $HOME/ISO/keys.json | jq -r '.[] | select(.Product=="Windows 10 Pro") | .Key'`
WIN2012R2_KEY=`cat $HOME/ISO/keys.json | jq -r '.[] | select(.Product=="Windows Server 2012 R2") | .Key'`
WIN2016_KEY=`cat $HOME/ISO/keys.json | jq -r '.[] | select(.Product=="Windows Server 2016") | .Key'`

echo Using Windows 10 Pro Key: $WIN10_KEY
echo Using Windows 2012 R2 Key: $WIN2012R2_KEY
echo Using Windows 2016 Key: $WIN2016_KEY

cd windows

## The checksums are calculated using shasum -a 1 {filename}

cat <<EOF > Makefile.local
# CM := puppet

# sha1 checksums
WIN2016_X64 := file:////Users/shaw.innes/ISO/en_windows_server_2016_updated_feb_2018_x64_dvd_11636692.iso
WIN2016_X64_CHECKSUM := 7adc82e00f1367b43897bb969a75bbf96d46f588

WIN2012R2_X64 := file:////Users/shaw.innes/ISO/en_windows_server_2012_r2_with_update_x64_dvd_6052708.iso
WIN2012R2_X64_CHECKSUM := 865494e969704be1c4496d8614314361d025775e

EVAL_WIN10_X64 ?= file:///Users/shaw.innes/ISO/en_windows_10_business_editions_version_1909_x64_dvd_ada535d0.iso
EVAL_WIN10_X64_CHECKSUM := 735226c61b36a29d48e1f56e3b0bc28b2384bc55

HEADLESS := false
EOF

git checkout floppy/win2012r2-standard/Autounattend.xml
sed -i.bak "s/<Key>D2N9P-3P6X9-2R39C-7RTCD-MDVJX<\/Key>/<Key>$WIN2012R2_KEY<\/Key>/g" floppy/win2012r2-standard/Autounattend.xml

git checkout floppy/win2016-standard/Autounattend.xml
sed -i.bak "s/<Key>D2N9P-3P6X9-2R39C-7RTCD-MDVJX<\/Key>/<Key>$WIN2016_KEY<\/Key>/g" floppy/win2016-standard/Autounattend.xml

git checkout floppy/eval-win10x64-enterprise/Autounattend.xml
sed -i.bak "s/NPPR9-FWDCX-D2C8J-H872K-2YT43/<Key>$WIN10_KEY<\/Key>/g" floppy/eval-win10x64-enterprise/Autounattend.xml
sed -i.bak "s/<Value>Windows 10 Enterprise Evaluation<\/Value>/<Value>Windows 10 Pro<\/Value>/g" floppy/eval-win10x64-enterprise/Autounattend.xml

# make vmware/win2016-standard
# make virtualbox/win2016-standard
# vagrant box add --name win2016 box/vmware/win2016-standard-puppet-1.0.4.box

# make virtualbox/win2012r2-standard
# vagrant box add --name win2012r2 box/vmware/win2012r2-standard-puppet-1.0.4.box

export PACKER_LOG=1
make vmware/eval-win10x64-enterprise
vagrant box add --name win10 box/vmware/eval-win10x64-enterprise-nocm-1.0.4.box

echo if you get an error about duplicate entries in "CPUM/CMPXCHG16B" remove the following "setextadata" section from the packer json files

