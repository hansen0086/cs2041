#!/usr/bin/perl 



die "Usage: ./echon.pl <number of lines> <string>\n" if (@ARGV !=2);
die "./echon.pl: argument 1 must be a non-negative integer\n" if (!($ARGV[0] =~ /^[0-9]+$/));


$number = $ARGV[0];
$string = $ARGV[1]; 



while ($number >0){
    print "$string","\n";
    $number--;
    

}
