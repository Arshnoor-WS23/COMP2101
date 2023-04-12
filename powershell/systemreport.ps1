Param ([Parameter (Mandatory=$false)][switch]$system,
       [Parameter (Mandatory=$false)][switch]$disks,
       [Parameter (Mandatory=$false)][switch]$network )


if($system) {
	system_hardware_description
	operating_system
	processor_description
	ram
	video_card 
}
elseif($disks) {
	physical_disk
}
elseif($network) {
	ip_report
}
else {
	system_hardware_description
	operating_system
	processor_description
	ram
	physical_disk 
	ip_report 
	video_card 
}