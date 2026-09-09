#!/bin/sh
OUTPUT=DSI-2
STATE="$HOME/.config/screen-rotation"

# Wait for the output to be ready. At login the compositor may not have it yet.
i=0
while [ $i -lt 20 ]; do
  wlr-randr 2>/dev/null | grep -q "^$OUTPUT" && break
  i=$((i+1))
  sleep 0.5
done

CUR=$(cat "$STATE" 2>/dev/null || echo 270)

if [ "$1" = "restore" ]; then
  NEW="$CUR"
else
  case "$CUR" in
    normal) NEW=270 ;;
    *)      NEW=normal ;;
  esac
fi

wlr-randr --output "$OUTPUT" --transform "$NEW" && echo "$NEW" > "$STATE"
