# [[file:README.org::*Just][Just:1]]
uartdt:=`date +%Y%m%d-%H%M%S`
uarttype:='uart'

foo dt=uartdt type=uarttype:
     @echo log/uart/{{type}}.{{dt}}.log

# reboot with `reset`

baud := '1500000'
ttydev := 'USB0'
uart-mini type=uarttype dt=uartdt:
    minicom -b "{{ baud }}" -D "/dev/tty{{ ttydev }}" -C "log/uart/{{ type }}.{{ dt }}.log"

uart-screen type=uarttype dt=uartdt:
    screen -L -Logfile "log/uart/{{ type }}.{{ dt }}.log" "/dev/tty{{ ttydev }}" "{{ baud }}"
# Just:1 ends here
