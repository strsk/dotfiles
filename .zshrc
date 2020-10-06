# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# golang
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

# peco with ghq
function peco-src () {
    local SELECTED_DIR
    SELECTED_DIR=$(ghq list -p | peco --query "$LBUFFER")
        if [ -n "$SELECTED_DIR" ]; then
            BUFFER="cd $SELECTED_DIR"
            zle accept-line
        fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# ssh for tky01
function get_tky01_vm_list() {
    curl -s http://viewer.cvb.io/json/vhv.json > $1
}
function check_tky01_vm_list() {
    if [ -e $1 ]; then
        TIME=$(( $(date +%s) - $(stat -f%c $1) ))
        if [ $TIME -gt 300 ]; then
            get_tky01_vm_list $1
        fi
    else
        get_tky01_vm_list $1
    fi
}
function ssh_tky01 {
    local VM_LIST_PATH="/tmp/vhv.json"
        check_tky01_vm_list $VM_LIST_PATH
    export HOST_LIST
    HOST_LIST=$(cat $VM_LIST_PATH | jq -r '.data[] | .display_name + "." + .name + ".incvb.io"' | peco --query "$LBUFFER" )
    if [ -n "$HOST_LIST" ]; then
        BUFFER="ssh ${HOST_LIST}"
        zle accept-line
    fi
  zle clear-screen
}
zle -N ssh_tky01
bindkey '^[' ssh_tky01
