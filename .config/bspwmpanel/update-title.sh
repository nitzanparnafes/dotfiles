#!/bin/bash
while true; do
  color="#979286"
  font="%{T1}"
  if [[ $1 -eq $(printf 0x%x $(xdotool getactivewindow)) ]]; then
    color="#FFFFFF"
    font="%{T2}"
  fi
  title=$(xtitle $1)
  echo -e "$font%{F$color}%{c}%{A1:bspc window $1 -f:}%{A2:bspc window $1 -c:}%{A5:bspc window $1 -d last:}%{A4:bspc window $1 -s biggest && ~/.config/bspwmpanel/titlebars.sh:}$title%{A}%{A}%{A}%{A}%{F#909090}%{r}%{A:bspc window $1 -c:}x   %{A}"
  sleep 0.5
done

