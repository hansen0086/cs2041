#!/usr/bin/perl -w
use strict;


open FILE, "<", $ARGV[0] or die "$ARGV[0] not found!\n";

while(my $line = <FILE>){
    chomp $line;
    #print "$line";

    if($line =~/#!\/bin\/bash/)
    {
        print("#!/usr/bin/perl -w\n")
    }
    #comment or import
    elsif($line =~/^#/){
    print("$line\n");
    }
    
    


    #initializeing value
    if ($line =~ /^[a-z,A-Z]+=[0-9]+/){
    my @lines = split(/=/,$line);
    print("\$$lines[0] = $lines[1];\n");
    }

    #convert while statement 
    
    if($line =~/while \(\(i \<\= finish\)\)/)
    {
        my @symbols = split(' ',$line);
        
        
        $symbols[1] =~ s/\(\(//g;
        
        
        
        $symbols[3] =~ s/\)\)//g;
        
        #$line =~ s///g;
        #$line =~ s/w+//
        print ("while (\$$symbols[1] $symbols[2] \$$symbols[3]) {\n");
    }
    #convert do and done
    if($line eq "do"){
        #print("{\n");
    
    }
    if($line eq "done"){
        print("}\n");
    }
    #assign values
    
    #sum=$((sum + i))
    if ($line =~ /sum\=\$\(\(sum \+ i\)\)/){
    print ("    \$sum = \$sum + \$i;\n");
    }
    
    #i=$((i + 1))
    if($line =~ /i\=\$\(\(i \+ 1\)\)/){
    print("    \$i = \$i + 1;\n")
    
    }
    
    if ($line =~ /j\=\$\(\(j \+ j\)\)/)
    {
        print("    \$j = \$j + \$j;\n")
    }
    
    if ($line =~ /while \(\(i \< 31\)\)/){
        print("while (\$i < 31) \{\n");
    }
    
    
    
    
    if($line =~/echo/)
    {
        $line=~s/echo //;
        print("print \"$line\\n\";\n");
    }
    
    
    


}

