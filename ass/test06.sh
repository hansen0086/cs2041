#!/bin/sh
#gerneral test


echo "./legit.pl init"
echo `./legit.pl init`

echo "echo 1234 >a"
echo `echo 1234 >a`

echo "./legit.pl add a"
echo `./legit.pl add a`

echo "./legit.pl show :a"
echo `./legit.pl show :a`

echo "./legit.pl add a"
echo `./legit.pl add a`

echo "./legit.pl show :a"
echo `./legit.pl show :a`


echo `./legit.pl commit -m 'aaa'`

