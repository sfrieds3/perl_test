#!/usr/bin/perl

use warnings;
use strict;

use Data::Dumper;
use Data::Printer;

sub href_test {

    my %langs_href = (
        England => 'English',
        France  => 'French',
        Spain   => 'Spanish',
        China   => 'Chinese',
        Germany => 'German'
    );

    $langs_href{'Italy'} = 'Italian';

    my $lang = $langs_href{'England'};
    my $ital_lang = $langs_href{'Italy'};

    print "England lang: $lang\n";
    print "Italy lang: $ital_lang\n";

    print "iterating:\n";
    for ( keys %langs_href ) {
        print("The official language of $_ is $langs_href{$_}\n");
        my $lang = $langs_href{England};
    }

    print("Now we'll do it using foreach:\n");
    foreach my $key ( keys %langs_href ) {
        print("The official language of $key is $langs_href{ $key }\n");
    }

    print("Now we'll do it using map:\n");
    map { print("The official language of $_ is $langs_href{ $_ }\n") }
      keys %langs_href;

    print Dumper \%langs_href;
}


sub array_test {

    my @numbers        = qw ( zero one two three );
    my $numbers_length = @numbers;

    map { print("numbers: $_\n") } @numbers;

    @numbers = qw ( 1 2 3 4 5 6 7 8 9 10 );

    print('our new @numers\n');
    map { print("$_\n") } @numbers;

    print('Now we will calulate the square of the vlaues in @numbers:\n');
    map {
        my $sq_val = $_ * $_;
        print("$_^2 = $sq_val\n")
    } @numbers;

    print( 'number of elements in @numbers: ' . scalar(@numbers) . "\n" );

}

sub multi_key_test {

    my %stateinfo;
    $stateinfo{Florida}{Abbreviation}{Long} = 'Fla';
    $stateinfo{Florida}{Abbreviation}{Short} = 'FL';

    $stateinfo{Maine}{Abbreviation}{Long} = 'Maine';
    $stateinfo{Maine}{Abbreviation}{Short} = 'ME';

    # incorrect multi-key lookup
    # you can see 'Illinois' key was created in the %stateinfo href
    # this is because perl 'helpfully' autovivify's the lower level keys
    if (exists ($stateinfo{Illinois}{StateBird})) {
        print("Illinois State Bird exists?");
    }

    # correct multi-key lookup
    if (exists ($stateinfo{Connecticut})) {
        if (exists ($stateinfo{Connecticut}{StateBird})) {
            print("There is a state bird for CT... that shouldnt be here!");
        }
    }

    print Dumper \%stateinfo;

    # get a list of keys in the %stateinfo href
    my @keys = keys %stateinfo;
    print("list of keys: @keys\n");

    # get a list of all values in the %stateinfo href
    # note these will be href's because there are multiple values below
    my @values = values %stateinfo;
    print("list of values: @values\n");

    # val is a reference to a hash
    foreach my $val ( @values ) {
        # we are going to get the keys for the hash referred to by $val
        foreach my $var (keys %{$val}) {
            # because $val is a *reference* to a hash
            # in order to access the values in that hash
            # we need to use a dereferencing arrow ('->')
            print("long: $val->{$var}{Long}\n");
            print("short: $val->{$var}{Short}\n");
        }
    }

    print "or we can print it this way\n";
    p %stateinfo;

    #my %val_href = values %stateinfo;
    #map { print("list of short values per key: $_{Abbreviation}{Short}\n") } values %val_href;
    #print Dumper \%val_href;

}

# run our test functions
href_test;
array_test;
multi_key_test;
