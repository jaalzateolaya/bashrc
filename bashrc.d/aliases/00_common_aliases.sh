# Add some easy shortcuts for formatted directory listings and add a touch of
# color.
alias ll='ls -l'
alias la='ls -Al'
alias ls='ls -hF --color=auto'

alias rm='rm -v'
alias cp='cp -v'
alias mv='mv -v'
alias ln='ln -v'

# Make grep more user frendly by highlighting matches
# and exclude grepping through .svn folders.
alias grep='grep -sn --color=auto --exclude-dir={\.svn,\.git,node_modules}'

if [ -f /etc/profile.d/coreutils.sh ]; then
	source /etc/profile.d/coreutils.sh
fi

# Sudo alias for applying this aliases
alias sudo='sudo '
