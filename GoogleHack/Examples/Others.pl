#!/usr/local/bin/perl
=head1 Search

=head1 SYNOPSIS

GoogleHack - Is a Perl package that interacts with the Google API, and has some basic functionalities that allow the 
user to issues queries to Google and manipulate the results. The Search.pl program shows the user how to
use Google-Hack to issue search requests to Google.

=head1 DESCRIPTION

The examples in this module are meant to serve as a means of introducing to the user how to use GoogleHack some of the special features of GoogleHack.


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



=head1  SPECIAL FEATURES EXAMPLE

=cut

=head2 FUNCTIONS

Create an Object of type WebService::GoogleHack

$google = new WebService::GoogleHack;
 
Initialize WebService::GoogleHack object to the key and WSDL config file path etc using the config file.

$google->initConfig("PATH TO CONFIG FILE");


Given a search word, this function tries to retreive the text surrounding the search word in the retrieved snippets.

$google->getSearchSnippetWords("knife", 5,"test.txt");

By passing the search string and the tracefile
Given a search word, this function tries to retreive the
sentences in the cached web page.

$google->getCachedSurroundingWords("duluth", "test2.txt");

Given a search word, this function tries to retreive the sentences in the snippet


$google->getSnippetSentences("knife", "test.txt");


Given two search words, this function tries to retreive the common text surrounding the google words in the retrieved snippets.

$google->getSearchCommonWords("knife", "scissors");


=cut

###############################################################

#Make sure to give path to the perl library if it is a local installation
# make sure to change it to you path
# however, if you have super user access, then once you install it in
# the perl directories, you dont have to do this
# aomwthing likw /home/lib/perl5/site_perl/5.8.0

use lib "";

###############################################################

#include GoogleHack, so that it can be used

use WebService::GoogleHack;

create an instance of WebService::GoogleHack called "Search".

$google = new WebService::GoogleHack;

#######################################################################
# Make sure to pass the ENTIRE path to the configuration file
# Config file should be in WebService/GoogleHack/Datafiles/
#######################################################################

$google->initConfig("PATH TO CONFIG FILE");



#print the config file information that has been parsed

$google->printConfig();

#predict the semantic orientation of the given review file, and use the word 
#"excellent" to denote a positive semantic orientation and the word "bad" to 
#denote a negative semanctic orientation.
#write the output to the exp,txt file.

#######################################################################
#
# Given a search word, this function tries to retreive the
# text surrounding the search word in the retrieved snippets.
#######################################################################

#$google->getSearchSnippetWords("knife", 5,"test.txt");

# by passing the search string and the tracefile
# Given a google word, this function tries to retreive the
# sentences in the cached web page.
$google->getCachedSurroundingWords("duluth", "test2.txt");

# Given a search word, this function tries to retreive the
# sentences in the snippet


#$google->getSnippetSentences("knife", "test.txt");


# given two search words, this function tries to retreive the
# common text surrounding the search words in the retrieved snippets.

$google->getSearchCommonWords("knife", "scissors");


#$search->getSearchCommonWords("toyota", "ford",10,"result.txt");
#$search->getPairWordClusters("toyota", "ford",10,1,"result1.txt");
#$search->getText("duluth","/home/vold/47/rave0029/Data/");










