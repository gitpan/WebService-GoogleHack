#!/usr/local/bin/perl
=head1 Rate

=head1 SYNOPSIS

This is a perl program that gives the example use of the 
Google-Hack Rate functions which manipulate the text 
retrieved from the web to .

=head1 DESCRIPTION

This program gives an example of calling the relatedness
functions (NLP related functions).

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


=head1  SEARCH FUNCTION EXAMPLE

=cut

=head2 SEARCH FUNCTION - search(\%args)

Create an Object of type WebService::GoogleHack

$google = new WebService::GoogleHack;

Initialize WebService::GoogleHack object using the config file.
 
$google->initConfig("PATH TO CONFIG FILE");



Now call measureSemanticRelatedness function like this to find the relatedness measure between the words "knife" and "cut":

$Relatedness = $google-> measureSemanticRelatedness("knife", "cut");

The variable $Relatedness will now contain the results of your query.
 


$google->predictSemanticOrientation("PATH TO REVIEW FILE","excellent","bad","
PATH TO TRACE FILE");

=cut



###############################################################

#Make sure to give path to the perl library if it is a local installation
# make sure to change it to you path
# however, if you have super user access, then once you install it in
# the perl directories, you dont have to do this

###############################################################

use lib "";

use WebService::GoogleHack;


#######################################################################
# Preferred initialization method
#
#######################################################################
# Initialize search to the contents of the configuration file
#######################################################################

#######################################################################
# Make sure to pass the ENTIRE path to the configuration file
# Config file should be in WebService/GoogleHack/Datafiles/
#######################################################################

$google->initConfig("PATH TO CONFIG FILE");

#printing the config file information that has been parsed

$google->printConfig();



# Given two words, this function will try to predict the relatedness between
# the two words. This relatedness is a measure of calculated using the PMI
# formula.

$Relatedness = $google-> measureSemanticRelatedness("knife", "cut");



#predict the semantic orientation of the given review file, and use the word 
#"excellent" to denote a positive semantic orientation and the word "bad" to 
#denote a negative semanctic orientation.

#write the output to the exp,txt file.


#######################################################################
# Make sure to pass the ENTIRE path to the review file & tracefile
# An example REVIEW FILE is given in the Webservice/GoogleHack/Datafiles 
#######################################################################

$google->predictSemanticOrientation("PATH TO REVIEW FILE","excellent","bad","PATH TO TRACE FILE");





