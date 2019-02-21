#!/usr/bin/perl

use File::Copy;
use File::Compare;

sub main(){
    $dir = ".legit";
    #print("$#ARGV\n");
    if ($#ARGV<0){
      die "Usage:./legit.pl arguments\n";
    }
    #print("$ARGV[0]\n");
    if ($ARGV[0] eq "init" ) {
    #  print"start init\n";
      init();
    }
    elsif ($ARGV[0] eq "add"){
    #  print"start add\n";
      my @arguments = @ARGV;
      shift @arguments;
      &add(@arguments);
    }
    elsif($ARGV[0] eq "commit"){
      commit();
    }
    elsif($ARGV[0] eq "log"){
      printlog();
    }
    elsif($ARGV[0] eq "show"){
      show();
    }
    elsif($ARGV[0] eq "rm"){
      rm();
    }
    else{
      print "$ARGV[0] command not found!\n";
    }

}
#initialize the git repository. Make a directory
#called .legit and its subdirectory index.
sub init(){
    #print "trying initing\n";
    if(-e $dir and -d $dir ){
      print( "legit.pl: error: .legit already exists\n");
      exit 1;
    }
    print ("Initialized empty legit repository in .legit\n");
    mkdir ".legit";
    mkdir ".legit/index";
    mkdir ".legit/master";
    #build master branch in default
    open (my $fh,'>',".legit/index/.current_branch.txt");
    print $fh "master\n";
    close $fh;


}


#copy the files into .legit/index
sub add(){
  #print "trying adding\n";
  if(! (-e $dir and -d $dir) ){
    die "legit.pl: error: no .legit directory containing legit repository exists\n";
  }
  my @files =  @_;

  #print("trying to add @files\n");
  #print "$_\n" for @files;
  foreach $file (@files){
    $file =~ s/.legit\/index\///;
    #if the target file does not exists in the current directory
    if(! -e $file){
      my $index_name = ".legit/index/";
      #if it does not exists in the index neither,error
      if(! -e $index_name.$file){
      die "legit.pl: error: can not open '$file'\n";
      }
      #delete the file in the index
      else{
      unlink $index_name.$file;
    }
    }
    else{
      $destination = "$dir\/index\/$file";
  #    print($destination);
      copy("$file","$destination") or die "Copy failed: trying to copy from$file to $destination\n";
    }
  }
  #print("haha adding\n");
}


sub commit(){
  #./legit commit -a -m "message"
  my $commit_message;
  my @all_files;
  if($ARGV[1] eq "-a" && $ARGV[2] eq "-m" &&$#ARGV== 3){
    foreach my $file(glob ".legit/index/*"){
      push @all_files, $file;
    }
    &add(@all_files);
    $commit_message = $ARGV[3];
  }

  #./legit commit -m "message"
  elsif($ARGV[1] eq "-m" && $#ARGV == 2){
    #print("trying to commit\n");
    $commit_message = $ARGV[2];

  }
  else{
    print("usage: ./legit.pl commit -m <commit_message>\n");
    exit 1;

  }
    #check if you actually need commit or nothing (check if the index is the same as the last commit)
    my @temp_files;
     foreach my $temp_file(glob ".legit/index/*"){
        my $pure_temp_file = $temp_file;
        $pure_temp_file =~ s/.legit\/index\///;
        push @temp_files, $pure_temp_file;
     }
     if(check_index(@temp_files) == 1){
        die "nothing to commit\n";
     }
     
    $commit_message =~ s/"//g;
    $commit_message =~ s/'//g;
    $current_branch = get_current_branch();
    my $i =0;
    my $directory = ".legit/master/commit_";
    while(-d $directory.$i ){
      $i++;
    }

    mkdir $directory.$i;
    my $destination;

    #copy file from index to the currentbranch
    #print("need to copy:\n");
    foreach my $file(glob ".legit/index/*"){
      #print("$file\n");
      my $pure_filename = $file;
      $pure_filename =~ s/.legit\/index\///;
      #print("$pure_filename\n");
      $destination = ".legit/".$current_branch."/commit_".$i;
      #print "trying to copy $file to $destination\n";
      copy("$file","$destination") or die "$!\n";

    }
    #print($destination."/.current_branch.txt\n");
    open(my $fh ,'>',$destination."/.commit_message.txt");
    print $fh "$commit_message\n";
    close $fh;

    open(my $fh,'>>', ".legit/".$current_branch."/.log.txt");
    print $fh "$commit_message\n";
    close $fh;

    print("Committed as commit $i\n")
}


sub printlog(){
  my $i=0;
  my $current_branch = get_current_branch();
  my @commits;
  open(my $fh,'<', ".legit/".$current_branch."/.log.txt");
  while(my $line = <$fh>){
    chomp $line;
    #print "$line\n";
    push @commits, $i." ".$line;
    $i++;
  }
  while(my $commit = pop @commits){
    print "$commit\n";
  }
  close $fh;
}

sub show(){
  if ($#ARGV != 1 or ! ($ARGV[1] =~/.*:.*/)){
    die "usage: show <comNum:filename>\n"
  }
  else{
    my @args = split(':',$ARGV[1]);
    my $comNum = $args[0];
    my $filename = $args[1];
    #print"$comNum, $filename";
    if($comNum eq ""){
      #print("open from index\n");
      
      
      
      if(-e ".legit/index/".$filename){
        #print("try to print $filename\n");
        open my $fh,'<',".legit/index/".$filename or die "$filename file not found!\n";
        while(my $line = <$fh>){
          chomp $line;
          print("$line\n");
        }
        
        close $fh;
      }
      else{
        die "legit.pl: error: '$filename' not found in index\n";
        
        
        }

    }
    else{
      #open from the selected commit
      my $current_branch = get_current_branch();
      my $commit_dir = "commit_".$comNum;
      my $target = ".legit/".$current_branch."/".$commit_dir."/".$filename;
      my $temp_path = ".legit/".$current_branch."/".$commit_dir;
      #print"$target\n";
      if(-e $target){
        #print "$target";
        print_file($target);
      }
      elsif(! (-d $temp_path)){
        die "legit.pl: error: unknown commit '$comNum'\n";
      }
      
      else{
        die "legit.pl: error: '$filename' not found in commit $comNum\n";
      }
      
      
      
      
    }
  }
}

sub rm(){

  if($#ARGV==0){
    die "Usage: rm [--force] [--cached] filenames\n";
  }
  #force to delete files in index
  if(($ARGV[1] eq "--force" && $ARGV[2]eq"--cached")||($ARGV[2]eq"--force" &&$ARGV[1] eq"--cached")){

    my @filenames = @ARGV;
    shift @filenames;
    shift @filenames;
    shift @filenames;
    #print("@filenames\n");
    #print("trying to delete files @filenames from index\n");
    &rm_index(@filenames);
  }
  #force to delete files in both index and current directory
  elsif($ARGV[1] eq "--force"){
    my @filenames = @ARGV;
    shift @filenames;
    shift @filenames;

    &rm_index(@filenames);
    &rm_current(@filenames);

  }
  #try to delete cached, need to check first
  elsif($ARGV[1] eq "--cached"){
    my @filenames = @ARGV;
    shift @filenames;
    shift @filenames;
    my $check_result = check_index_used_for_rm(@filenames);
    if($check_result ==1){
      &rm_index(@filenames);
    }
    else{
      die "file have been modified. try --force\n";
    }
  }
  else{
    my @filenames = @ARGV;
    shift @filenames;
    ##
    my $check_result = check_index_used_for_rm(@filenames);
    my $check_result = check_current_used_for_rm(@filenames);
    

    if($check_result == 1){
      &rm_current(@filenmaes);
    }
    else{
      die "file have been modified. try --force\n";

    }
  }
}




sub get_current_branch(){
  open (my $fh,'<',".legit/index/.current_branch.txt");
  my $current_branch = <$fh>;
  chomp $current_branch;
  return $current_branch;
}
sub print_file {
    my ($target)= shift;
    #print "$target\n";
    open my $fh,'<',$target or die "$target file not found!\n";
    while(my $line = <$fh>){
      chomp $line;
      print("$line\n");
    }
    close $fh;
}

#compare the file in index ant last commit, return 1 if nothing changed
sub check_index(){
  my @files = @_;
  my $last_commit_dir = get_last_commit_dir();
  $last_commit_dir = $last_commit_dir."/";
  
  #check if the number of files are the same
  opendir my $index,".legit/index/";
  my $files_in_index = () = readdir($index);
  close $index;
  
  opendir my $last_commit, $last_commit_dir;
  my $files_in_last_commit = () = readdir($last_commit);
  if($files_in_last_commit != $files_in_index){
    #print("number is different\n");
    return 0;
  
  }
  
  
  
  
  #print("$last_commit_dir\n");
  foreach my $file(@files){

  my $index_file = ".legit/index/"."$file";
  my $last_commit_file = $last_commit_dir."$file";
  #print("trying to compare $index_file and $last_commit_file\n");
  
  if (compare("$index_file","$last_commit_file") == 0) {
    next;
	}
  else{
    #print("file $index_file is not the same as $last_commit_file\n");
    return 0;
  }
  #return 1 if nothing changed. can delete
  }
  return 1;
}

sub check_index_used_for_rm(){
  my @files = @_;
  my $last_commit_dir = get_last_commit_dir();
  $last_commit_dir = $last_commit_dir."/";
  #print("$last_commit_dir\n");
  foreach my $file(@files){

  my $index_file = ".legit/index/"."$file";
  my $last_commit_file = $last_commit_dir."$file";
  #print("trying to compare $index_file and $last_commit_file\n");
  if(-e $index_file &&(!(-e $last_commit_file))){
  
    next;
  }
  if (compare("$index_file","$last_commit_file") == 0) {
    next;
	}
  else{
    #print("file $index_file is not the same as $last_commit_file\n");
    return 0;
  }
  #return 1 if nothing changed. can delete
  }
  return 1;
}







sub check_current(){
  my @files = @_;
  my $last_commit_dir = get_last_commit_dir();
  $last_commit_dir = $last_commit_dir."/";
  #print("$last_commit_dir\n");
  foreach my $file(@files){

  my $current_file = $file;
  my $last_commit_file = $last_commit_dir."$file";
  #print("trying to compare $current_file and $last_commit_file\n");
  
  if (compare("$current_file","$last_commit_file") == 0) {
    next;
	}
  else{
   die "legit.pl: error: '$file' is not in the legit repository\n";
    #print("index is not same as last commit, not able to delete\n");
    return 0;
  }
  #return 1 if nothing changed. can delete
  
  }
  return 1;
  #print("$last_commit_dir\n");
}


sub check_current_used_for_rm(){
  my @files = @_;
  my $last_commit_dir = get_last_commit_dir();
  $last_commit_dir = $last_commit_dir."/";
  #print("$last_commit_dir\n");
  foreach my $file(@files){

  my $current_file = $file;
  my $last_commit_file = $last_commit_dir."$file";
  #print("trying to compare $current_file and $last_commit_file\n");
  if(! -e $last_commit_file){
    die "legit.pl: error: '$file' is not in the legit repository\n";
  }
  if (compare("$current_file","$last_commit_file") == 0) {
    next;
	}
  else{
   #die "legit.pl: error: '$file' is not in the legit repository\n";
    #print("index is not same as last commit, not able to delete\n");
    return 0;
  }
  #return 1 if nothing changed. can delete
  
  }
  return 1;
  #print("$last_commit_dir\n");
}








sub rm_current(){
  my @files = @_;

  unlink @files;

}
sub rm_index(){
  my @files = @_;
  my $path = ".legit/index/";
  foreach my $file(@files){
    unlink "$path"."$file";
  }
}

sub get_last_commit_dir(){
  my $current_branch = get_current_branch();
  open (my $fh,'<',".legit/".$current_branch."/.log.txt");
  my $commitNum=-1;
  while(my $line = <$fh>){
    $commitNum++;
  }

  my $last_commit_dir = ".legit/master/commit_".$commitNum;
  return $last_commit_dir;
}

main();
