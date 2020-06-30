{
:local i 0
#Number of interfaces. It is necessary to reconfigure this number for each device (/interface print count-only)
:local x 2
#Max time to wait
:local t 10
while ($i < $t && [:len [/interface find]] < $x) do={
:put $i
:set $i ($i + 1)
:delay 1
}
if ($i = $t) do={
:log warning message="Could not load all physical interfaces"
} else={
# COPIE SU SCRIPT AQUI 
/tr069-client
set acs-url=http://soporte.wificiudad.com:20050 enabled=yes periodic-inform-interval=10s provisioning-code=NUEVO
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface sstp-client
add authentication=chap,mschap1,mschap2 connect-to=mikrotik.wificiudad.com disabled=no name=nuevocliente password=enlacE15@ profile=default-encryption user=wcnuevocliente
/ip dhcp-client
add disabled=no interface=ether1
/ip dns
set allow-remote-requests=yes servers=34.73.15.232,34.73.15.232
/ip firewall nat
add action=masquerade chain=srcnat comment=INTERNET out-interface=ether1
/system clock
set time-zone-autodetect=no time-zone-name=America/Bogota
/system identity
set name=NUEVO
/system ntp client
set enabled=yes primary-ntp=204.93.207.12 secondary-ntp=34.194.39.113
/tool e-mail
set address=74.125.139.109 from=wificiudad@gmail.com password=plvcaiooqlmphpnz port=587 start-tls=yes user=wificiudad@gmail.com
/tr069-client
set acs-url=http://soporte.wificiudad.com:20050 enabled=yes periodic-inform-interval=10s provisioning-code=NUEVO
/ip dhcp-client
}
}