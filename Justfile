# [[file:README.org::*Just][Just:1]]
# generates SSH keys

ssproject := `tomlq '.project.name' secretspec.toml`
ssdevmach := 'devmach'
ssdevmachfiles := ".secrets/" + ssproject + "/" + ssdevmach

# ..... just logged swapping the host keys lol ... and i guess passwords =/
ss-mach-check:
    secretspec check --profile "{{ ssdevmach }}"
ss-mach-pubgen:
    ssh-keygen -y -f "{{ ssdevmachfiles }}/MACH_INSTALL_KEY" >  "{{ ssdevmachfiles }}/MACH_INSTALL_KEY.pub"
    ssh-keygen -y -f "{{ ssdevmachfiles }}/MACH_DEPLOY_KEY" >  "{{ ssdevmachfiles }}/MACH_DEPLOY_KEY.pub"

devenv-install-theia:
    devenv machines install --secretspec-profile="{{ ssdevmach }}"

# reboot with `reset`
uartdt:=`date +%Y%m%d-%H%M%S`
uarttype:='uart'

baud := '1500000'
ttydev := 'USB1'
uart-mini type=uarttype:
    minicom -b "{{ baud }}" -D "/dev/tty{{ ttydev }}"
uart-mini-log type=uarttype dt=uartdt:
    minicom -b "{{ baud }}" -D "/dev/tty{{ ttydev }}" -C "log/uart/{{ type }}.{{ dt }}.log"
uart-screen type=uarttype:
    screen "/dev/tty{{ ttydev }}" "{{ baud }}"
uart-screen-log type=uarttype dt=uartdt:
    screen -L -Logfile "log/uart/{{ type }}.{{ dt }}.log" "/dev/tty{{ ttydev }}" "{{ baud }}"
# Just:1 ends here
