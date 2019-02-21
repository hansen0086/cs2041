#!/bin/sh
#gerneral test

echo "./legit.pl init"
echo `./legit.pl init`

echo "echo 4321 >a.txt"
echo `echo 4321 >a.txt`


echo "echo 2 >b"
echo `echo 2 >b`

echo "./legit.pl add a.txt b"
echo `./legit.pl add a.txt b`

echo "cat b"
echo `cat b`
echo "echo 1234 b>>b"
echo `echo 1234 b>>b`
echo "cat b"
echo `cat b`
echo "./legit.pl add b"
echo `./legit.pl add b`


echo "./legit.pl commit -m 'hahaha'"
echo `./legit.pl commit -m 'hahaha'`

echo "cat .legit/b"
echo `cat .legit/b`

echo "echo last change >>b"
echo `echo last change >>b`


echo "./legit.pl commit -a -m 'hehehe'"
echo `./legit.pl commit -a -m 'hehehe'`

echo "cat .legit/b"
echo `cat .legit/b`

echo "./legit.pl log"
echo `./legit.pl log`

