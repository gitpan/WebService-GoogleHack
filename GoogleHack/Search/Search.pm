#!/usr/local/bin/perl 

=head1 Name

GoogleHack::Search - this is a very simple interface to the Google API.
It makes it easier for querying Google.


=head1 SYNOPSIS

 use GoogleHack::Search;
 my $search = GoogleHack::Search->new();
 $search->searchPhrase($searchString);

If required you can set search parameters with following functions:

$search->setMaxResults($param)
$search->setlr($param)
$search->setoe($param)
$search->setie($param)
$search->setStartPos($param)
$search->setFilter("bool")
$search->setSafeSearch("bool")
$search->setRestrict("bool")

=head1 DESCRIPTION

This module provides a simple interface to the Google API. It is used by the GoogleHack driver module.

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

package WebService::GoogleHack::Search;

our $VERSION = '0.02';
use SOAP::Lite;




=head1 PACKAGE METHODS

=cut



=head2 __PACKAGE__->new(\%args)

Purpose: This function creates an object of type Search and returns a blessed 
reference.

=cut


sub new
{
my $this = {};

$this-> {'Key'} = undef;
$this-> {'File_Location'} = undef;
$this-> {'maxResults'} =10;
$this-> {'StartPos'} =0;
$this-> {'Filter'} =false;
$this-> {'Restrict'} ="";
$this-> {'safeSearch'} ="false";
$this-> {'lr'} ="";
$this-> {'oe'} ="";
$this-> {'ie'} ="";
$this-> {'NumResults'} = undef;
$this-> {'snippet'} = undef;
$this-> {'searchTime'} = undef;
$this-> {'url'} = undef;
$this-> {'cachedPage'} = undef;
$this-> {'title'} = undef;


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

=item *

B< adverbs_list >

I<string>. The location of the adverbs list file


=item *

B< verbs_list >

I<string>. The location of the verbs list file

=item *

B< adjectives_list >

I<string>. The location of the adjectives list file


=item *

B< nouns_list >

I<string>. The location of the nouns list file

=item *

B< stop_list >

I<string>. The location of the stop_words list file

=back

=cut

sub init
{
my $this = shift;

$this->{'Key'} = shift;
$this->{'File_Location'} = shift;
$this-> {'maxResults'} =shift;
$this-> {'StartPos'} =shift;
$this-> {'Filter'} =shift;
$this-> {'Restrict'} =shift;
$this-> {'safeSearch'} =shift;
$this-> {'lr'} =shift;
$this-> {'oe'} =shift;
$this-> {'ie'} =shift;

}

# this functions sets the maximum number of results retrived

=head2 __PACKAGE__->setMaxResults(\%args)

Purpose: This this function can used to set the maximum number of results retrieved.

Valid arguments are :

=over 4

=item *

B<maxResults>

I<number>. Number of results you want to be able to retrieve .

=back

=cut


sub setMaxResults
{
    my $this = shift;
    $maxResults = shift;

    $this-> {'maxResults'} =$maxResults;


}


=head2 __PACKAGE__->setlr(\%args)

Purpose: This this function can used to set the language restriction

Valid arguments are :

=over 4

=item *

B<lr>

I<string>. Language Restricion eg lang_eng

=back

=cut

sub setlr
{
    my $this = shift;
    $lr = shift;

    $this-> {'lr'} =$lr;


}


=head2 __PACKAGE__->setoe(\%args)

Purpose: This this function can used to set oe

Valid arguments are :

=over 4

=item *

B<oe>

I<string>.

=back

=cut

sub setoe
{
    my $this = shift;
    $oe = shift;

    $this-> {'oe'} =$oe;


}

=head2 __PACKAGE__->setie(\%args)

Purpose: This this function can used to set ie

Valid arguments are :

=over 4

=item *

B<ie>

I<string>.

=back

=cut

sub setie
{
    my $this = shift;
    $ie = shift;

    $this-> {'ie'} =$ie;


}


=head2 __PACKAGE__->setStartPos(\%args)

Purpose: This function sets the startposition for the search results

Valid arguments are :

=over 4

=item *

B<StartPos>

I<string>.

=back

=cut

sub setStartPos
{
    my $this = shift;
    $StartPos = shift;

    $this-> {'StartPos'} =$StartPos;


}



=head2 __PACKAGE__->setFilter(\%args)

Purpose: This functions sets the search filter as on or off

Valid arguments are :

=over 4

=item *

B<Filter>

I<boolean>. True or False

=back

=cut

sub setFilter
{
    my $this = shift;
    $Filter = shift;

    $this-> {'Filter'} =$Filter;


}


=head2 __PACKAGE__->setRestrict(\%args)

Purpose: this funciton restricts the search to a specific domains

Valid arguments are :

=over 4

=item *

B<Restrict>

I<String>. UncleSam for the US Government

=back

=cut

sub setRestrict
{
    my $this = shift;
    $Restrict = shift;

    $this-> {'Restrict'} =$Restrict;


}


=head2 __PACKAGE__->setSafeSearch(\%args)

Purpose: This functions enables safe search, Restricts search to non-abusive material.

Valid arguments are :

=over 4

=item *

B<Restrict>

I<Boolean>. "True" or "False".


=back

=cut

sub setSafeSearch
{
    my $this = shift;
    $Restrict = shift;

    $this-> {'Restrict'} =$Restrict;


}


=head2 __PACKAGE__->Search(\%args)

Purpose: This function is used to query googles 

Valid arguments are :

=over 4

=item *

B<$searchString> 

I<string>.  Need to pass the search string, which can be a single word or phrase, maximum ten words

=item *

B<num_results> 

I<integer>. The number of results you wast to retrieve, default is 10. Maximum is 1000.


=back

Returns: Returns a Search object containing the search results.

=cut

sub searchPhrase
{
    my $searchInfo=shift;
    my $searchString=shift;
    my $num_results=shift;

    $num_results=10;

    $key  = $searchInfo->{'Key'}; 
    $wsdl_path =$searchInfo->{'File_Location'}; 
    
#    print "\n Key is $key";
#    print "\n path is $wsdl_path";
#    print "\n Search phrase is $searchString\n";
#    print  $searchInfo-> {'StartPos'};

# Initialise with local SOAP::Lite file
    

open(WSDL,"$wsdl_path") || die("\n\n\n\nIllegal WSDL File Location\n\n\n\n");
close(WSDL);

$service = SOAP::Lite
    -> service("file:$wsdl_path");

  #  print "\n This is what i am trying to print \n";
  #  print $searchInfo-> {'maxResults'};
  #  print $searchInfo-> {'StartPos'};
  #  print "\n Looks like i printed it \n\n";
  #if($num_results > 10)
  #{

$count=0;

while( $count < $num_results)

{
$result =  $service -> doGoogleSearch(
		      $key,                               # key
		      $searchString,                      # search query
		      $searchInfo-> {'StartPos'} + $count,# start results
		      $searchInfo-> {'maxResults'},       # max results
		      $searchInfo-> {'Filter'},           # filter: boolean
		      $searchInfo-> {'Restrict'},         # restrict (string)
		      $searchInfo-> {'safeSearch'},       # safeSearch: boolean
		      $searchInfo-> {'lr'},               # lr
		      $searchInfo-> {'oe'},               # ie
		      $searchInfo-> {'ie'}                # oe
		      );

#print "\n Printing here ";
#print $result->{estimatedTotalResultsCount};


$count=$count+10;

}

$this->{'NumResults'} = $result->{estimatedTotalResultsCount};

    @snippet_array=();
    @url_array=();
    @title_array=();

    $count=0;
    foreach $temp (@{$result->{resultElements}}) {
	$snippet_array[$count++]=$temp->{snippet};
    }


  $count=0;
    foreach $temp (@{$result->{resultElements}}) {
	$url_array[$count++]=$temp->{URL};
    }

 $count=0;
    foreach $temp (@{$result->{resultElements}}) {
	$title_array[$count++]=$temp->{title};
    }

    $this->{'snippet'} = \@snippet_array;
    $this->{'searchTime'} = $result->{searchTime};
    $this->{'url'}=\@url_array;
    $this->{'title'}=\@title_array; 

    return $this;

    
}



=head2 __PACKAGE__->getEstimateNo(\%args)

Purpose: This function returns the number of results predicted by google for a specific search term.


No Valid arguments.

=over 4

=back

Returns: Returns the total number of results for a search string..

=cut

sub getEstimateNo
{
    my $this = shift;

return   $this-> {'NumResults'};

}


=head2 __PACKAGE__->IamFeelingLucky(\%args)

Purpose: This function imitates the "I am Feeling Lucky" search feature of Google. It basically returns the URL of the first result of your search.

No Valid arguments.

=over 4

=back

Returns: Returns the URL of the first result of your search.

=cut

sub IamFeelingLucky
{
   my $this = shift;
   return   $this->{'url'}->[0];
   
}


=head2 __PACKAGE__->getCachedPage(\%args)

Purpose: This function retrieves a cached webpage, given the URL.

No Valid arguments.

=over 4

=back

Returns: Returns the contents of as web page given a URL.

=cut

sub getCachedPage
{
    my $searchInfo=shift;
    $url=shift;
    
    $key  = $searchInfo->{'Key'}; 
    $wsdl_path =$searchInfo->{'File_Location'}; 
    
    
    $service = SOAP::Lite
	-> service("file:$wsdl_path");
    
    $cached = $service->doGetCachedPage($key,$url);
    
    #  print "\n\nDid you mean: $correction \n";
    if($cached)
    {
	require WebService::GoogleHack::Text;
	$cached=WebService::GoogleHack::Text::removeHTML($cached);
    }

    if($cached)
    {  
	$this-> {'cachedPage'} = $cached;
	return $cached;
    }
    
    
}
# remember to end the module with this
1;












