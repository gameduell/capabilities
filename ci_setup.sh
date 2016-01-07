#!/bin/bash
set -e

trap onexit 1 2 3 15 ERR

function onexit() {
    echo "Problem occured during setup, exit code: $?"
    exit $exit_status
}

cd tests

rm -rf Export

printf '\n'
printf ' ---------- UPDATE DUELL DEPENDENCIES ----------'
printf '\n'
haxelib run duell_duell update -verbose -yestoall

printf '\n'
printf ' ---------- BUILD ANDROID BINARY ----------'
printf '\n'
haxelib run duell_duell build android -norun -verbose -yestoall -x86 -D jenkins

printf '\n'
printf ' ---------- BUILD IOS BINARY ----------'
printf '\n'
haxelib run duell_duell build ios -norun -simulator -verbose -yestoall -D jenkins

printf '\n'
printf ' ---------- BUILD HTML TARGET ----------'
printf '\n'
haxelib run duell_duell build html5 -norun -verbose -D jenkins -yestoall