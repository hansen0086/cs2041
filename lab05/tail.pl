#!/usr/bin/perl -w

$N = 10;


if(@ARGV ==0){
     
     @file = <STDIN>;
     
     $line_counter = 1;
     foreach $line (@file){
        if($line_counter++ > @file-10){

        
        print "$line";
     }
     }
}


foreach $arg (@ARGV) {
#    if ($arg eq "--version") {
#        print "$0: version 0.1\n";
#        exit 0;
#    }
    # handle other options
    # ...
    
    
    
    if ($arg =~ /^(-\d+)$/){
        $N = $ARGV[0];
        $N = 0 - $N;
        
        #print "$N";
        
    
    } else {
        push @files, $arg;
    }

}
foreach $file (@files) {
    open F, '<', $file or die "$0: Can't open $file: $!\n";

    # process F
    
    $total_line = `wc -l < $file`;
    chomp $total_line;
    #print "$total_line";
    
    if($total_line >= $N){
        $start_line = $total_line - $N +1;
    }
    else{
        $start_line = 1;
    
    }
    #print "total_line is $total_line","\n";
    #print "start_line is $start_line","\n";
    #print "N is  $N","\n";
    #print "@files";
    if(@files > 1){
        print "==> $file <==","\n";
    }
    $line_counter = 1;
    while(<F>){
        if($line_counter > $total_line){
            close F;
            exit;
        }
        if($line_counter >=$start_line){
            print;
        
        }
        $line_counter++;
    }
    
    close F;
}
