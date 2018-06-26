# This is a convenient startup script for P5JS in Vim / TMUX
#
# It's just a small, personal shortcut to get started sketching very quickly
# You need the P5 Generator installed for it to work

TMUX=${TMUX:-"tmux"}
SESSION=${SESSION:-"P5JS"}

# Change this to a p5js collection
# If you haven't already, you can make one by using the p5 generator like so: $ p5 new my_collection
# More info: https://github.com/chiunhau/p5-manager/blob/master/README.md#collection
P5DIR=${P5DIR:-"/Users/madskjeldgaard/Desktop/scripts/js/p5js/dailies"}

LOCALSERVER=${LOCALSERVER:-"http://localserver:5555"}

# Open the localserver in FireFox
#open -a FireFox $LOCALSERVER 

DATE=${DATE:-"$(date '+%d%m%Y')"}
PROJECT_NAME="p5js_"$DATE

cd $P5DIR

p5 generate $PROJECT_NAME
cd $PROJECT_NAME

# Start TMUX session with details from above
# Open the two main files in p5js
# + Make a new tab starting the server

$TMUX attach-session -t $SESSION || $TMUX \
  new-session -s $SESSION   \; \
  send-keys -t 0 "vim index.html" C-m   \; \
  send-keys -t 0 ":tabnew sketch.js" C-m \; \
  split-window -h -p 33 \; \
  selectp -t 1 \; \
  send-keys "cd .. && p5 server" C-m   \; \
  selectp -t 0 \;
