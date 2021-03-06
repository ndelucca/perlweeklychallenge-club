#!/usr/bin/env raku

use v6;

#| Given a number between 1 and 5 return all the strings made of vowels following this rule :
#|   ‘a’ can only be followed by ‘e’ and ‘i’.
#|   ‘e’ can only be followed by ‘i’.
#|   ‘i’ can only be followed by ‘a’, ‘e’, ‘o’, and ‘u’.
#|   ‘o’ can only be followed by ‘a’ and ‘u’.
#|   ‘u’ can only be followed by ‘o’ and ‘e’.
sub MAIN (
    UInt $count is copy where 1 <= * <= 5;
) {
    my @strings = ('');
    while $count > 0 {
        $count--;
        my @next = ();
        for @strings -> $string {
            @next.push( |valid-next( $string ) );
        }
        @strings = @next;
    }
    .say for @strings;
}

multi sub valid-next( '' ) {
    <a e i o u>; 
}

multi sub valid-next( Str $x where * ~~ /'a'$/ ) {
    ("{$x}e", "{$x}i");
}

multi sub valid-next( Str $x where * ~~ /'e'$/ ) {
    ("{$x}i");
}

multi sub valid-next( Str $x where * ~~ /'i'$/ ) {
    ("{$x}a", "{$x}e", "{$x}o", "{$x}u");
}

multi sub valid-next( Str $x where * ~~ /'o'$/ ) {
    ("{$x}a", "{$x}u");
}

multi sub valid-next( Str $x where * ~~ /'u'$/ ) {
    ("{$x}o", "{$x}e");
}
