#!/bin/bash
#
#usage:
# curl -O https://raw.githubusercontent.com/kiperos/waltos/master/zipo.sh && chmod +x zipo.sh && ./zipo.sh

##############################################################################################################
spinner ()
{
    bar=" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    barlength=${#bar}
    i=0
    while ((i < 100)); do
        n=$((i*barlength / 100))
        printf "\e[00;34m\r[%-${barlength}s]\e[00m" "${bar:0:n}"
        ((i += RANDOM%5+2))
        sleep 0.02
    done
}
##############################################################################################################
archivepassword=$(cat /root/archivepass.txt)
##############################################################################################################

# Installing Dependencies
# Needed Prerequesites will be set up here
install_dep(){
   clear
   f_banner
   echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
   echo -e "\e[93m[+]\e[00m Setting some Prerequisites"
   echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
   echo ""
   spinner
   yum install sudo
   sudo yum -y install epel-release
   sudo yum -y update
   sudo yum -y clean all
   sudo yum -y install p7zip p7zip-plugins
   sudo yum -y install pwgen
   say_done
}

##############################################################################################################
# Update System
update_system(){
   clear
   f_banner
   echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
   echo -e "\e[93m[+]\e[00m Updating the System"
   echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
   echo ""
   yum -y update
   yum -y upgrade
   #yum -y dist-upgrade
   say_done
}
##############################################################################################################
# Show "Done."
function say_done() {
    echo " "
    echo -e "Done."
    yes "" | say_continue
}

##############################################################################################################
# Ask to Continue
function say_continue() {
    echo -n " To EXIT Press x Key, Press ENTER to Continue"
    read acc
    if [ "$acc" == "x" ]; then
        exit
    fi
    echo " "
}
##############################################################################################################
# Show "Done."
function say_done_2() {
    echo " "
    echo -e "Done."
    say_continue_2
}
##############################################################################################################
# Ask to Continue
function say_continue_2() {
    echo -n " To EXIT Press x Key, Press ENTER to Continue"
    read acc
    if [ "$acc" == "x" ]; then
        exit
    fi
    echo " "
}
##############################################################################################################
f_banner(){
echo
echo "
 ____ _ ___    ____ _  _ ___ ____   ____ ____ ___ _  _ ___ 
 ==== | |==]   |--| |__|  |  [__]   ==== |===  |  |__| |--'
|     .-.
|    /   \         .-.
|   /     \       /   \       .-.     .-.     _   _
+--/-------\-----/-----\-----/---\---/---\---/-\-/-\/\/---
| /         \   /       \   /     '-'     '-'
|/           '-'         '-'
"
echo
echo

}


##############################################################################################################
#Download archive

download_axx(){
clear
  f_banner
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo -e "\e[93m[+]\e[00m Downloading Archive"
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo ""
cd
curl -O https://raw.githubusercontent.com/kiperos/waltos/master/axx.7z
}

##############################################################################################################

#Extract archive
extract_axx(){
clear
  f_banner
  
 ARCHIVEPASS=/root/archivepass.txt
if [ -f $ARCHIVEPASS ]; then
  
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo -e "\e[93m[+]\e[00m Extract axx"
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo ""
  
  7z x axx.7z -p$archivepassword; echo "extract archive OK"
  
 else 
  echo ""
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo -e "\e[93m[+]\e[00m Extract axx archive. File with archive password doesn't exist. Please Enter Your Password!"
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo ""
  echo -n " Please Enter Your Password: "; read -s archivepassword2
  #cd a1
  7z x axx.7z -p$archivepassword2; echo "extract archive OK"
  #rm -f a1.7z; echo "remove archive OK"
  #cd ..
  echo " OK"
  fi
say_done
}

##############################################################################################################

update_system
install_dep
download_axx
ls
sleep 1
extract_axx
mv /root/axx/axx.x /usr/local/bin/axx
chmod +x /usr/local/bin/axx
axx
