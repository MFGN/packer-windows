#packer-windows
Packer templates and scripts for VMware ESXi and WorkStation using pvscsi and vmxnet3 adapters.

These should be considered a work in progress, and are varying states of completeness.

##files
These disk images, which are available in the VMware workstation directory, are needed to extract the virtualized adapters and tools executables.

* pvscsi_Windows2008.flp
* windows.iso

Follow VMwares [instructions](http://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=2032184) to extract the vmxnet3 drivers, and use the pvsci drivers from the flp image.

