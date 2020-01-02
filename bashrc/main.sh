# This is mostly a refactoring of the Ubuntu 18.04 bashrc, adjusted to work on Arch

export DOTHOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null 2>&1 && pwd )"

source "$DOTHOME/bashrc/basic.sh"
source "$DOTHOME/bashrc/prompt.sh"
source "$DOTHOME/bashrc/alias.sh"
