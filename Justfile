# [[file:README.org::*Just][Just:1]]
# generates SSH keys

ssproject := `tomlq '.project.name' secretspec.toml`
ssdevmach := 'devmach'
ssdevmachfiles := ".secrets/" + ssproject + "/" + ssdevmach

ss-mach-check:
    secretspec check --profile "{{ ssdevmach }}"
ss-mach-pubgen:
    ssh-keygen -y -f "{{ ssdevmachfiles }}/MACH_INSTALL_KEY" >  "{{ ssdevmachfiles }}/MACH_INSTALL_KEY.pub"
    ssh-keygen -y -f "{{ ssdevmachfiles }}/MACH_DEPLOY_KEY" >  "{{ ssdevmachfiles }}/MACH_DEPLOY_KEY.pub"

uartdt:=`date +%Y%m%d-%H%M%S`
uarttype:='uart'

# foo dt=uartdt type=uarttype:
#      @echo log/uart/{{type}}.{{dt}}.log

# reboot with `reset`

baud := '1500000'
ttydev := 'USB0'
uart-mini type=uarttype dt=uartdt:
    minicom -b "{{ baud }}" -D "/dev/tty{{ ttydev }}" -C "log/uart/{{ type }}.{{ dt }}.log"

uart-screen type=uarttype dt=uartdt:
    screen -L -Logfile "log/uart/{{ type }}.{{ dt }}.log" "/dev/tty{{ ttydev }}" "{{ baud }}"
# Just:1 ends here
