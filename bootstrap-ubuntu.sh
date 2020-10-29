cat << EOF >> ~/.bashrc
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
EOF

cat << EOF >> ~/.tmux.conf
set -g default-command "${SHELL}"
set-option -g history-limit 30000

# Set new panes to open in current directory
bind c new-window -c "#{pane_current_path}"
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
EOF

sudo apt update
sudo apt upgrade -y
sudo apt install -y vim silversearcher-ag cloc git zip docker maven julia nmon

# JDK8
curl -s "https://get.sdkman.io" | bash
sdk install java 8.0.272.hs-adpt

sudo gpasswd -a $USER docker
newgrp docker
