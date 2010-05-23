# From http://blogs.msdn.com/powershell/archive/2010/05/07/smiling-crying-and-scripting.aspx 
param($MacAddress) 
[byte[]] $MagicPacket = 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
$MagicPacket += (($MacAddress.split(':') | foreach {[byte] ('0x' + $_)}) * 16)
$UdpClient = New-Object System.Net.Sockets.UdpClient
$UdpClient.Connect(([System.Net.IPAddress]::Broadcast), 9)
$UdpClient.Send($MagicPacket,$MagicPacket.length)
