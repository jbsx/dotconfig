nmcli connection add type wifi con-name eduroam ifname wlp3s0 ssid eduroa
m
nmcli connection modify eduroam wifi-sec.key-mgmt wpa-eap 802-1x.eap peap 802-1x.phase2-auth mschapv2 802-1x.identity \"33139652@student.uwl.ac.uk\" 802-1x.password \"<Password>"
