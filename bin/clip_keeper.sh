#!/usr/bin/env bash

# A simple/crude little script to save clipboard history, for when working in an environment where you can't install a nicer one.
#
# Currently mac-specific, but could be ported to linux (and maybe Cygwin?) easily.
#
# todo: rewrite in ruby? (less easily to install, but less painful to code) this could be helpful: https://github.com/janlelis/clipboard
# and/or: decent-looking alternatives, in an environment where they are allowed:
# - https://maccy.app/ - FOSS, says it is 'secure and private', 'lightweight and fast', 'no fluff'
# - https://florian.github.io/clipgerapp/


sleep_delay=1
output_file="~/.clip_history"

echo "Haribol!"
echo "Monitoring clipboard every ${sleep_delay} second(s), outputting to stdout and '${output_file}'."


last_paste=`pbpaste`

# while true
while [ 0 ]; do
  sleep $sleep_delay

  if [[ $last_paste != `pbpaste` ]]; then
    last_paste=`pbpaste`

    date_str=`date "+%Y-%m-%d %a %H:%M:%S %Z (%z)"`
    printf '%s\n'   "--- ${date_str} ---"  ''  "${last_paste}"  ''  ''  ''  | tee -a clip_history
  fi

done