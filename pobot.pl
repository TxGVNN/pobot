#!/usr/bin/perl
#@author: Giap Tran <TxGVNN@gmail.com>

use Locale::PO;
use Getopt::Std;

our $lang="en:vi";
our $output="/dev/stdout";

sub do_help{
    print "Usage:\tpobot.pl -i <input-file> [-o output-file] [-l srclang:dstlang]\n";
    print  "Ex:\tpobot.pl -l en:vi -i 01_the-debian-project.po -o 01_the-debian-project.po.vi";
    exit 1
}

my %options=();
getopts("i:o:l:", \%options);

if (defined $options{l}){
    $lang=$options{l};
}
if (!defined $options{i}){
    do_help();
}
our $input = $options{i};

if (defined $options{o}){
    $output=$options{o};
}

my $po = Locale::PO->load_file_asarray($input);
my $size=@$po;

my $intro = shift @$po;
my $count=1;
foreach my $entry (@$po){
    print "\rTranslate $count/$size";
    $count++;
    my $msgid=$entry->msgid;
    my $msgstr=`translate $lang -b $msgid`;
    $entry->msgstr($msgstr);
}
print "\n";

unshift @$po,$intro;
Locale::PO->save_file_fromarray($output,$po);
