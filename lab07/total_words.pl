#!/usr/bin/perl


$word_count = 0;
while($line= <STDIN>){
    chomp $line;
    @words = split (/[^A-Za-z]+/,$line);
    
    
    foreach $word(@words){
        if($word eq ""){
        next;
        }
        $word_count ++;
    } 
}
print "$word_count words\n";



