#!/usr/bin/perl 



    open FILE, '<', $ARGV[0] or die "$0: Can't open $file: $!\n";
    $word_counter = 0;
    while($line = <FILE>){
    if( $line =~ m/(.*)\s+(\d+)\s+(orca)/i){
        $word_counter+= $2;
    
    }
    }
    print "$word_counter Orcas reported in $ARGV[0]\n";
    close FILE;


