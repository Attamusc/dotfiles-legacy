#!/bin/sh

#Scalariform overwrites the file it is formatting.  This script resets the file to be tested
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cp $DIR/needs-formatting.scala $DIR/test.scala
