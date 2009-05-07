#!/usr/bin/perl -w
use strict;
use Test::More tests => 11;

use Kelp::Types ':all';

{
    ok( my $byte = to_Bytes(1), 'create a byte' );
    ok( is_Bytes($byte), 'is a byte' );
    is( $byte, 1, 'right size' );
}
{
    ok( my $kb = to_KibiBytes(3), 'create 3 Kilobyte' );
    ok( is_KibiBytes($kb), 'it is a kilobyte' );
    is( $kb, 3, 'got a kilobyte' );
    ok( my $bytes = to_Bytes($kb) );
    is( $bytes, 1024 * 3, 'right size' );
}

{
    ok( my $uuid_size = to_Bytes(16), '16 byte uuid' );
    ok(
        my $storage_required = to_GibiBytes( $uuid_size * 10**9 ),
        'billion uuids is how big?'
    );
    is($storage_required, 14.9011611938477, 'right size')
}
