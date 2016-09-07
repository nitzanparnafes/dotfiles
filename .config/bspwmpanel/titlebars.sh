#!/bin/bash
# use lemonboys bar to display titlebars

# barPids=/tmp/titleBarPids
# touch $barPids

wininfo=$(bspc query -T)
windows=""

SAFEIFS=$IFS
IFS=$'\n'

for i in $wininfo; do
  if [[ $i =~ ^$(printf "\t")[0-9] ]] && [[ $i =~ '*' ]]; then
    windows="$windows $(bspc query -W -d $(echo $i | awk '{print $1}'))"
    windows="$windows M"
  fi
done

# if [[ "$windows" == "" ]];then
#     kill $(cat $barPids)
#     rm $barPids
#     exit
# fi

IFS=$SAFEIFS

OLDEST_PID=$(pgrep -o 'lemonbar')
test $OLDEST_PID && pgrep 'lemonbar' | grep -vw $OLDEST_PID | xargs -r kill

for proc in $(pgrep 'update-title.sh');do
  kill $proc
done

killall bar

# rm $barPids
#sleep 2
blankscreen=false
for id in $windows; do
  if [[ $id == "M" ]]; then
    blankscreen=false
    continue
  elif [[ $blankscreen == true ]]; then
    continue
  fi
  winClass="$(xprop WM_CLASS -id $id)"
  if [[ $winClass =~ Steam ]] || [[ $winClass =~ Qmmp ]] || [[ $winClass =~ Wrapper-1.0 ]] || [[ $winClass =~ xfce4-panel ]]; then
    continue
  fi
  eval $(xwininfo -id $id |
    sed -n -e "s/^ \+Absolute upper-left X: \+\([0-9]\+\).*/x=\1/p" \
           -e "s/^ \+Absolute upper-left Y: \+\([0-9]\+\).*/y=\1/p" \
           -e "s/^ \+Width: \+\([0-9]\+\).*/w=\1/p" \
           -e "s/^ \+Height: \+\([0-9]\+\).*/h=\1/p" )
  geo="${w} ${h} ${x} ${y}"
  geoBar=$(echo $geo| awk '{print $1+4"x26+"$3"+"$4-26}')
  if [ "$h" -lt "1024" ]; then
    geos=("${geos[@]}" "$geoBar")
    ids=("${ids[@]}" "$id")
    bgw=$(($w - 116))
    bgws=("${bgws[@]}" "$bgw")
    if [[ ! -e "/tmp/bg_${bgw}.png" ]]; then
      convert ~/.config/bspwmpanel/bg_tile.png -resize ${bgw}x26\! /tmp/bg_${bgw}.png
    fi
  else
    blankscreen=true
  fi
done



for (( i = 0; i < ${#ids[@]}; i++ )); do
  echo -e "%{c}%{I:/tmp/bg_${bgws[i]}.png:}%{l}%{I:/home/nitzan/.config/bspwmpanel/corner.png:}%{r}%{I:/home/nitzan/.config/bspwmpanel/corner.png:}"  | bar -d -p -B "/home/nitzan/.config/bspwmpanel/trans.png" -F "#4e585d" -f "Terminus:size=1" -g ${geos[i]} &
  sleep 0.05
  ~/.config/bspwmpanel/update-title.sh ${ids[i]}| lemonbar -d -g ${geos[i]} -f "ProFont:size=8" -f "ProFont:size=9" -p | bash &
done
sleep 0.1
for (( i = 0; i < ${#ids[@]}; i++ )); do
  barinfos="$(xwininfo -tree -root | grep ${geos[i]})"
  bgid="$(echo "$barinfos" | tail -n 1 | awk '{print $1}')"
  xdo below -t "${ids[i]}" "$bgid"
  xdo above -t "$bgid" "$(echo "$barinfos" | head -n 1 | awk '{print $1}')"
done
