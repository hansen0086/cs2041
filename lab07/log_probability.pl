#!/usr/bin/perl


$word_count = 0;
$log_total =0;

foreach $file_name (glob "lyrics/*.txt"){
    foreach $keyword (@ARGV){
    $log_total=0;
    #print "$file_name\n";
    $curr_name = $file_name;
    $curr_name =~ s/[a-z]+\///g;
    $curr_name =~ s/.txt//g;
    $curr_name =~ s/_/ /g;
    
    
    #print "$curr_name\n";
    
    
    open $FILE,'<',$file_name or die "cant open$file_name\n";
    
    $word_count=0;
    $total_word=0;
    while($line= <$FILE>){
    
    
    #print"sth";
    chomp $line;
    @words = split (/[^A-Za-z]+/,$line);
    
    
    foreach $word(@words){
        if($word eq ""){
        next;
        }
        if(lc($word) eq lc($keyword)){
        $word_count ++;
        }
        $total_word ++; 
        
    } 
}
#print "$ARGV[0] occurred $word_count times in $total_word\n";

#$result = $word_count/$total_word;

$log_word = log (($word_count+1)/$total_word);
$log_total += $log_word;
}
    
#printf("%4d/%6d = %.9f %s\n",$word_count, $total_word,$result, $curr_name);

    
printf("log((%d+1)/%6d) = %8.4f %s\n",$word_count,$total_word,$log_total,$curr_name);
    


}






