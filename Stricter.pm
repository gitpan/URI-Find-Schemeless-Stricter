package URI::Find::Schemeless::Stricter;
use 5.00600;
use strict;

our $VERSION = '1.00';
use base 'URI::Find';
use URI::Find ();
my($dnsSet) = 'A-Za-z0-9-';

my($cruftSet) = q{),.'";\]};

# We could put the whole ISO country code thing in here.
my($tldRe)  = '(?i:biz|com|edu|gov|info|int|mil|net|org|[a-z]{2})';
my($hostRe) = '(?i:www|ftp|web)';
my $dottedquad = qr/(?:\d{1,3}\.){3}\d{1,3}/;

my($uricSet) = __PACKAGE__->uric_set;

sub _is_uri {
    my ($class, $r_uri_cand) = @_;
    if ($$r_uri_cand =~ /^$dottedquad$/) { return 0 }
    else { return $class->SUPER::_is_uri($r_uri_cand) };
}

sub schemeless_uri_re {
    return qr{
              (?: ^ | (?<=[\s<]) )
              # hostname
              (?: $hostRe\.[$dnsSet]+(?:\.[$dnsSet]+)*\.$tldRe
                  | $dottedquad ) # not inet_aton() complete
              (?:
                  (?=[\s>?$cruftSet])   # followed by unrelated thing
          (?!\.\w)      #   but don't stop mid foo.xx.bar
                      (?<!\.p[ml])  #   but exclude Foo.pm and Foo.pl
                  |$            # or end of line
                      (?<!\.p[ml])  #   but exclude Foo.pm and Foo.pl
                  |/[$uricSet#]*    # or slash and URI chars
              )
           }x;
}
1;
__END__
=pod

=head1 NAME

URI::Find::Schemeless::Stricter - Find schemeless URIs in arbitrary text.


=head1 SYNOPSIS

  require URI::Find::Schemeless::Stricter;

  my $finder = URI::Find::Schemeless::Stricter->new(\&callback);

  The rest is the same as URI::Find::Schemeless.


=head1 DESCRIPTION

URI::Find finds absolute URIs in plain text with some weak heuristics
for finding schemeless URIs.  This subclass is for finding things
which might be URIs in free text.  It is slightly stricter than
C<URI::Find::Schemeless>, as it finds things like "www.foo.com" but not
"lifes.a.bitch.if.you.aint.got.net"; it finds "1.2.3.4/foo" but not 
"1.2.3.4". This should mean your sectioned lists no longer get marked up
as URLs...

=head1 SUPPORT

Beep... beep... this is a recorded announcement:

I've released this software because I find it useful, and I hope you
might too. But I am a being of finite time and I'd like to spend more of
it writing cool modules like this and less of it answering email, so
please excuse me if the support isn't as great as you'd like.

Nevertheless, there is a general discussion list for users of all my
modules, to be found at
http://lists.netthink.co.uk/listinfo/module-mayhem

If you have a problem with this module, someone there will probably have
it too.

=head1 AUTHOR

Simon Cozens, C<simon@kasei.com>

Copyright, Kasei 2003.

=head1 LICENSE

GPL and Artistic.

=head1 SEE ALSO

L<URI::Find::Schemeless>
