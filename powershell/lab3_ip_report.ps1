function ip-report {
    "Network Adapter Information"
    get-ciminstance win32_networkadapterconfiguration | where { $_.IPEnabled -eq $True } | 
    format-table Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder -AutoSize
}