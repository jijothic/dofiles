#!/bin/bash
desktop=$(bspc query -D -d focused)
if [[ $1 == "-u" ]]; then
	bspc config top_padding 0
	bspc config bottom_padding 54
	bspc config right_padding 0
	bspc config left_padding 0
else
	if [[ $1 == "-p" ]]; then
		# presentation mode, so exactly 1920x1080
		bspc config top_padding 1026
		bspc config bottom_padding 54
		bspc config right_padding 1280
		bspc config left_padding 640
	else
		bspc config top_padding 360
		bspc config bottom_padding 360
		bspc config right_padding 1280
		bspc config left_padding 0
	fi
	firefox-developer-edition --new-window "https://chat.restream.io/chat" &
	# let it open
	sleep 2
fi
for id in $(xdo id -N firefoxdeveloperedition); do
	if xprop -id "$id" WM_NAME | grep "Restream Chat"; then
		break
	fi
	id=""
done
echo "Chat window: $id"
if [[ -n "$id" ]]; then
	if [[ $1 == "-u" ]]; then
		xdo close "$id"
	fi
	bspc node "$id" --state floating --flag sticky=on
	xdo resize -w "1278" -h "2104" "$id"
	xdo move -x "2561" -y "1" "$id"
fi

# move back to current desktop if we moved away
bspc desktop -f "$desktop"

# also open a small terminal to mark webcam square
if [[ $1 != "-u" ]]; then
	alacritty -e cat &
	pid=$!
	# let it open
	sleep 1
	for id in $(xdo id -N Alacritty); do
		wpid=$(xprop -id "$id" _NET_WM_PID | awk '{print $NF}')
		if [[ $pid == $wpid ]]; then
			echo "Webcam underlay: $id"
			bspc node "$id" --state floating --flag sticky=on
			if [[ $1 == "-p" ]]; then
				# webcam is 300x300
				xdo resize -w "15" -h "35" "$id"
				xdo move -x "2260" -y "1806" "$id"
			else
				# webcam is 412x412, but scaled to 549x549
				xdo resize -w "15" -h "35" "$id"
				xdo move -x "2011" -y $((360+549-35)) "$id"
			fi
			break
		else
			echo $pid $wpid
		fi
	id=""
done
fi
