use Test::More 'no_plan';

use_ok("URI::Find::Schemeless::Stricter");
ok(URI::Find::Schemeless::Stricter->isa("URI::Find"), "It's a URI::Find");

my @uris;
my $self = URI::Find::Schemeless::Stricter->new( 
            sub { push @uris, $_[0]->as_string; return $_[1]}
           );
%tests = (
    "www.foo.com" => ["http://www.foo.com/"],
    "blah.foo.com" => [],
    "10.1.2.1/" => ["http://10.1.2.1/"],
    "10.1.2.1" => [],
);

for my $t (keys %tests) {
    $self->find(\$t);
    is_deeply(\@uris, $tests{$t}, $t);
    @uris = ();
}
