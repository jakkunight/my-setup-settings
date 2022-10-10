cleanup ()
{
	tmux kill-server
	exit
}
pscale ()
{
	mysql -h i36l79tdjaxk.us-east-4.psdb.cloud -u ueduqq6tfks3 -ppscale_pw_Hn7PhelQfTue-1ChT8liWextXuYGtEoK9ryk7zvSNDw --ssl-ca=$PREFIX/etc/tls/cert.pem
}

db4free ()
{
	mysql -h db4free.net -u jakku_kun -p2ab+aa+bb
}

n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

nnn_cd()
{
	if ! [ -z "$NNN_PIPE" ]; then
		printf "%s\0" "0c${PWD}" > "${NNN_PIPE}" !&
	fi
}

trap nnn_cd EXIT
export nnn="$1"

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then

	tmux start-server
	tmux new-session -d -s Termux -n Termux
	tmux new-window -t Termux:1 -n Database
	tmux new-window -t Termux:2 -n Backend
	tmux new-window -t Termux:3 -n Frontend
	tmux new-window -t Termux:4 -n htop

	tmux split-window -h -t Termux:2
	tmux split-window -v -t Termux:2
	tmux split-window -h -t Termux:2

	tmux split-window -h -t Termux:3
	tmux split-window -v -t Termux:3
	tmux split-window -h -t Termux:3

	tmux attach
fi
n
