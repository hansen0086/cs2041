#!/usr/bin/perl 


while($string = <STDIN>){

    $string =~ s/0|1|2|3|4/</g;
    $string =~ s/6|7|8|9/>/g;
    print($string);
}
