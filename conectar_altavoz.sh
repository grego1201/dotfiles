# HOW TO USE
#
# this script recive two arguments, first is sudo password (be carefull and delete last command in log) and the second one device ID
# an example of use is:
# sh conectar_altavoz.sh "MyPassword" "11:22:33:AA:BB:CC"
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
  tmux new-session -d -s ConnectBluetooth 'sudo bluetoothctl -a '
fi
sleep 1

echo "Busco el panel"
tmux send-keys -t ConnectBluetooth $1 Enter
sleep 1
echo "Conecto el dispositivo"
tmux send-keys -t ConnectBluetooth "connect $2" Enter

HIGH_QUALITY="$(pacmd list-sinks | awk '/name:/ {print $2};' | grep "a2dp" | wc -l)"
echo "$(pacmd list-sinks | awk '/name:/ {print $2};')"
echo $HIGH_QUALITY
while [ $HIGH_QUALITY = 0 ]
do
  echo "Desconecto el dispositivo"
  tmux send-keys -t ConnectBluetooth "disconnect $2" Enter
  sleep 7
  echo "Reinicio servicio bluetooth"
  tmux send-keys -t ConnectBluetooth "sudo service bluetooth restart" Enter
  sleep 3
  echo "Abro el server"
  tmux send-keys -t ConnectBluetooth "sudo bluetoothctl -a " Enter
  sleep 3
  tmux send-keys -t ConnectBluetooth $1 Enter
  echo "Conectando en bucle"
  tmux send-keys -t ConnectBluetooth "connect $2" Enter
  sleep 5
  CARD_INDEX="$(pacmd list-cards | grep bluez_card -B1 | grep index | awk '{print $2}')"
  sleep 3
  tmux send-keys -t ConnectBluetooth "pacmd set-card-profile $CARD_INDEX a2dp_sink"
  sleep 3
  HIGH_QUALITY="$(pacmd list-sinks | awk '/name:/ {print $2};' | grep "a2dp" | wc -l)"
done

echo "Conectado con alta calidad"
