#!/usr/bin/perl -w

my %hash;


while(my $line = <STDIN>){
    $line =~ /([a-z]+) ([0-9]+)/i;
    my $name = $1;
    my $value = $2;
    
    $hash{$name}+=$value;
    
}
my @final = sort {$hash{$b}<=>$hash{$a}} keys %hash;

print "Expel $final[0] whose library fines total \$$hash{$final[0]}\n";
