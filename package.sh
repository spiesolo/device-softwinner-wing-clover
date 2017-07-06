#!/bin/bash
cd $PACKAGE
if [ "$1" = "-d" ]; then
	echo "--------debug version, have uart printf-------------"
  ./pack -c sun7i -p android -b wing-clover  -d card0
else
	echo "--------release version, donnot have uart printf-------------"
	./pack -c sun7i -p android -b wing-clover  -d uart0
fi
cd -
