#!/usr/bin/perl -w

open my $fh, '<', $ARGV[0] or die "not found";
my $target=$ARGV[1];

while($line = <$fh>){
    if($line =~/$target/){
    $line =~ s/$target/($target)/g;
    print $line;
    }
    
}
close $fh;

