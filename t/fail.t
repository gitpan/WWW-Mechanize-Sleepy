use Test::More tests => 4; 
use strict;
use warnings;

use_ok( 'WWW::Mechanize::Sleepy' );

eval { my $a = WWW::Mechanize::Sleepy->new(); };
like( $@, qr/must supply 'sleep' parameter/, 'no parm'  );

eval { my $a = WWW::Mechanize::Sleepy->new( sleep => 'three' ); };
like( $@, qr/sleep parameter must be an integer or a range i1..i2/, 
    'non int/range sleep' );

eval { my $a = WWW::Mechanize::Sleepy->new( sleep => '5..2' ); };
like( $@, qr/sleep range \(i1..i2\) must have i1 < i2/,, 
    'n2 greater than n1 in range' );


