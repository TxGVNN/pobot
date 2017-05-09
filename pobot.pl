#!/usr/bin/perl
use Locale::PO;
use Getopt::Std;

our $lang="en:vi";
our $output="/dev/stdout";

my %options=();
getopts("i:o:l:", \%options);

if (defined $options{l}){
    $lang=$options{l};
}
if (!defined $options{i}){
    die("Please select po file input");
}
our $input = $options{i};

if (defined $options{o}){
    $output=$options{o};
}

my $po = Locale::PO->load_file_asarray($input);
my $intro = shift @$po;

foreach my $entry (@$po){
    my $msgid=$entry->msgid;
    my $msgstr=`translate en:vi -b $msgid`;
    $entry->msgstr($msgstr);
}

unshift @$po,$intro;
Locale::PO->save_file_fromarray($output,$po);
