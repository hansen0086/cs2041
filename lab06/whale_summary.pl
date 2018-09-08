#!/usr/bin/perl 

$i=0;
$j=0;
open FILE, '<', $ARGV[0] or die "$0: Can't open $file: $0\n";
while ($line = <FILE>) {
   ($num[$i], $breed[$j]) = $line =~ /(\d+)\s([^\d]+$)/;
   chomp $breed[$j];
   
   $breed[$j] =~ tr/[A-Z]/[a-z]/;
   $breed[$j] =~ s/\s+$//;
   $breed[$j] =~ s/^\s+//;
   $breed[$j] =~ s/\s+/ /g;
   $breed[$j] =~ s/[ ]+/ /;
   $breed[$j] =~ s/[ ]+$//;
   $breed[$j] =~ s/s$//;
   $i++;
   $j++;
}
$total = @num;
$curr = 0;
@arrage_num = ();
@arrage_breed = ();
$ar = 0;
@pods = ();
while ($curr < $total) {
   $next = $curr + 1;
   if ($num[$curr] != -1) {
      $pods[$ar] = 1;
      $arrage_num[$ar] = $num[$curr];
      $arrage_breed[$ar] = $breed[$curr];
      while ($next < $total){
         if ($breed[$curr] eq $breed[$next]) {
            $pods[$ar]++;
            $arrage_num[$ar] += $num[$next];
            $num[$next] = -1;
         }
         $next++;
      }
      $ar++;
   }
   $curr++;
}

$all = @arrage_breed;
for (my $pos = 0; $pos < $all; $pos++) {
   $pod{$arrage_breed[$pos]} = "$pods[$pos]";
}
@pod_alph = ();
$index = 0;
foreach my $y (sort keys %pod) {
   $pod_alph[$index] = $pod{$y};
   $index++;
}

for (my $var = 0; $var < $all; $var++) {
   $hash{$arrage_breed[$var]} = "$arrage_num[$var]";
}
$p=0;
foreach my $k (sort keys %hash) {
   print "$k observations: $pod_alph[$p] pods, $hash{$k} individuals\n";
   $p++;
}
