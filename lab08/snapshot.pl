#!/usr/bin/perl -w

use strict;
use File::Copy;

sub save(){
	#create directory;
	my $dirname = ".snapshot.";
	my $i = 0;
	my $old_dirname = $dirname;
	$dirname .= $i;

	while(-d $dirname){
		$dirname = $old_dirname;
		$i++;
		$dirname .= $i;
	}


	unless(mkdir $dirname){
		die "Cannot create this directory\n";
	}

	print "Creating snapshot $i\n";

	#copy file
	foreach my $file(glob "*"){
		if($file =~ /^\./ or $file eq "snapshot.pl"){
			next;
		}
		#print "$file\n";
		if(-f $file){
			copy("$file","$dirname/$file") or die "$!\n";
		}
	}

	return $i;
}

sub load{
	my($number) = @_;

	#copy file
	foreach my $file(glob ".snapshot.$number/*"){

		#print "$file\n";
		my $src_dest = $file;
		$src_dest =~ s/.snapshot.$number\///;
		if(-f $file){
			copy("$file","$src_dest") or die "$!\n";
		}
	}
}

sub main(){
	if($ARGV[0] =~ /save/){
		save();
	}elsif($ARGV[0] =~ /load/ and $ARGV[1] =~ /\d+/){
		my $which_dir = save();
		load($ARGV[1]);

		print "Restoring snapshot $ARGV[1]\n";
	}
}
main();
