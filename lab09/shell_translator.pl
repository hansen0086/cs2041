#!/usr/bin/perl -w
use strict;


open FILE, "<", $ARGV[0] or die "$ARGV[0] not found!\n";

while(my $line = <FILE>){
    chomp $line;

    
    if($line =~/#!\/bin\/bash/)
    {
        print("#!/usr/bin/perl -w\n")
    }
    #comment or import
    elsif($line =~/^#/){
    print("$line\n");
    }
    #convert while statement 
    
    if($line =~ /while/ or $line=~ /if/){
        $line =~ s/\(\(/\( /g;
        $line =~ s/\)\)/ \)/g;
        #print "$line\n";
        my @symbols = split(' ',$line);
        shift @symbols;
        
        foreach my $symbol(@symbols){
            if($symbol =~/[a-zA-Z]+/){
            $symbol = "\$$symbol";
            }
        
        }
        if($line =~ /while/){
            print "while ";
        }
        elsif($line =~/if/){
            print "if";
        }
        else{
            print"error";
        }
        print"@symbols\n";
        
         
    }
    
    
    
    
    
    
    #initialize variable with number
    if($line =~ /[a-z]+=[0-9]+/i){
        $line =~ s/=/ = /;
        $line =~ s/\$//g;
        my @symbols = split(' ',$line);
        foreach my $symbol(@symbols){
            if ($symbol =~ /[a-zA-Z]+/){
                $symbol = "\$$symbol";
            }
            
        }
        print"@symbols;\n";
    
    }
    #change variable as another variable
    elsif($line =~/[a-z]+=\$[a-z]+\s*$/i){
        $line =~ s/\$//g;
        $line =~ s/=/ = /;
        my @symbols = split(' ',$line);
        foreach my $symbol(@symbols){
            if ($symbol =~ /[a-zA-Z]+/){
                $symbol = "\$$symbol";
            }
            
        }
        print"@symbols;\n";
    
    
    }
    
    
    
    #change variable as b=$((b + 1)) form
    elsif($line =~ /[a-z]+=\$\(\(.*\)\)/i){
        $line =~ s/\(\(/\( /g;
        $line =~ s/\)\)/ \)/g;
        $line =~ s/\$//g;
        my @symbols = split(' ',$line);
        foreach my $symbol(@symbols){
            if($symbol =~/[a-zA-Z]+/){
                $symbol = "\$$symbol";
            }
        }
        print"@symbols;\n";
    }
    
    
    #convert do and done
    if($line =~ /^\s*do\s*$/ or $line =~ /^\s*then\s*$/){
        print("{\n");
    
    }
    if($line  =~ /^\s*done\s*$/ or $line  =~ /^\s*fi\s*$/){
        print("}\n");
    }
    
    
    if($line =~/echo/)
    {
        $line=~s/echo/print "/;
        print("$line\\n\";\n");
    }
    if ($line =~/else/){
    print("} else {\n");
    }
    
    }
