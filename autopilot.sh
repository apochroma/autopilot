#!/bin/bash
# Autopilot Assistant
# This script randomly change the active camera

cameras=( 1 5 8 'SuperSource')
function claimCamera() {
	local func_result=${cameras[$RANDOM % ${#cameras[@]} ]};
	echo "$func_result"
}


prev="$(claimCamera)"
echo $prev
#prev=$(claimCamera)
while true; do
	next=$(claimCamera)
	while [ "$prev" == "$next" ]; do
		next=$(claimCamera)
	done

	echo -e "Vorherige Kamera:\t"$prev
	echo -e "Nächste Kamera:\t\t"$next

	case "$next" in
		'1')
		sendosc 10.10.10.103 12321 /press/bank/30/2
		echo switching to cam 1
		;;
		'5')
		sendosc 10.10.10.103 12321 /press/bank/30/10
		echo switching to cam 5
		;;
		'8')
		sendosc 10.10.10.103 12321 /press/bank/30/13
		echo switching to cam 13
		;;
		'SuperSource')
		sendosc 10.10.10.103 12321 /press/bank/30/6
		echo switching to cam 1
		;;
	esac


	#sendosc 10.10.10.103 12321 /press/bank/30/

	i=`shuf -i 1-8 -n 1`
	echo "Sleep $i Seconds"
	sleep $i

	prev=$next
done

