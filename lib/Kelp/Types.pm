package Kelp::Types;
use Data::Dimensions qw(&units);

use MooseX::Types -declare => [
    qw(
        Meters
        Centimeters

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

use constant yotta => 10**24;      # 1E24 Greek or Latin octo, "eight"
use constant zetta => 10**21;      # 1E21 Latin septem, "seven"
use constant exa   => 10**18;      # 1E18 Greek hex, "six"
use constant peta  => 10**15;      # 1E15 Greek pente, "five"
use constant tera  => 10**12;      # 1E12 Greek teras, "monster"
use constant giga  => 10**9;       # 1E9  Greek gigas, "giant"
use constant mega  => 10**6;       # 1E6  Greek megas, "large"
use constant myria => 10**4;       # 1E4  Not an official SI prefix
use constant kilo  => 1000;        # 1E3  Greek chilioi, "thousand"
use constant hecto => 100;         # 1E2  Greek hekaton, "hundred"
use constant deca  => 10;          # 1E1  Greek deka, "ten"
use constant deka  => 10;
use constant deci  => 1 / 10;      # 1E-1 Latin decimus, "tenth"
use constant centi => 1 / 100;     # 1E-2 Latin centum, "hundred"
use constant milli => 1 / 1000;    # 1E-3 Latin mille, "thousand"
use constant micro => 10**-6;      # 1E-6 Latin micro/Greek mikros,"small"
use constant nano  => 10**-9;      # 1E-9 Latin nanus or Greek nanos,"dwarf"
use constant pico  => 10**-12;     # 1E-12 Spanish pico, "a bit"
use constant femto => 10**-15;     # 1E-15 Danish-Norwegian femten,"fifteen"
use constant atto  => 10**-18;     # 1E-18 Danish-Norwegian atten,"eighteen"
use constant zepto => 10**-21;     # 1E-21 Latin septem, "seven"
use constant yocto => 10**-24;     # 1E-24 Greek or Latin octo, "eight"

subtype Meters, as 'Data::Dimension', where { $_->{units}{meter} == 1 };
subtype Centimeters, as 'Data::Dimension',
    where { $_->{units}{meter} == centi };

subtype Inches, as 'Data::Dimension', where { to_Centimeter($_) == $_ * 2.4 };
coerce Inches, from Feet, via { to_Inches( $_ * 12 ) };

subtype Feet, as 'Data::Dimensions', where { to_Inch($_) * 12 == $_ };

# Volume
subtype Gallons, as 'Data::Dimension', where { $_->{units}{gallon} == 1 };
coerce Gallons, from Inches, via { to_Gallon( $_ * 231 ) };
coerce Gallons, from Feet,   via { to_Gallon( to_Inches($_) ) };

# INFORMAION SCIENCE

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
