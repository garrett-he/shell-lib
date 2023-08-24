utils::shell_name() {
    basename $(readlink /proc/$$/exe)
}

utils::fn_defined() {
    declare -F "$1" > /dev/null
    return $?
}

utils::is_true() {
    if [[ "$1" == "1" ]] || [[ "$1" == "Y" ]] || [[ "$1" == "y" ]]; then
        return 0
    else
        return 1
    fi
}

utils::append_profiles() {
    if [[ -z "${2-}" ]]; then
        for rcfile in .zshrc .bashrc; do
            if [[ -z "${1-}" ]]; then
                echo "" >> "$HOME/$rcfile"
            else
                echo "$1" >> "$HOME/$rcfile"
            fi
        done
    else
        if [[ -z "${1-}" ]]; then
            echo "" >> "$HOME/.${2}rc"
        else
            echo "$1" >> "$HOME/.${2}rc"
        fi
    fi
}

utils::read() {
    local prompt="\033[1;104m$1"

    if [[ -n "${!2-}" ]]; then
        prompt="$prompt (${!2})"
    elif [[ -n "${3-}" ]]; then
        prompt="$prompt ($3)"
    fi

    prompt="$prompt\033[0m: "

    if [[ $(utils::shell_name) == 'bash' ]]; then
        read -r -p "$(echo -e "$prompt")"
    else
        read -r "?$(echo -e "$prompt")"
    fi

    if [[ -z "${REPLY-}" ]]; then
        if [[ -n ${3:+x} ]]; then
            eval "$2=$3"
        fi
    else
        eval "$2='$REPLY'"
    fi
}

utils::confirm() {
    if [[ $(utils::shell_name) == 'bash' ]]; then
        read -r -p "$(echo -e "\033[1;104m$1?\033[0m [y/N]: ")"
    else
        read -r "?$(echo -e "\033[1;104m$1?\033[0m [y/N]: ")"
    fi

    if [[ "$REPLY" == 'y' ]] || [[ "$REPLY" == 'Y' ]]; then
        return 0
    else
        return 1
    fi
}
