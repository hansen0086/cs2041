#!/bin/sh

#a test for commit, run this test after test1 and test2

echo './legit.pl commit -m 'first commit''
echo `./legit.pl commit -m 'first commit'`


echo './legit.pl commit -m 'first commit''
echo `./legit.pl commit -m 'first commit'`

echo './legit.pl log'
echo `./legit.pl log`


echo 'echo line2 >> a.txt'
echo `echo line2 >> a.txt`

echo './legit.pl add a.txt'
echo `./legit.pl add a.txt`


echo './legit.pl commit -m 'second commit''
echo `./legit.pl commit -m 'second commit'`

echo './legit.pl log'
echo `./legit.pl log`






