#!/bin/sh
# pancake
# test case for binaries

getentry() {
	rabin2 -rve files/"$1" | awk '{if(/@/){print $4}}'
}

getmain() {
	rabin2 -vM files/"$1" | awk -F= '{if(/=/){print $3}}'
}

runtest() {
	printf "     $1\t$2"
	O=`eval $2 $1`
	if [ "$O" = "$3" ]; then
		echo "\r OK"
	else
		echo "  *** FAIL because not '$O' ***"
	fi
}

runtest ./match0/hello-osx-i386 getentry 0x00001f14
runtest ./match0/hello-osx-i386 getmain 0x00001f52
runtest ./match0/hello-osx-x86_64 getentry 0x100000ed0
runtest ./match0/hello-osx-x86_64 getmain 0x100000f0c
