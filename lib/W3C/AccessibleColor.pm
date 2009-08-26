package W3C::AccessibleColor;
use strict;
use warnings;
use List::Util qw/max min/;
use Exporter::Lite;
our @EXPORT = qw/is_valid_color_pair/;

sub is_valid_color_pair {
    my ($color1, $color2) = @_;
    return brightness_ratio($color1, $color2) >= 125
        && luminance_ratio($color1, $color2)  >= 3
        && color_difference($color1, $color2) >= 500;
}

sub gamma_control {
    my ($color, $gamma) = @_;
    my $srgb_color = $color / 255;
    return $srgb_color <= 0.03928 ? $srgb_color /12.92 : (($srgb_color+ 0.055) /1.055) ** $gamma;
}

sub brightness {
    my $color = shift;
    my ($r, $g, $b) = @$color;
    return ($r * 299 + $g * 587 + $b * 114) / 1000;
}

sub brightness_ratio {
    my ($color1, $color2) = @_;
    return abs( brightness($color1) - brightness($color2) );
}

sub luminance {
    my $color = shift;
    my ($r, $g, $b) = @$color;
    my $gamma = 2.4;
    my ($gr, $gg, $gb) = map { gamma_control($_, $gamma) } ($r, $g, $b);
    return ($gr * 0.2126 + $gg * 0.7152 + $gb * 0.722);
}

sub luminance_ratio {
    my ($color1, $color2) = @_;
    my $luminance1 = luminance($color1);
    my $luminance2 = luminance($color2);
    return (max ($luminance1, $luminance2) + 0.05)  / (min ($luminance1, $luminance2) + 0.05);
}

sub color_difference {
    my ($color1, $color2) = @_;
    my ($r1, $g1, $b1) = @$color1;
    my ($r2, $g2, $b2) = @$color2;
    return max( ($r1, $r2) ) - min( ($r1, $r2) )
         + max( ($g1, $g2) ) - min( ($g1, $g2) )
         + max( ($b1, $b2) ) - min( ($b1, $b2) );
}

1;
