#!/bin/bash -e
operation="${1}"

function bail() {
    if [[ $# -eq 0 ]]; then
        echo "${0}: Script called 'bail' without passing a message" 1>&2
    else
        echo "${0}: $@" 1>&2
    fi
    exit 1
}
proj=src/DnsClient/DnsClient.csproj
if [[ -z "${operation}" ]]; then
    bail "Must supply parameter (restore|build)"
elif [[ "${operation}" == "restore" ]] || [[ "${operation}" == "build" ]]; then
    dotnet ${operation} ${proj}
else
    bail "Parameter ${operation} not supported"
fi

