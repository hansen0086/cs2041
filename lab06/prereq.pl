#!/usr/bin/perl -w
use strict;



if (@ARGV <1){
die "Usage: ./prereq.pl CourseNumber\n"
} 




my $post_url = "http://www.handbook.unsw.edu.au/postgraduate/courses/2018/$ARGV[0].html";

my $under_url = "http://www.handbook.unsw.edu.au/undergraduate/courses/2018/$ARGV[0].html";


(open my $F, "-|", "wget -q -O- $under_url $post_url") or die "Cant find page";

while(my $line = <$F>){
    if($line =~ /Prerequisite/){
    $line =~ s/Excluded.*//;
    $line =~ s/Equivalent.*//;
    my @courses = ($line =~ /[A-Z]{4}[0-9]{4}/g);
    foreach my $course (@courses){
    print "$course\n";
    }
    
    
    }
}
close $F;

