#!/usr/local/bin/perl

=head1 NAME

Search Examples - Examples of GoogleHack search functions.

=head1 SYNOPSIS

#Set your GoogleAPI Key

$key="";

#Give the Entire location of your WSDL file
#eg "/dirname/dirname/GoogleSearch.wsdl"

$wsdl="";

#Create an Object of type WebService::GoogleHack

$google = new WebService::GoogleHack;

#Initialize WebService::GoogleHack object to the key and WSDL config file path.

$google->init( "$key","$wsdl");

#Now call search function like this

#Here I am searching for duluth.

$results=$google->Search("duluth");

#The results variable will now contain the results of your query.

#Printing the searchtime

print $google->{'searchTime'};

#Printing the snippet element 0

print $google->{'snippet'}->[0];

=head1 DESCRIPTION

The examples in this module are meant to serve as a means of introducing to the user how to
use Google-Hack to use the search method, and retrieve the results.

=head1 AUTHOR

Pratheepan Raveendranathan, E<lt>rave0029@d.umn.eduE<gt>

Ted Pedersen, E<lt>tpederse@d.umn.eduE<gt>

=head1 BUGS

=head1 SEE ALSO

L<GoogleHack home page|http://google-hack.sourceforge.net>
L<Pratheepan Raveendranathan|http://www.d.umn.edu/~rave0029/research>
L<Ted Pedersen|www.d.umn.edu./~tpederse>

Google-Hack Maling List E<lt>google-hack-users@lists.sourceforge.netE<gt>


=head1 COPYRIGHT AND LICENSE

Copyright (c) 2003 by Pratheepan Raveendranathan, Ted Pedersen

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program; if not, write to

The Free Software Foundation, Inc.,
59 Temple Place - Suite 330,
Boston, MA  02111-1307, USA.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

print $google->{'url'}->[0];


###############################################################

#Make sure to give path to the perl library if it is a local installation
# make sure to change it to you path
# however, if you have super user access, then once you install it in
# the perl directories, you dont have to do this

use lib "";

###############################################################

#include GoogleHack, so that it can be used

use GoogleHack;




#######################################################################
# Your Google=hack key should go here
# This is only if you intend to use the function init("$key","$wsdl")
# Not when to using the initConfig file
#######################################################################
$key="";



#######################################################################
# The path to the WSDL file should go here
# eg: /home/dirname/GoogleSearch.wsdl
#######################################################################

$wsdl="";


#create an instance of GoogleHack called "Search".

$search = new GoogleHack;

# initialize GoogleHack to the key and WSDL config file path.
# instead you could have also used the function initiConfig to
# initialize the search variables through a config file.

$google->init( "$key","$wsdl");

# Results will now contain the search results for the string "duluth".
$results=$google->Search("duluth");

# printing the searchtime
print $google->{'searchTime'};

#printing the snippet element 0
print $google->{'snippet'}->[0];

#printing URL of the first result of the search for duluth.

print $google->{'url'}->[0];

