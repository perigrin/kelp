package Kelp::Types;
use Data::Dimensions qw(&units);

use MooseX::Types -declare => [
    qw(
      Bytes
      KibiBytes
      MebiBytes
      GibiBytes
      TebiBytes
      PebiBytes
      ExbiBytes
      )
];

use MooseX::Types::Moose qw(Int);

class_type 'Data::Dimensions';

use constant kibi => 2**10;
use constant mebi => 2**20;
use constant gibi => 2**30;
use constant tebi => 2**40;
use constant pebi => 2**50;
use constant exbi => 2**60;

subtype Bytes,     as 'Data::Dimensions', where { $_->{units}->{byte} == 1 };
subtype KibiBytes, as 'Data::Dimensions', where { $_->{units}->{byte} == kibi };
subtype MebiBytes, as 'Data::Dimensions', where { $_->{units}->{byte} == mebi };
subtype GibiBytes, as 'Data::Dimensions', where { $_->{units}->{byte} == gibi };
subtype TebiBytes, as 'Data::Dimensions', where { $_->{units}->{byte} == tebi };
subtype PebiBytes, as 'Data::Dimensions', where { $_->{units}->{byte} == pebi };
subtype ExbiBytes, as 'Data::Dimensions', where { $_->{units}->{byte} == exbi };

coerce Bytes,     from Int, via { units( { byte => 1 },    $_ ); };
coerce KibiBytes, from Int, via { units( { byte => kibi }, $_ ); };

coerce Bytes, from KibiBytes, via { units( { byte => 1 }, $_ * kibi ) };
coerce Bytes, from MebiBytes, via { units( { byte => 1 }, $_ * mebi ) };
coerce Bytes, from GibiBytes, via { units( { byte => 1 }, $_ * gibi ) };
coerce Bytes, from TebiBytes, via { units( { byte => 1 }, $_ * tebi ) };
coerce Bytes, from PebiBytes, via { units( { byte => 1 }, $_ * pebi ) };
coerce Bytes, from ExbiBytes, via { units( { byte => 1 }, $_ * exbi ) };