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

cat << EOF >> ~/.gitconfig
[core]
	editor = vim
[user]
	email = szarnyasg@gmail.com
	name = Gabor Szarnyas
[push]
	default = current
[color]
	ui = auto
[alias]
	ci = commit
	st = status
	di = diff
	dis = diff --staged
	d = diff --word-diff
	oneline = log --pretty=oneline
	br = branch
	la = log --pretty="format:%ad %h (%an): %s" --date=short
	co = checkout
	cp = cherry-pick
	getremote = config --get remote.origin.url
	work = log --pretty=format:\"%h%x09%an%x09%ad%x09%s\"
EOF

sudo apt update
sudo apt upgrade -y
sudo apt install -y docker vim silversearcher-ag cloc git zip zstd maven julia nmon git cmake gcc g++

# JDK8
curl -s "https://get.sdkman.io" | bash
sdk install java 8.0.272.hs-adpt
sdk install java 11.0.7.hs-adpt

sudo gpasswd -a $USER docker
newgrp docker
