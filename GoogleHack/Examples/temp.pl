#!/usr/local/bin/perl


# this is the path to my GoogleHack module



use lib "/home/vold/47/rave0029/lib/perl5/site_perl/5.8.0";

#include GoogleHack, so that it can be used

use GoogleHack;

#make sure to fill in the key and path tot he wsdl file

$key="ImbjULt0W3FuwYXOEM+AhN3/TWIRIwkg";
$wsdl="/home/vold/47/rave0029/ggapi/googleapi/GoogleSearch.wsdl";

#create an instance of GoogleHack called "Search".

$search = new GoogleHack;

# initialize GoogleHack to the key and WSDL config file path.

$search->init( "$key","$wsdl");

# Retrieve a spelling suggestion for the search Stribng "dulut"
 
$correction=$search->phraseSpelling("dulut");


print "\n\n The suggested spelling for dulut is : $correction\n\n";


$correction=$search->phraseSpelling("briney");


print "\n\n The suggested spelling for briney is : $correction\n\n";

