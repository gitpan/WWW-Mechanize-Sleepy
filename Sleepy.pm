package WWW::Mechanize::Sleepy;

our $VERSION = 0.2;

use strict;
use warnings;
use Carp qw( croak );
use base qw( WWW::Mechanize );

=head1 NAME 

WWW::Mechanize::Sleepy - A Sleepy Mechanize Agent

=head1 SYNOPSIS

    use WWW::Mechanize::Sleepy;
   
    # sleep 5 seconds between requests
    my $a = WWW::Mechanize::Sleepy->new( sleep => 5 );
    $a->get( 'http://www.ctw.org' );

    # sleep between 5 and 20 seconds between requests
    my $a = WWW::Mechanize::Sleepy->new( sleep => '5..20' );
    $a->get( 'http://www.ctw.org' );

=head1 DESCRIPTION

Sometimes when testing the behavior of a webserver it is important to be able
to space out your requests in order to simulate a person reading, thinking (or 
sleeping) at the keyboard.

WWW::Mechanize::Sleepy subclasses WWW::Mechanize to provide pauses between your server requests. Use it just like you would use WWW::Mechanize.

=head1 METHODS

All the methods are the same as WWW::Mechanize, except for the constructor
which accepts a few additional parameters.

=head2 new()

The constructor which acts just like the WWW::Mechanize constructor except
you can pass it some extra parameters. 

=over 4

=item * sleep 

An amount of time in seconds to sleep.

    my $a = WWW::Mechanize::Sleepy->new( sleep => 5 );

Or a range of time to sleep to sleep within. Your robot will sleep a random
amount of time within that range.

    my $a = WWW::Mechanize::Sleepy->new( sleep => '5..20' );

=cut

=head1 AUTHORS

=over 4

=item * Ed Summers <ehs@pobox.com>

=back

=head1 SEE ALSO

=over 4

=item * L<WWW::Mechanize>

=back

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under 
the same terms as Perl itself.

=cut

sub new {
    my $class = shift;
    my %parms = @_;
    croak( "must supply 'sleep' parameter" )
	if ( ! exists( $parms{ sleep } ) );
    my $sleep = $parms{ sleep };
    croak( "sleep parameter must be an integer or a range i1..i2" )
	if ( $sleep !~ /^(\d+)|(\d+\.\.\d+)$/ );
    if ( $sleep =~ /(\d+)\.\.(\d+)/ and $1 >= $2 ) { 
	croak( "sleep range (i1..i2) must have i1 < i2" );
    }
    delete( $parms{ sleep } );
    my $self = $class->SUPER::new( %parms );
    $self->{ Sleepy_Time } = $sleep;
    return( $self );
}

sub get {
    my $self = shift;
    $self->_sleep();
    $self->SUPER::get( @_ );
}

sub back {
    my $self = shift;
    $self->_sleep();
    $self->SUPER::back( @_ );
}

sub request {
    my $self = shift;
    $self->_sleep();
    $self->SUPER::request( @_ );
}

sub _sleep {
    my $self = shift;
    my $sleep;
    if ( $self->{ Sleepy_Time } =~ /^(\d+)\.\.(\d+)$/ ) { 
	$sleep = int( rand( $2 - $1 ) ) + $1;
    } else { 
	$sleep = $self->{ Sleepy_Time };
    }
    sleep( $sleep );
}

