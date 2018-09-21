#!/bin/sh
# Uses xwinwrap to display given animated .gif in the center of the screen

if [ $# -ne 2 ]; then
    echo 1>&2 Usage: $0 image.gif imagd.gif
    exit 1
fi

ARGS=($@)

FSCRH=`xrandr | awk '/current/ { print $10 }'`
FSCRW=`xrandr | awk '/current/ { print $8 }'`
#FSCRW=${SCRW%\,}
echo FSCRW: ${FSCRW}
echo FSCRH: ${FSCRH}

#get screen resolution
SCRS=`xrandr | awk 'match($0,/([0-9]{0,4})x([0-9]{0,4})\+([0-9]{0,4})\+([0-9]{0,4})/) {print substr($0,RSTART,RLENGTH)}'`
echo SRCA: ${SCRS}
IT=0
#Loop over the result and generate a xwinwrap in the correct position for
for SCREEN in $SCRS
do
		#SW=`echo ${SCRS} | awk 'match($0,/([0-9]{0,4})/){print substr($0,RSTART,RLENGTH)}'`
		#SW=`echo ${SCREEN} | awk '/([0-9]{0,4})/ { print substr($1,RSTART,RLENGTH) }'`
		 while read SCRW SCRH OW OV
		
		do
				echo SCRW: ${SCRW}
				echo SCRH: ${SCRH}
				echo OW: ${OW}
				echo OV: ${OV}
				
				#get gif resolution
				IMGHW=`gifsicle --info ${ARGS[${IT}]} | awk '/logical/ { print $3 }'`
				IMGH=${IMGHW%x*}
				IMGW=${IMGHW#*x}

				#calculate position
				# fullScreenWidth - imageWidth - currentScreenWidth + offset
				POSH=$(($(($((${FSCRW}-${IMGW}))-$((${SCRW}))))+${OW}))
				# fullScreenHeight - imageHeight - currentScreenWidth + offsetHeigt
				POSW=$(($(($((${FSCRH}-${IMGW}))))+${OV}))
				POSW=${OV}
				echo IMGH: ${IMGH}
				echo IMGW: ${IMGW}
				echo POSH: ${POSH}
				echo POSW: ${POSW}

				~/Applications/xwinwrap/xwinwrap -g ${IMGHW}+${POSH}+${POSW} -ov -ni -s -nf -- gifview -w WID ${ARGS[${IT}]} -a &
		done <<< $(echo ${SCREEN} | awk --field-separator='[x+]' '{ print $1, $2, $3, $4 }')
		(( IT++ ))
done

exit 0
