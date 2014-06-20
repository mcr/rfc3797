#!/usr/bin/perl

use strict;
use Digest::MD5 qw(md5 md5_hex);

# Actual NOMCOM seed values have ~127.591963 bits of entropy
# 1. Canadian Lotto, 16 July results
#    http://diffusion.loto-quebec.com/sw3/res/asp/index.asp?l=1&pRequest=2&cProduit=4
# 2. Debt Held by the Public (last 8 digits)
#    http://www.treasurydirect.gov/NP/BPDLogin?application=np 
# 3. Intragovernmental Holdings (last 8 digits)
#    http://www.treasurydirect.gov/NP/BPDLogin?application=np 
# 4. Euromillions lottery, 15 July results
#    http://www.europeanlotteryguild.com/lottery_results/euromillions_results/draw_history
# my $seed = "XX.XX.XX.XX.XX.XX.XX./XXXXXXXX./XXXXXXXX./XX.XX.XX.XX.XX.X.X./";

# DEFAULT PARAMETERS
### RFC 3797
#my $N = 25;
#my $SEED = "9319./2.5.8.10.12./9.18.26.34.41.45./";
# NOMCOM 2010-2011
my $N = 101;
my $SEED = "1.8.9.14.17.20.23./76998828./79622755./6.20.21.23.38.42./";
if ($#ARGV >= 1) {
    $N = $ARGV[0];
    $SEED = $ARGV[1];
} else {
    print "Usage: mknomcom <size of pool> <seed>\n\n";
    print "**************************************************\n";
    print "                  SELF TEST MODE                  \n";
    print "**************************************************\n";
}

# Subroutine for mod on 128-bit values
sub hmod($$) { 
    my ($x, $div) = @_;
    my @bytes = unpack("C[16]", $x);
    my $kruft = 0;
    for (my $i=0; $i<16; ++$i) {
        $kruft = ($kruft << 8) + @bytes[$i];
        $kruft %= $div;
    }
    return $kruft;
}

my @pool = (1 .. $N);
my $template = "nA[". length($SEED) ."]n";
my $i=0;
print "index        hex value of MD5        div  selected\n";
for (my $div=$N; $div>0; --$div) {
    # Make the selection
    my $hin = pack($template, $i, $SEED, $i);
    my $selix = hmod( md5($hin), $div );
    my $xout = md5_hex($hin);

    # Get the selectee from the pool, then kick him out
    my $sel = $pool[$selix];
    splice(@pool, $selix, 1);

    printf "%2d  %s  %02d  -> %2d <-\n", $i+1, $xout, $div, $sel;
    ++$i;
}


