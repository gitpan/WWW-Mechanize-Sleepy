use strict;
use warnings;

use Test::More tests => 21;
use_ok(  'WWW::Mechanize::Sleepy' );

$a = WWW::Mechanize::Sleepy->new( sleep => 3 );
timed( '$a->get( "http://www.google.com/intl/en" )', 3 );
timed( '$a->follow_link( text => "Images" )', 3 );
timed( '$a->back()', 3 );
timed( '$a->reload()', 3 );
timed( '$a->submit()', 3 );

$a = WWW::Mechanize::Sleepy->new( sleep => '5..10' );
timed( '$a->get( "http://www.google.com/intl/en/" )', '5..10' );
timed( '$a->follow_link( text => "Images" )', '5..10' );
timed( '$a->back()', '5..10' );
timed( '$a->reload()', '5..10' );
timed( '$a->submit()', '5..10' );

sub timed {
    my ( $cmd, $expected ) = @_;

    my $t1 = time();
    eval( $cmd );
    my $elapsed = time() - $t1;
    ok( $a->success(), "$cmd : success" );

    if ( $expected =~ /\.\./ ) { 
	my ( $r1, $r2 ) = split( /\.\./, $expected );
	ok( 
	    ($elapsed >= $r1),
	    "$cmd : took between $r1 and $r2 seconds"
	);
    } else { 
	ok(	
	    ($elapsed >= $expected),
	    "$cmd : slept at least $expected seconds" 
	);
    }

}





