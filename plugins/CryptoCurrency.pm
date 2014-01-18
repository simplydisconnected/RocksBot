package plugins::CryptoCurrency;
#---------------------------------------------------------------------------
#    Copyright (C) 2014  egretsareherons@gmail.com
#    https://github.com/egretsareherons/RocksBot
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#-----------------------------------------------------------------------------
use base qw (modules::PluginBaseClass);
use modules::PluginBaseClass;
use strict;
use warnings;

use Data::Dumper;

my $types;

sub plugin_init{
    my $self = shift;

    $self->{types} = ['dogecoin', 'bitcoin', 'litecoin', 'ppcoin', 'namecoin', 
                'quarkcoin', 'feathercoin', 'novacoin', 'terracoin', 'freicoin'];
    return $self;
}


sub getOutput {
    my $self = shift;
    my $command = $self->{'command'};
    my $options = $self->{options};
    my $output = "";


    if ($command eq 'doge24'){
        my $URL = "http://doge4.us/";
        my $page = $self->getPage($URL);
        $page=~m#(Dogecoin is .+?in the last 24 hours)#gs;
        my $gain = $1;
        $gain=~s/<.+?>//gis;

        $page=~m#(1 Dogecoin =.+?US Dollars)#gs;
        my $usd= $1;
        $usd=~s/<.+?>//gis;
        return $gain . '. ' . $usd . '.';
    }

    if ($command ~~ @{$self->{types}}){
        my $URL = "http://bitinfocharts.com/$command";
        my $page = $self->getPage($URL);
    
        $page=~m#<h1>(.+?) statistics</h1>#gis;
        my $currency_name = $1;

        $page =~ m#<span\s+itemprop="price">(.+?)</span> \(<small>(.+?)</small>\)</span>#;
        my $price_usd= $1;
        my $price_update_utc = $2;
 
        my $num = $price_usd;
        $num = (split / /, $price_usd)[0];
        my $dollar = sprintf("%.8f", 1 / $num);
        $dollar = sprintf("%.2f", $dollar) if ($dollar > 1);

        return "Latest $currency_name price: $price_usd ($price_update_utc). 1 USD = $dollar $currency_name ".GREEN.UNDERLINE.$self->getShortURL($URL).NORMAL;
    
    }
}

sub listeners{
    my $self = shift;
    my @commands = ('doge24');

    # push each currency from plugin_init as a command
    foreach my $type (@{$self->{types}}){
        push @commands, $type;
    }

    my $default_permissions =[ ];
    return {commands=>\@commands, permissions=>$default_permissions};
}

sub addHelp{
    my $self = shift;
    $self->addHelpItem("[plugin_description]", "Get cryptocurrency price quotes from bitinfocharts.com.");
    foreach my $type (@{$self->{types}}){
        $self->addHelpItem("[$type]", "Get a $type price quote from bitinfocharts.com");
    }
}

1;
__END__
