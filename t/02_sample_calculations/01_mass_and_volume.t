#!/usr/bin/perl -w
use strict;
use Test::More tests => 11;

use Kelp::Types ':all';

## Mass and Volume

#  10 feet 12 feet 8 feet -> gallons
# 552960/77 (approx. 7181.298701298701)
ok( my $size = to_Gallons( to_Feet(10) * to_Feet(12) * to_Feet(8) ) );
is( $size, '7181.298701298701' );

#  10. feet 12 feet 8 feet water -> pounds
# 59930.84215309883
ok( my $weight = to_Pounds( to_WeightInWater( to_Feet(10) * to_Feet(8) ) ) );
is( $weight, 59930.84215309883 );

#  2. tons / (10 feet 12 feet water) -> feet
# 0.5339487791320047
ok( my $size
        = to_Feet( to_Tons(2) / to_WeightInWater( to_Feet(10) * to_Feet(8) ) )
);
is( $size, 0.5339487791320047 );
