# W3C::AccessibleColor
Determine a color pair is WCAG 2.0 valid.

# Usage
```perl
use W3C::AccessibleColor;
use Perl6::Say;

my $color1 = [123, 123, 244]; # rgb
my $color2 = [12, 22, 100];

say 'valid pair' if is_valid_color_pair($color1, $color2);

my ($color3, $color4) = random_color_pair(); # get color pair
# useful for CAPTCHA
```
