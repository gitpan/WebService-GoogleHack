#!/usr/local/bin/perl 

=head1 Name

WebService::GoogleHack
::Spelling - This package does the simple function of retrieving a spelling suggestion given a search string.



=head1 SYNOPSIS
    
use WebService::GoogleHack::Spelling;
my $search = WebService::GoogleHack
::Spelling->new(); #create an object of type spelling

$search->init("key","wsdl file"); #make sure to initialize the correct wsdl file
$results = $search->spellingSuggestion($searchString);

$result will be a string containing the suggestion (If there is a suggestion given by Google, otherwise it would be a null variable).
    
    The suggested "correction" string can also be accessed by
    
    $search->{'correction'};



=head1 DESCRIPTION

This module interacts with Google to retrieve a spelling suggestion given a string. It is used by the WebService::GoogleHack
 driver module.


=head1 AUTHOR

Pratheepan Raveendranathan, E<lt>rave0029@d.umn.eduE<gt>

Ted Pedersen, E<lt>tpederse@d.umn.eduE<gt>

=head1 BUGS

=head1 SEE ALSO

L<WebService::GoogleHack
 home page|http://google-hack.sourceforge.net>  
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


package WebService::GoogleHack::Spelling;

our $VERSION = '0.03';

use SOAP::Lite;



=head1 PACKAGE METHODS

=cut


=head2 __PACKAGE__->new(\%args)

Purpose: This function creates an object of type Spelling and returns a 
blessed reference.

=cut


sub new
{
my $this = {};  

$this-> {'Key'} = undef;
$this-> {'File_Location'} = undef;
$this-> {'correction'} = undef;

bless $this;

return $this;
}



=head2 __PACKAGE__->init(\%args)

Purpose: This this function can used to inititalize the member variables.

Valid arguments are :

=over 4

=item *

B<key>

I<string>. key to the google-api

=item *

B< File_location>

I<string>.  This the wsdl file name

=back

=cut

sub init
{
my $this = shift;

$this->{'Key'} = shift;
$this->{'File_Location'} = shift;

}


=head2 __PACKAGE__->spellingSuggestion(\%args)

Purpose: This is function is used to retrieve a spelling suggestion from Google


Valid arguments are :

=over 4

=item *

B<$searchString> 

I<string>.  Need to pass the search string, which can be a single word 



=back

Returns: Returns suggested spelling if there is one, otherwise returns "No Spelling Suggested":


=cut
sub spellingSuggestion
{
    my $searchInfo=shift;
    $searchString=shift;
    
    $key  = $searchInfo->{'Key'}; 
    $wsdl_path =$searchInfo->{'File_Location'}; 
    
# Initialize with local SOAP::Lite file
    
    $service = SOAP::Lite
	-> service("file:$wsdl_path");
    
    $correction = $service->doSpellingSuggestion($key,$searchString);

if($correction eq "")
{
    $correction="No Spelling Suggested";

}
    
  #  print "\n\nDid you mean: $correction \n";
    $this-> {'correction'} = $correction;
    
    return $correction;


}

 # remember to end the module with this
1;





