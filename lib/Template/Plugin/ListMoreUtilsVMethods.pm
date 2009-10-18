package Template::Plugin::ListMoreUtilsVMethods;

use strict;
use warnings;

use vars qw($VERSION @ISA $VMETHOD_PACKAGE @LIST_OPS);

use Template::Plugin::VMethods;
$VERSION = '0.02';
@ISA     = qw(Template::Plugin::VMethods);

use Template::Plugin::ListMoreUtils;
$VMETHOD_PACKAGE = 'Template::Plugin::ListMoreUtils';

@LIST_OPS = (
              qw(mesh zip uniq minmax),
              any                 => \&any,
              all                 => \&all,
              none                => \&none,
              notall              => \&notall,
              true                => \&true,
              false               => \&false,
              firstidx            => \&firstidx,
              first_index         => \&first_index,
              lastidx             => \&lastidx,
              last_index          => \&last_index,
              insert_after        => \&insert_after,
              insert_after_string => \&insert_after_string,
              apply               => \&apply,
              after               => \&after,
              after_incl          => \&after_incl,
              before              => \&before,
              before_incl         => \&before_incl,
              indexes             => \&indexes,
              firstval            => \&firstval,
              first_value         => \&first_value,
              lastval             => \&lastval,
              last_value          => \&last_value,
              pairwise            => \&pairwise,
              part                => \&part
            );

=head1 NAME

Template::Plugin::ListMoreUtilsVMethods - TT2 plugin to use List::MoreUtils as virtual methods of lists

=head1 SYNOPSIS

  [% my1to9even = [ 2, 4, 6, 8 ];
     my1to9prim = [ 2, 3, 5, 7 ];
     my1to9odd  = [ 1, 3, 5, 7, 9 ]; %]

  [% USE ListMoreUtilsVMethods %]
  [% my1and9 = my1to9all.minmax; %]
  [% my1and9[0] %] is the smalled number of 1 .. 9, the largest is [% my1and9[1] %]

=head1 DESCRIPTION

This module provides an Template::Toolkit interface to Tassilo von Parseval's
L<List::MoreUtils>. It extends the built-in functions dealing with lists as
well as L<Template::Plugin::ListUtil>.

=head1 USAGE

To use this module from templates, you can choose between class interface

  [% my1to9even = [ 2, 4, 6, 8 ];
     my1to9prim = [ 2, 3, 5, 7 ];
     my1to9odd  = [ 1, 3, 5, 7, 9 ]; %]

  [% USE ListMoreUtilsVMethods %]
  [% my1and9 = my1to9all.minmax; %]
  [% my1and9[0] %] is the smalled number of 1 .. 9, the largest is [% my1and9[1] %]

=head1 FUNCTIONS PROVIDED

The functions/methods provided are the same as in
L<Template::Plugin::ListMoreUtils>, regardless the preferred interface.

=cut

no strict 'refs';

sub any(\@&) { List::MoreUtils::any( \&{ $_[1] }, @{ $_[0] } ); }

sub all(\@&) { List::MoreUtils::all( \&{ $_[1] }, @{ $_[0] } ); }

sub none(\@&) { List::MoreUtils::none( \&{ $_[1] }, @{ $_[0] } ); }

sub notall(\@&) { List::MoreUtils::notall( \&{ $_[1] }, @{ $_[0] } ); }

sub true(\@&) { List::MoreUtils::true( \&{ $_[1] }, @{ $_[0] } ); }

sub false(\@&) { List::MoreUtils::false( \&{ $_[1] }, @{ $_[0] } ); }

sub firstidx(\@&) { List::MoreUtils::firstidx( \&{ $_[1] }, @{ $_[0] } ); }
sub first_index(\@&);
*first_index = *{'firstidx'}{CODE};

sub lastidx(\@&) { List::MoreUtils::lastidx( \&{ $_[1] }, @{ $_[0] } ); }
sub last_index(\@&);
*last_index = *{'lastidx'}{CODE};

sub insert_after (\@&$) { List::MoreUtils::insert_after( \&{ $_[1] }, $_[2], @{ $_[0] } ); }
sub insert_after_string (\@$$) { List::MoreUtils::insert_after_string( $_[1], $_[2], @{ $_[0] } ); }

sub apply(\@&) { List::MoreUtils::apply( \&{ $_[1] }, @{ $_[0] } ); }

sub after(\@&) { List::MoreUtils::after( \&{ $_[1] }, @{ $_[0] } ); }

sub after_incl(\@&) { List::MoreUtils::after_incl( \&{ $_[1] }, @{ $_[0] } ); }

sub before(\@&) { List::MoreUtils::before( \&{ $_[1] }, @{ $_[0] } ); }

sub before_incl(\@&) { List::MoreUtils::before_incl( \&{ $_[1] }, @{ $_[0] } ); }

sub indexes(\@&) { List::MoreUtils::indexes( \&{ $_[1] }, @{ $_[0] } ); }

sub firstval(\@&) { List::MoreUtils::firstval( \&{ $_[1] }, @{ $_[0] } ); }
sub first_value(\@&);
*first_value = *{'firstval'}{CODE};

sub lastval(\@&) { List::MoreUtils::lastval( \&{ $_[1] }, @{ $_[0] } ); }
sub last_value(\@&);
*last_value = *{'lastval'}{CODE};

sub pairwise(\@&\@)
{
    my $userfn = $_[1];
    List::MoreUtils::pairwise( sub { &{$userfn}( $a, $b ); }, @{ $_[0] }, @{ $_[2] } );
}

sub part(\@&) { List::MoreUtils::part( \&{ $_[1] }, @{ $_[0] } ) }

if ( defined( *{'List::MoreUtils::bsearch'}{CODE} ) )
{
    eval <<'EOBS';
sub bsearch(\@&)
{
    my $userfn = $_[1];
    List::MoreUtils::bsearch( sub { &{$userfn}( $_ ); }, @{$_[0]} );
}
    push( @LIST_OPS, bsearch => \&bsearch );
EOBS
}

=head1 LIMITATION

Except the typical limitations known from perl functions embedded in
L<Template::Toolkit>, the only limitation I currently miss is being
able to use TT2 defined macros as callback.

=head1 SUPPORT

Free support can be requested via regular CPAN bug-tracking system. There is
no guaranteed reaction time or solution time. It depends on business load.
That doesn't mean that ticket via rt aren't handles as soon as possible, that
means that soon depends on how much I have to do.

Business and commercial support should be aquired via preferred freelancer
agencies.

=head1 AUTHOR

    Jens Rehsack
    CPAN ID: REHSACK
    rehsack@cpan.org
    http://search.cpan.org/~rehsack/

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=head1 SEE ALSO

perl(1), L<List::MoreUtils>, <Template::Plugin::VMethods>

=cut

1;
