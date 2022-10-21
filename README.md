# Active Directory Make Environment

##### Created by D0nkeyk0ng787

### About

This script is designed to create an Active Directory environment with very little pre-configuration and essentially zero interaction. 

This script uses a few functions from other developers. Namely the NewISO function updated by Alisatir McNair and originally developed by Chris Wu.

### Compatability

In my testing I used Windows server core 2022 and Windows 10 for the client. These are the issues of Windows that are currently support by the unattend file.

### Requirements

It is recommended to make a seperate partition to store this script, ISOs and the VMs on. This is entirely necessary, however, you will need to adjust the config file to specify the location of your ISOs and where your VMs are to be installed.

This script is fairly resource intensive. Hardware requires are ideally an SSD and 32GB of RAM.

### Usage

There are a few files that need to be configured before use:

##### config.ps1
The config file contains most of the customisable features of this script. Domain name, IP range, DHCP scope, install paths, credentials etc can be configured here. 
##### vmsconfig.csv
This csv file contains the configurations for each vm. This script is designed to support the creation of unlimited VMs. (Although currently it won't setup unlimited VMs. That is something I still need ).
##### adenv.ps1
Currently the Organisational Units are created inside the adenv.ps1 file. These can be changed to meet your requirements from this file until I bother to move them to the config.

### TODO

* [ ] Implement an additional DC
* [ ] Add the ability to install Windows on as many systems as specified
* [ ] Add OU template to the config file
* [ ] Add some features to make it a little less resource intensive
* [ ] Add the wallpaper gpo
