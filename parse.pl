#!/usr/bin/env perl
use strict;
use warnings;

my $orig = 'templates.pot';
my $fix = 'vi.po';
open my $fd_orig, $orig or die "Could not open $orig: $!";
open my $fd_fix, $fix or die "Could not open $fix: $!";

my $msgid_orig = 1;
my $msgstr_fix = 0;
my $line_orig = "";
my $line_fix = "";
my $tmp=0;
my $tmp_fix=0;
open(my $output,'>','out');

while(1){
    
    if (!$tmp_fix && $msgid_orig == $msgstr_fix+1){
    	$line_orig = <$fd_orig>;
    }
    if ( !$tmp&& !$tmp_fix && ($msgstr_fix == $msgid_orig -2)|| ($msgstr_fix == $msgid_orig-3)){
    	$line_fix = <$fd_fix>;
    }
    
    if (!$tmp&&grep(/^msgid/,$line_orig)){
	$msgid_orig +=1;
	$tmp=1;
    }
    if ($tmp && grep(/^msgstr/,$line_orig)){
	$tmp=0;
	$msgid_orig +=1;

    }
    if (!$tmp_fix&&grep(/^msgstr/,$line_fix)){
	$tmp_fix=1;
	$msgstr_fix+=1;

    }
    if ($tmp_fix && grep(/^msgid/,$line_fix)){
	$tmp_fix = 0;
	$msgstr_fix+=1;

    }

    print "ORIG: $msgid_orig:$line_orig";
    print "FIX:  $msgstr_fix:$line_fix";
    if ($tmp && $msgid_orig == $msgstr_fix+2){
	print "\e[32m==>ORIG: $line_orig\e[0m";
	print $output $line_orig;
	$line_orig = <$fd_orig>;
    }
    if ($tmp_fix && $msgstr_fix == $msgid_orig-2){
	print "\e[32m==>FIX: $line_fix\e[0m";
	print $output $line_fix;
	$line_fix = <$fd_fix>;
    }
    print "\n";

    if (eof($fd_orig)){
	last;
    }

    if (eof($fd_fix)){
	last;
    }

}

close $fd_orig;
close $fd_fix;
