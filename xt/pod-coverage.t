#! perl

use strict;
use warnings;

use Test::More;
use Test::Pod::Coverage;
use Pod::Coverage;

my @modules = all_modules();
plan tests => scalar @modules - 1;
foreach my $module (@modules) {
   next if ($module eq 'Template::Plugin::ListMoreUtilsVMethods');
   pod_coverage_ok($module);
}
