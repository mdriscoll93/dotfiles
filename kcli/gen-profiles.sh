#!/bin/bash

file="/root/kcli_profiles.yml"
# check if kcli script is available
if [ -z $(which kcli) ] ; then echo "Please install kcli"; exit ; fi
# check if the profiles file exists
if [ -e ${file} ] ; then rm -i ${file} ; else echo "Exit"; exit ; fi
# Place the profiles file
cat << EOF > ${file}
xsmall:
 template: CentOS-7-x86_64-GenericCloud.qcow2
 numcpus: 1
 memory: 256
 nets:
  - default
 pool: default
 cmds:
  - echo testtest| passwd --stdin root
  - yum -y install nmap

small:
 template: CentOS-7-x86_64-GenericCloud.qcow2
 numcpus: 1
 memory: 512
 nets:
  - default
 cmds:
  - echo testtest| passwd --stdin root
  - yum -y install nmap

medium:
 template: CentOS-7-x86_64-GenericCloud.qcow2
 numcpus: 1
 memory: 1024
 nets:
  - default
 disks:
  - size: 16
 cmds:
  - echo testtest| passwd --stdin root
  - yum -y install nmap

big:
 template: CentOS-7-x86_64-GenericCloud.qcow2
 numcpus: 2
 memory: 2048
 nets:
  - default
 disks:
  - size: 32
 cmds:
  - echo testtest| passwd --stdin root
  - yum -y install nmap

xbig:
 template: CentOS-7-x86_64-GenericCloud.qcow2
 numcpus: 2
 memory: 3072
 nets:
  - default
 disks:
  - size: 32
 cmds:
  - echo testtest| passwd --stdin root
  - yum -y install nmap

xxbig:
 template: CentOS-7-x86_64-GenericCloud.qcow2
 numcpus: 4
 memory: 4096
 nets:
  - default
 disks:
  - size: 32
 cmds:
  - echo testtest| passwd --stdin root
  - yum -y install nmap
EOF