#new-item -path alias:np -value notepad | out-null

#function welcome {
#	write-output "Welcome to planet $env:computername Overlord $env:username"
#	$now = get-date -format 'HH:MM tt on dddd'
#	write-output "It is $now."
#}

#function get-cpuinfo {
#	Get-CimInstance -ClassName CIM_Processor | fl Name, Caption, Manufacturer, CurrentClockSpeed, MaxClockSpeed, NumberOfCores
#}

#function get-mydisks {
#	Get-PhysicalDisk | ft Manufacturer, Model, SerialNumber, FirmwareRevision, Size
#}

#welcome
#get-cpuinfo
#get-mydisks