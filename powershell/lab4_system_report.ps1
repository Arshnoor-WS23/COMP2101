function system_hardware_description {
    "System Hardware Description"
    gwmi win32_computersystem | select name, manufacturer, model, totalphysicalmemory, description | format-list
}

function operating_system {
    "Operating System"
    gwmi win32_operatingsystem | select name, version | format-list
}

function processor_description {
    "Processor Description"
    gwmi win32_processor | select name, numberofcores, currectclockspeed, maxclockspeed,
    @{
        n = "L1CacheSize";
        e = {
            switch ($_.L1CacheSize) {
                $null { $data = "data unavailable" }
                Default { $data = $_.L1CacheSize }
            };
            $data
        }
    },
    @{
        n = "L2CacheSize";
        e = {
            switch ($_.L2CacheSize) {
                $null { $data = "data unavailable" }
                Default { $data = $_.L2CacheSize }
            };
            $data
        }
    },
    @{
        n = "L3CacheSize";
        e = {
            switch ($_.L3CacheSize) {
                $null { $data = "data unavailable" }
                Default { $data = $_.L3CacheSize }
            };
            $data
        }
    } | format-list
}

function ram {
    "RAM"
    $phymem = get-CimInstance win32_PhysicalMemory | select description, manufacturer, banklabel, devicelocator, capacity
    $phymem | format-table
    $total = 0
	foreach ($pm in $phymem) {$total = $total + $pm.capacity}
	$total = $total / 1GB
    write-output "RAM : $total GB"
}

function physical_disk {
    "Physical Disk"
    $diskdrives = Get-CIMInstance CIM_diskdrive | where DeviceID -ne $null

    foreach ($disk in $diskdrives) {
        $partitions = $disk | get-cimassociatedinstance -resultclassname CIM_diskpartition
        foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                new-object -typename psobject -property @{
                    Model          = $disk.Model
                    Manufacturer   = $disk.Manufacturer
                    Location       = $partition.deviceid
                    Drive          = $logicaldisk.deviceid
                    "Size(GB)"     = [string]($logicaldisk.size / 1gb -as [int]) + "gb"
                    FreeSpace      = [string]($logicaldisk.FreeSpace / 1gb -as [int]) + "gb"
                    "FreeSpace(%)" = [string]((($logicaldisk.FreeSpace / $logicaldisk.size) * 100) -as [int])                     + "%"
                } | format-table -AutoSize
            }
        }
    }
}

function ip_report {
    "Network Adapter"
    get-ciminstance win32_networkadapterconfiguration | where { $_.IPEnabled -eq $True } | 
    format-table Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder -AutoSize
}

function video_card {
    "Video Card"
    get-ciminstance win32_videocontroller | select description, caption, currenthorizontalresolution, currentverticalresolution
    $h = $obj.currenthorizontalresolution
    $v = $obj.currentverticalresolution
    $resolution = "$h x $v"
    $resolution
}


"System Information"
system_hardware_description
operating_system
processor_description 
ram
physical_disk 
ip_report 
video_card 