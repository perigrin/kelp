package Kelp::Types;
use Data::Dimensions qw(&units);

use MooseX::Types -declare => [
    qw(
      Bytes
      KibiBytes
      )
];

use MooseX::Types::Moose qw(Int);

class_type 'Data::Dimensions';

subtype Bytes,     as 'Data::Dimensions', where { $_->{units}->{byte} == 1 };
subtype KibiBytes, as 'Data::Dimensions', where { $_->{units}->{byte} == 2^10 };

coerce Bytes,     from Int,       via { units( { byte => 1 },    $_ ); };
coerce Bytes,     from KibiBytes, via { units( { byte => 1 },    $_ * 1024 ) };
coerce KibiBytes, from Int,       via { units( { byte => 1024 }, $_ ); };
