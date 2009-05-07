package Kelp::Types;
use Data::Dimensions qw(&units);

use MooseX::Types -declare => [
    qw(
      Bytes
      KiloBytes
      )
];

use MooseX::Types::Moose qw(Int);

class_type 'Data::Dimensions';

subtype Bytes, as 'Data::Dimensions', where { $_->{units}->{byte} == 1 };
subtype KiloBytes, as 'Data::Dimensions',
  where { $_->{units}->{byte} == 1024 };

coerce Bytes,     from Int,       via { units( { byte => 1 },    $_ ); };
coerce Bytes,     from KiloBytes, via { units( { byte => 1 },    $_ * 1024 ) };
coerce KiloBytes, from Int,       via { units( { byte => 1024 }, $_ ); };
