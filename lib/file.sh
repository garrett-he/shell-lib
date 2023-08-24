file::sed() {
    if [[ $(os::type) == "darwin" ]]; then
        /usr/bin/sed -i '' -e "$@"
    else
        sed -i "$@"
    fi
}

file::replace_text() {
    file::sed "s#$2#$3#g" "$1"
}

file::delete_line() {
    file::sed "/$2/d" "$1"
}

file::backup() {
    for file in "$@"; do
        if [[ -e "$file" ]]; then
            cp -R "$file" "$file~"
        fi
    done
}
