#!/usr/local/bin/perl


# this is the path to my WebService::GoogleHack module

#make sure to fill in the key and path tot he wsdl file

use lib "/home/vold/47/rave0029/lib/perl5/site_perl/5.8.0";

#include WebService::GoogleHack, so that it can be used

use WebService::GoogleHack;

#create an instance of WebService::GoogleHack called "Search".

$search = new WebService::GoogleHack;

# initialize WebService::GoogleHack to the key and WSDL config file path.

#$search->init( "ImbjULt0W3FuwYXOEM+AhN3/TWIRIwkg","/home/cs/rave0029/ggapi/googleapi/GoogleSearch.wsdl");

# Retrieve a spelling suggestion for the search Stribng "dulut"
 
#$correction=$search->phraseSpelling("dulut");

# Results will now contain the search results for the string "duluth".
#$results=$search->Search("knife");

print " suggested spelling is $correction\n" ;


    #$search->getSearchCommonWords("duluth","minneapolis","sample.txt");

$search->initConfig("initconfig.txt");

#print the config file information that has been parsed

$search->printConfig();


#$search->getWordClusters("reservations","sample.txt");


#$search->getSearchCommonWords("toyota", "ford","/home/vold/47/rave0029/result.txt");




$search->getPairWordClusters("dell", "best buy","/home/vold/47/rave0029/result1.txt");

#$search->getText("duluth","/home/vold/47/rave0029/Data/");

