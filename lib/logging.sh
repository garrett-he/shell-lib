set -eu

logging::echo() {
    out="${3:-1}"

    if [[ ! -t $out ]] || [[ -z ${2:+x} ]]; then
        echo "$1" >&"$out"
    else
        echo -e "\033[$2$1\033[0m" >&"$out"
    fi
}

logging::error() {
    logging::echo "[error] $1" '1;101m' 2
}

logging::warning() {
    logging::echo "[warning] $1" '1;103m'
}

logging::info() {
    logging::echo "[info] $1" '1;102m'
}

logging::debug() {
    if [[ -z ${DEBUG:+x} ]]; then
        return
    fi

    logging::echo "[debug] $1" '1;105m'
}
