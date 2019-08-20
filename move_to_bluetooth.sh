SINK_INDEX="$(pacmd list-sinks | grep "bluez_sink" -B1 | awk '/index:/ {print $3}')"
ALSA_INDEX=$(pacmd list-sink-inputs | grep "alsa_output" -B4 | awk '/index:/ {print $2}')


pacmd move-sink-input $ALSA_INDEX $SINK_INDEX
