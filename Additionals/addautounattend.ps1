# Create the autounattend iso

. .\New-IsoFile.ps1

# VMs
$VMs = @("DC1","DHCP","FSVR1")

# Variables
$Unattendxml = "H:\MakeADEnv\Autounattend\autounattend.xml"
$Unattendiso = "H:\VMs\$VM\autounattend.iso"
$VMPath = "H:\VMs\$VM"
$UnattendPath = "$VMPath\Autounattend\autounattned.xml"

# Create an autounattend iso
foreach($VM in $VMs){
    # Copy autounattend to VM folder
    New-Item -ItemType Directory "$VMPath\Autounattend\"
    Copy-Item -Path $Unattendxml -Destination "$VMPath\Autounattend\autounattend.xml"

    # Change computer name in the unattend file for each vm
    $XML = Get-Content "$VMPath\Autounattend\autounattend.xml"
    $XML.replace("SetNameHere", $VM) | Out-File $UnattendPath
    
    New-IsoFile -source $UnattendPath -destination $Unattendiso
    Add-VMDvdDrive -VMName $VM -Path $Unattendiso
}
