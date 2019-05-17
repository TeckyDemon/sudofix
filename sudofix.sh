rm /etc/sudoers
[[ ! -z "$(which apt 2>/dev/null)" ]] && apt install --reinstall sudo -y
[[ ! -z "$(which pacman 2>/dev/null)" ]] && pacman -S sudo --noconfirm
[[ ! -z "$(which brew 2>/dev/null)" ]] && brew --force sudo
temp_file=$(mktemp)
tac /etc/sudoers | sed -E "0,/^[a-z0-9]* (ALL=\(ALL\) ALL)/s//$(stat -c '%U' $0) \1\n&/" | tac > $temp_file && \
	mv $temp_file /etc/sudoers
