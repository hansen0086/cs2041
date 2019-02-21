#!/usr/bin/perl


$word_count = 0;
while($line= <STDIN>){
    chomp $line;
    @words = split (/[^A-Za-z]+/,$line);
    
    
    foreach $word(@words){
        if($word eq ""){
        next;
        }
        if(lc($word) eq lc($ARGV[0])){
        $word_count ++;
        }
    } 
}
print "$ARGV[0] occurred $word_count times\n";



