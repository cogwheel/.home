## set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=auto

# TODO: only do debian stuff on debian

if [ "$color_prompt" = yes ]; then
    PROMPT_PREFIX='${debian_chroot:+($debian_chroot)}${CONDA_PROMPT_MODIFIER}\[\033[1;38;5;208m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'
else
    PROMPT_PREFIX='${debian_chroot:+($debian_chroot)}${CONDA_PROMPT_MODIFIER}\u@\h:\w'
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_PREFIX="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PROMPT_PREFIX"
    ;;
*)
    ;;
esac

source /usr/share/git/completion/git-prompt.sh
source /usr/share/bash-completion/completions/git

# Open terminal tabs in existing working directory
if [ -e /etc/profile.d/vte.sh ]; then
    . /etc/profile.d/vte.sh
fi

PROMPT_SUFFIX="\\n\\\$ "

function set_prompt() {
    if [ -z "$(command -v __git_ps1 2>/dev/null)" ] ; then
        echo "$PROMPT_PREFIX$PROMPT_SUFFIX"
    else
        __git_ps1 "$PROMPT_PREFIX" "$PROMPT_SUFFIX"
    fi
    [ $VTE_VERSION ] && __vte_prompt_command
}

PROMPT_COMMAND='set_prompt'

