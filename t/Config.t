use strict;
use vars qw/ $filename $loaded /;


BEGIN {
    $| = 1;
    $filename = 'config.test';
}


END {
    ok(0) unless $loaded;
    unlink $filename if defined $filename and -e $filename;
}


my $count = 1;
sub ok {
    shift or print "not ";
    print "ok $count\n";
    ++$count;
}


print "1..12\n";


use Tie::MLDBM;
$loaded = 1;
ok(1);


my $object = tie my %hash, 'Tie::MLDBM', {
    'Lock'      =>  'Null',
    'Serialise' =>  'Storable',
    'Store'     =>  'DB_File'
}, $filename;

ok( defined $object );
ok( defined $object->{'Modules'} );
ok( defined $object->{'Args'} );
ok( defined $object->{'Config'} );
ok( defined $object->{'Store'} );

ok( defined $object->{'Modules'}->{'Lock'} );
ok( defined $object->{'Modules'}->{'Serialise'} );
ok( defined $object->{'Modules'}->{'Store'} );

ok( $object->{'Modules'}->{'Lock'} eq 'Tie::MLDBM::Lock::Null' );
ok( $object->{'Modules'}->{'Serialise'} eq 'Tie::MLDBM::Serialise::Storable' );
ok( $object->{'Modules'}->{'Store'} eq 'Tie::MLDBM::Store::DB_File' );


__END__
