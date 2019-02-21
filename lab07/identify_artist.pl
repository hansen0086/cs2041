#!/usr/bin/perl -w

%count = ();
%all = ();
foreach $file (glob "lyrics/*.txt") {
    $file =~ /\/(.*)\.txt/;
    $singer = $1;
    $singer =~ s/_/ /g;
    open F, "$file" or die;
    $all{$singer} = 0;
    while(<F>){
        @words = $_ =~ /([A-Za-z]+)/g;
        foreach $w (@words){
            $all{$singer}++;
            $count{$singer}{lc $w}++;
        }
    }
}

foreach $in (@ARGV){
    %words_in = ();
    %probability = ();
    open INPUT, "$in";
    @lines_in = <INPUT>;
    close INPUT;
    foreach $line (@lines_in){
        while ($line =~ /([A-Za-z]+)/g){
            $words_in{lc $1} += 1;
        }
    }
    foreach $name (keys %all){
        foreach $word (sort keys %words_in){
            $count{$name}{$word} = 0 if !exists $count{$name}{$word};
            $probability{$name} += log(($count{$name}{$word}+1)/($all{$name})) * $words_in{$word};
        }
    
    $highest = $probability{$name};
    $l = $name;
    }
    foreach $k (keys %probability){
        if ($probability{$k} > $highest) {
            $highest = $probability{$k};
            $l = $k;
        }
    }
    printf("%s most resembles the work of %s (log-probability=%.1f)\n",$in ,$l ,$highest);
}

