#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use mop;

role FooRole {
    has $!foo;
    method foo { $!foo }
}

class Foo with FooRole { }

class Bar with FooRole { }

{
    my $foo = Foo->new(foo => 'FOO');
    is($foo->foo, 'FOO');
}

{
    my $bar = Bar->new(foo => 'FOO');
    is($bar->foo, 'FOO');
}

is(mop::get_meta('FooRole')->get_method('foo')->associated_meta, mop::get_meta('FooRole'));
is(mop::get_meta('Foo')->get_method('foo')->associated_meta, mop::get_meta('Foo'));
is(mop::get_meta('Bar')->get_method('foo')->associated_meta, mop::get_meta('Bar'));

done_testing;
