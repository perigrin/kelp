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

use MooseX::Types::Moose qw(Int Any);

class_type 'Data::Dimensions';

use constant kibi => 2**10;
use constant mebi => 2**20;
use constant gibi => 2**30;
use constant tebi => 2**40;
use constant pebi => 2**50;
use constant exbi => 2**60;

subtype Bytes,     as 'Data::Dimensions', where { $_->{units}{byte} == 1 };
subtype KibiBytes, as 'Data::Dimensions', where { $_->{units}{byte} == kibi };
subtype MebiBytes, as 'Data::Dimensions', where { $_->{units}{byte} == mebi };
subtype GibiBytes, as 'Data::Dimensions', where { $_->{units}{byte} == gibi };
subtype TebiBytes, as 'Data::Dimensions', where { $_->{units}{byte} == tebi };
subtype PebiBytes, as 'Data::Dimensions', where { $_->{units}{byte} == pebi };
subtype ExbiBytes, as 'Data::Dimensions', where { $_->{units}{byte} == exbi };

coerce Bytes,     from Int, via { units( { byte => 1 },    $_ ); };
coerce KibiBytes, from Int, via { units( { byte => kibi }, $_ ); };
coerce MebiBytes, from Int, via { units( { byte => mebi }, $_ ); };
coerce GibiBytes, from Int, via { units( { byte => gibi }, $_ ); };
coerce PebiBytes, from Int, via { units( { byte => pebi }, $_ ); };
coerce ExbiBytes, from Int, via { units( { byte => exbi }, $_ ); };

coerce Bytes, from KibiBytes, via { units( { byte => 1 }, $_ * kibi ) };
coerce Bytes, from MebiBytes, via { units( { byte => 1 }, $_ * mebi ) };
coerce Bytes, from GibiBytes, via { units( { byte => 1 }, $_ * gibi ) };
coerce Bytes, from TebiBytes, via { units( { byte => 1 }, $_ * tebi ) };
coerce Bytes, from PebiBytes, via { units( { byte => 1 }, $_ * pebi ) };
coerce Bytes, from ExbiBytes, via { units( { byte => 1 }, $_ * exbi ) };

coerce KibiBytes, from Bytes, via { units( { byte => kibi }, $_ / kibi ) };
coerce MebiBytes, from Bytes, via { units( { byte => mebi }, $_ / mebi ) };
coerce GibiBytes, from Bytes, via { units( { byte => gibi }, $_ / gibi ) };
coerce TebiBytes, from Bytes, via { units( { byte => tebi }, $_ / tebi ) };
coerce PebiBytes, from Bytes, via { units( { byte => pebi }, $_ / pebi ) };
coerce ExbiBytes, from Bytes, via { units( { byte => exbi }, $_ / exbi ) };

coerce KibiBytes, from Any, via { to_KibiBytes( to_Bytes($_) ) };
coerce MebiBytes, from Any, via { to_MebiBytes( to_Bytes($_) ) };
coerce GibiBytes, from Any, via { to_GibiBytes( to_Bytes($_) ) };
coerce TebiBytes, from Any, via { to_TebiBytes( to_Bytes($_) ) };
coerce PebiBytes, from Any, via { to_PebiBytes( to_Bytes($_) ) };
coerce ExbiBytes, from Any, via { to_ExbiBytes( to_Bytes($_) ) };
