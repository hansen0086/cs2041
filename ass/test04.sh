#!/bin/sh
#gerneral test

echo "./legit.pl init"
echo `./legit.pl init`

echo "touch a b c d"
echo `touch a b c d`

echo "./legit.pl add a b c d "
echo `./legit.pl add a b c d `


echo "./legit.pl commit -m 'first commit'"
echo `./legit.pl commit -m 'first commit'`

echo "./legit.pl show :a"
echo `./legit.pl show :a`

echo "./legit.pl log"
echo `./legit.pl log`

echo "./legit.pl rm a"
echo `./legit.pl rm a`


echo "./legit.pl log"
echo `./legit.pl log`

