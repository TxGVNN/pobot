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
    die("Please select a input file");
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
