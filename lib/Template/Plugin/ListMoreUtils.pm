package Template::Plugin::ListMoreUtils;

use strict;
use warnings;

no strict 'refs';

use vars qw($VERSION @ISA);

use List::MoreUtils;
use Params::Util qw(_ARRAY);
use Template::Plugin::Procedural;
use vars qw(@ISA $VERSION);

$VERSION = '0.01';
@ISA     = qw(Template::Plugin::Procedural);

=head1 NAME

Template::Plugin::ListMoreUtils - TT2 plugin to use List::MoreUtils

=head1 SYNOPSIS

  [% my1to9even = [ 2, 4, 6, 8 ];
     my1to9prim = [ 2, 3, 5, 7 ];
     my1to9odd  = [ 1, 3, 5, 7, 9 ]; %]

  [% USE ListMoreUtils %]
  [% my1to9all = ListMoreUtils.uniq( my1to9even.merge( my1to9prim, my1to9odd ) ); %]
  1 .. 9 are [% my1to9all.size() %]

=head1 DESCRIPTION

This module provides an Template::Toolkit interface to Tassilo von Parseval's
L<List::MoreUtils>. It extends the built-in functions dealing with lists as
well as L<Template::Plugin::ListUtil>.

=head1 USAGE

To use this module from templates, you can choose between class interface

  [% my1to9even = [ 2, 4, 6, 8 ];
     my1to9prim = [ 2, 3, 5, 7 ];
     my1to9odd  = [ 1, 3, 5, 7, 9 ]; %]

  [% USE ListMoreUtils %]
  [% my1to9all = ListMoreUtils.uniq( my1to9even.merge( my1to9prim, my1to9odd ) ); %]
  1 .. 9 are [% my1to9all.size() %]

or the virtual method interface, which is described in
L<Template::Plugin::ListMoreUtilsVMethods>.

=head1 FUNCTIONS PROVIDED

All functions behave as documented in L<List::MoreUtils>. I don't plan to
copy the entire POD from there.
L<Template::Toolkit> provides lists as list reference, so they were expanded
before the appropriate function in C<List::MoreUtils> is called.

=head2 any BLOCK LIST

=cut

sub any(&\@) { List::MoreUtils::any( \&{ $_[0] }, @{ $_[1] } ); }

=head2 all BLOCK LIST

=cut

sub all(&\@) { List::MoreUtils::all( \&{ $_[0] }, @{ $_[1] } ); }

=head2 none BLOCK LIST

=cut

sub none(&\@) { List::MoreUtils::none( \&{ $_[0] }, @{ $_[1] } ); }

=head2 notall BLOCK LIST

=cut

sub notall(&\@) { List::MoreUtils::notall( \&{ $_[0] }, @{ $_[1] } ); }

=head2 true BLOCK LIST

=cut

sub true(&\@) { List::MoreUtils::true( \&{ $_[0] }, @{ $_[1] } ); }

=head2 false BLOCK LIST

=cut

sub false(&\@) { List::MoreUtils::false( \&{ $_[0] }, @{ $_[1] } ); }

=head2 firstidx BLOCK LIST

=head2 first_index BLOCK LIST

=cut

sub firstidx(&\@) { List::MoreUtils::firstidx( \&{ $_[0] }, @{ $_[1] } ); }
*first_index = *{'firstidx'}{CODE};

=head2 lastidx BLOCK LIST

=head2 last_index BLOCK LIST

=cut

sub lastidx(&\@) { List::MoreUtils::lastidx( \&{ $_[0] }, @{ $_[1] } ); }
*last_index = *{'lastidx'}{CODE};

=head2 insert_after BLOCK VALUE LIST

=cut

*insert_after = *{'List::MoreUtils::insert_after'}{CODE} if ( defined( *{'List::MoreUtils::insert_after'}{CODE} ) );

=head2 insert_after_string STRING VALUE LIST

=cut

*insert_after_string = *{'List::MoreUtils::insert_after_string'}{CODE}
  if ( defined( *{'List::MoreUtils::insert_after_string'}{CODE} ) );

=head2 apply BLOCK LIST

=cut

sub apply(&\@) { List::MoreUtils::apply( \&{ $_[0] }, @{ $_[1] } ); }

=head2 after BLOCK LIST

=cut

sub after(&\@) { List::MoreUtils::after( \&{ $_[0] }, @{ $_[1] } ); }

=head2 after_incl BLOCK LIST

=cut

sub after_incl(&\@) { List::MoreUtils::after_incl( \&{ $_[0] }, @{ $_[1] } ); }

=head2 before BLOCK LIST

=cut

sub before(&\@) { List::MoreUtils::before( \&{ $_[0] }, @{ $_[1] } ); }

=head2 before_incl BLOCK LIST

=cut

sub before_incl(&\@) { List::MoreUtils::before_incl( \&{ $_[0] }, @{ $_[1] } ); }

=head2 indexes BLOCK LIST

=cut

sub indexes(&\@) { List::MoreUtils::indexes( \&{ $_[0] }, @{ $_[1] } ); }

=head2 firstval BLOCK LIST

=head2 first_value BLOCK LIST

=cut

sub firstval(&\@) { List::MoreUtils::firstval( \&{ $_[0] }, @{ $_[1] } ); }
*first_value = *{'firstval'}{CODE};

=head2 lastval BLOCK LIST

=head2 last_value BLOCK LIST

=cut

sub lastval(&\@) { List::MoreUtils::lastval( \&{ $_[0] }, @{ $_[1] } ); }
*last_value = *{'lastval'}{CODE};

=head2 pairwise BLOCK LIST LIST

Unlike the original C<pairwise>, both variables are given through C<@_>.
Template::Toolkit uses eval to evaluate the perl code declared there and
passes neither C<$a> nor C<$b> (which sounds reasonable to me).

=cut

sub pairwise(&\@\@)
{
    my $userfn = $_[0];
    List::MoreUtils::pairwise( sub { &{$userfn}( $a, $b ); }, @{ $_[1] }, @{ $_[2] } );
}

=head2 minmax LIST

=cut

sub minmax(\@) { List::MoreUtils::minmax( @{ $_[0] } ); }

=head2 uniq LIST

=cut

sub uniq(\@) { List::MoreUtils::uniq( @{ $_[0] } ); }

=head2 mesh

=head2 zip

=cut

*mesh = *{'List::MoreUtils::mesh'}{CODE} if ( defined( *{'List::MoreUtils::mesh'}{CODE} ) );
*zip  = *{'List::MoreUtils::zip'}{CODE}  if ( defined( *{'List::MoreUtils::zip'}{CODE} ) );

=head2 part BLOCK LIST

=cut

sub part(&\@) { List::MoreUtils::part( \&{ $_[0] }, @{ $_[1] } ) }

=head2 bsearch BLOCK LIST

This function is available only when List::MoreUtils 0.23 or newer is used.

Unlike the original C<bsearch>, the value to compare with is passed in
C<$_[0]>.  Template::Toolkit uses eval to evaluate the perl code declared
there and don't pass C<$_> (which sounds reasonable to me).

=cut

if ( defined( *{'List::MoreUtils::bsearch'}{CODE} ) )
{
    eval <<'EOBS';
sub bsearch(&\@)
{
    my $userfn = $_[0];
    List::MoreUtils::bsearch( sub { &{$userfn}( $_ ); }, @{$_[1]} );
}
EOBS
}

=head1 INSTALL

To install this module, use

  perl Build.PL
  ./Build
  ./Build test
  ./Build install

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

perl(1), L<List::MoreUtils>, <Template::Plugin::ListUtil>

=cut

1;
