#!/usr/bin/perl
use Locale::PO;

$po = Locale::PO->load_file_asarray("/tmp/vi.po");
$intro = shift @$po;

foreach my $entry (@$po){
    my $msgid=$entry->msgid;
    my $msgstr=`translate en:vi -b $msgid`;
    $entry->msgstr($msgstr);
}

unshift @$po,$intro;
Locale::PO->save_file_fromarray("/tmp/test",$po);
