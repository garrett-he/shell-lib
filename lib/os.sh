os::type() {
    if [[ $OSTYPE == "darwin"* ]]; then
        echo darwin
    elif [[ $OSTYPE == "linux"* ]]; then
        echo linux
    else
        echo $OSTYPE
    fi
}
