#!/usr/local/bin/perl
=head1 InitExample

=head1 SYNOPSIS

InitExamples - This program provides examples of the initialization functions.

=head1 DESCRIPTION

This program is intended to show the user how they can call the functions 
to initialize the Google-Hack key, WSDL file path, and the word lists. 
Two methods of initialization is shown.

1) Initialization through assigning values to the variables inside the
package it self.

2) Initialization through a configuration file.

Initialization through a configuration file is the most efficient method,
since, you would not need to type the Google-API key more than once.

Note* 
Make sure to use only one method of initialization. This is a use method 1) or 2) sort of condition.

It is preferred to use the Initialization  method number 2.

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


###############################################################

#Make sure to give path to the perl library if it is a local installation

use lib "";


###############################################################


#include GoogleHack, so that it can be used

use GoogleHack;



=head1 INITIALIZATION FUNCTIONS

=cut



=head2 INIT METHOD 1 - init(\%args)

Set your GoogleAPI Key

$key="";

Give the Entire location of your WSDL file

eg "/dirname/dirname/GoogleSearch.wsdl"

$wsdl="";

Create an Object of type WebService::GoogleHack

$google = new WebService::GoogleHack;
 
Initialize WebService::GoogleHack object to the key and WSDL config file path.

$google->init( "$key","$wsdl");

=cut


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

$google = new WebService::GoogleHack;

# initialize GoogleHack to the key and WSDL config file path.
$google->init( "$key","$wsdl");






#######################################################################
#
# Another method of initialization would be 
# Initialize google to the contents of the configuration file
# When using this method of initialization you do not need to
# initialize the $key, and $wsdl variables.
#######################################################################


=head2 INIT METHOD 2 - initConfig(\%args)

Create an Object of type WebService::GoogleHack

$google = new WebService::GoogleHack;

Give the path to the configuration file to the config functions.

$google->initConfig("../config.txt");

=cut

$google->initConfig("../config.txt");

#Print the config file information that has been parsed

$google->printConfig();


















