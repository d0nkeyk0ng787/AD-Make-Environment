# Active Directory Make Environment

##### Created by D0nkeyk0ng787

### About

![GitHub](https://camo.githubusercontent.com/3dbcfa4997505c80ef928681b291d33ecfac2dabf563eb742bb3e269a5af909c/68747470733a2f2f696d672e736869656c64732e696f2f6769746875622f6c6963656e73652f496c65726961796f2f6d61726b646f776e2d6261646765733f7374796c653d666f722d7468652d6261646765) ![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white)

This script is designed to create an Active Directory environment with very little pre-configuration and essentially zero interaction. 

This script uses a few functions from other developers. Namely the NewISO function updated by Alisatir McNair and originally developed by Chris Wu.

### Compatability

This script will only work with Hyper-V. It is not compatable with any other hypervisor.

In my testing I used Windows server core 2022 and Windows 10 for the client. These are the issues of Windows that are currently supported by the autounattend files. You can try with other editions of Windows, however, you may need to change the autounattend files.

### Requirements

It is recommended to make a seperate partition to store this script, ISOs and the VMs on. This isn't entirely necessary, however, you will need to adjust the config file to specify the location of your ISOs and where your VMs are to be installed.

This script is fairly resource intensive. Hardware requirements are ideally an SSD with a minimum of 150GB and 32GB of RAM.

### Usage

There are a few files that need to be configured before use:

##### config.ps1
The config file contains most of the customisable features of this script. Domain name, IP range, DHCP scope, install paths, credentials etc can be configured here. Organisational Units are specified in the config. Simply modify the exisiting (or add additional) **PSCustomObjects** and then add the object name to the OUs list below the **PSCustomObjects**.
##### vmsconfig.csv
This csv file contains the configurations for each vm. This script is designed to support the creation of unlimited VMs. (Although currently it won't setup unlimited VMs. That is something I still need implement.)

### TODO

* [ ] Implement an additional DC
* [ ] Add the ability to install Windows on as many systems as specified
* [ ] Add some features to make it a little less resource intensive
* [ ] Add the wallpaper gpo to the DC, including uploading an image to use.
