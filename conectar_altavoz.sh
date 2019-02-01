# HOW TO USE
#
# this script recive onw argument, an example of use is this:
# sh conectar_altavoz.sh "11:22:33:AA:BB:CC"
#
#
# PREVIOUS CONFIGS
#
# Some config is need before launch script.
# Source,Sink,Media,Socket must be enable in main config. You can add with
# Source,Sink,Media,Socket
# sudo sh -c "echo 'Enable=Source,Sink,Media,Socket' >> /etc/bluetooth/main.conf"


VAR1="$(tmux list-sessions | grep "ConnectBluetooth" | wc -l)"

if [ $VAR1 = 0 ]
then
  echo "Creo el panel"
  tmux new-session -d -s ConnectBluetooth
fi
sleep 1

tmux send-keys -t ConnectBluetooth "sudo service bluetooth restart" Enter
sleep 1
stty -echo
read -p "Sudo Password: " passw; echo
stty echo
tmux send-keys -t ConnectBluetooth $passw Enter
sleep 1
tmux send-keys -t ConnectBluetooth "sudo bluetoothctl -a" Enter
sleep 1
tmux send-keys -t ConnectBluetooth "connect $1" Enter
sleep 5
tmux send-keys -t ConnectBluetooth "exit" Enter
sleep 1
CARD_INDEX="$(pacmd list-cards | grep bluez_card -B1 | grep index | awk '{print $2}')"
sleep 2
tmux send-keys -t ConnectBluetooth "pacmd set-card-profile $CARD_INDEX a2dp_sink" Enter
sleep 1
SINK_INDEX="$(pacmd list-sinks | grep "bluez_sink" -B1 | awk '/index:/ {print $2}')"
tmux send-keys -t ConnectBluetooth "pacmd set-default-sink $SINK_INDEX" Enter

echo "Conectado con alta calidad"


# TODO
# This script is still WIP
# Last thing to develop is to change sink-inputs, apps that are playing some sound, move to
# the sink. An example of move is this:
# pacmd move-sink-input 1 14
# echo $SINK_INDEX
# 1 --> sink input
# 14 --> sinks index
