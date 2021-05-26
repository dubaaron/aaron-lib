#!/bin/bash
# todo: figure out correct shebang line

# first, get battery status
# what are the different things `pmset -g ps` can tell us?


# Example output:
# $ pmset -g ps
# Now drawing from 'AC Power'
#  -InternalBattery-0 (id=5242979)        82%; AC attached; not charging present: true

# $ pmset -g ps
# Now drawing from 'AC Power'
#  -InternalBattery-0 (id=5242979)        82%; AC attached; not charging present: true

# $ pmset -g ps
# Now drawing from 'Battery Power'
#  -InternalBattery-0 (id=5242979)        82%; discharging; (no estimate) present: true

# $ pmset -g ps
# Now drawing from 'AC Power'
#  -InternalBattery-0 (id=5242979)        81%; AC attached; not charging present: true

# $ pmset -g ps
# Now drawing from 'AC Power'
#  -InternalBattery-0 (id=5242979)        81%; AC attached; not charging present: true

# $ pmset -g ps
# Now drawing from 'AC Power'
#  -InternalBattery-0 (id=5242979)        82%; charging; (no estimate) present: true

# things it can tell us:
# first line: 'Now drawing from ' -- 'AC Power' or 'Battery Power'
# second line:
# Battery ID (meh),
# battery percentage (most important, get with regex?  /\s(\d+)\%\;/
# AC attached/charging/discharging
# not charging/(no estimate)
# present: true (or presumably, false, if no battery)

# what's important?
# - battery percentage
# - whether AC or battery power
# - whether charging, discharging, or not
