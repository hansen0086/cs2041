#!/bin/sh

#a test for add, run this test after test1

echo '$echo line1 > a.txt'
echo `echo line1 > a.txt`

echo '$echo 'this is line1' > b.txt'
echo `echo 'this is line1' > b.txt`

echo '$./legit add a.txt b.txt'
echo `./legit.pl add a.txt b.txt`
