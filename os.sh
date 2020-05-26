#!/bin/bash

get_os() {
  if [ "$(uname)" == 'Darwin' ]; then
    OS='mac'
  elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    get_os_distribution
  elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then                                                                                           
    OS='cygwin'
  else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
  fi
}
get_os_distribution() {
  if [ -e /etc/debian_version ] ||
     [ -e /etc/debian_release ]; then
    # Check Ubuntu or Debian
    if [ -e /etc/lsb-release ]; then
      # Ubuntu
      OS="ubuntu"
    else
      # Debian
      OS="debian"
    fi
  elif [ -e /etc/fedora-release ]; then
    # Fedra
    OS="fedora"
  elif [ -e /etc/redhat-release ]; then
    if [ -e /etc/oracle-release ]; then
      # Oracle Linux
      OS="oracle"
    else
        # Red Hat Enterprise Linux
      OS="redhat"
    fi
  elif [ -e /etc/arch-release ]; then
    # Arch Linux
    OS="arch"
  elif [ -e /etc/turbolinux-release ]; then
    # Turbolinux
    OS="turbol"
  elif [ -e /etc/SuSE-release ]; then
    # SuSE Linux
    OS="suse"
  elif [ -e /etc/mandriva-release ]; then
    # Mandriva Linux
    OS="mandriva"
  elif [ -e /etc/vine-release ]; then
    # Vine Linux
    OS="vine"
  elif [ -e /etc/gentoo-release ]; then
    # Gentoo Linux
    OS="gentoo"
  else
    # Other
    OS="unkown Linux Distribution"
  fi
}
