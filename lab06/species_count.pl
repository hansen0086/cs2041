#!/usr/bin/perl 
    
    
    open FILE, '<', $ARGV[1] or die "$1: Can't open $file: $1\n";
    #$word_counter=0;
    #$pod_counter=0;
    while($line = <FILE>){
    if( $line =~ m/(.*)\s+(\d+)\s+($ARGV[0])/i){
        $word_counter+= $2;
        $pod_counter++;
    }
    }
    print "$ARGV[0] observations: $pod_counter pods, $word_counter individuals\n";
    close FILE;


