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

echo "echo hello >> a"
echo `echo hello >> a`

echo "./legit.pl add a"
echo `./legit.pl add a`

echo "./legit.pl log"
echo `./legit.pl log`

echo "./legit.pl commit -m 'second commit'"
echo `./legit.pl commit -m 'second commit'`

echo "./legit.pl log"
echo `./legit.pl log`

echo "./legit.pl show 0:a"
echo `./legit.pl show 0:a`

