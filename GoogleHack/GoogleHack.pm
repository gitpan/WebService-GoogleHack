#!/usr/local/bin/perl 

=head1 WebService::GoogleHack Package

=head1 SYNOPSIS

WebService::GoogleHack - Is a Perl package that interacts with the Google API, and has some basic functionalities 
that allow the user to interact with Google and retrieve results. It also has some Natural Language 
Processing capabilities, such as the ability to predict the sematic orienation of words etc.

=head1 DESCRIPTION

This module acts as a driver module. Basically it acts as an interface between the user and the modules. The modules that are controlled by WebService::GoogleHack is:

WebService::GoogleHack::Text, Search, Rate, Spelling

=head1 AUTHOR

Pratheepan Raveendranathan, E<lt>rave0029@d.umn.eduE<gt>

Ted Pedersen, E<lt>tpederse@d.umn.eduE<gt>

=head1 BUGS 

=head1 SEE ALSO

L<WebService::GoogleHack home page|http://google-hack.sourceforge.net>  
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


package WebService::GoogleHack;

our $VERSION = '0.02';

use SOAP::Lite;
use Set::Scalar;
use Text::English;
use LWP::Simple;

=head1 PACKAGE METHODS

=cut



=head2 __PACKAGE__->new(\%args)

Purpose: This function creates an object of type GoogleHack and returns a blessed reference.

=cut

sub new
{
my $this = {};

@snippet=();

#these are the fields/members of the class Google-hack

$this-> {'Key'} = undef;
$this-> {'File_Location'} = undef;
$this->{'correction'} = undef;
$this-> {'NumResults'} = undef;
$this-> {'snippet'} = undef;
$this-> {'searchTime'} = undef;
$this-> {'adverbs_list'} = undef;
$this-> {'verbs_list'} = undef;
$this-> {'adjectives_list'} = undef;
$this-> {'nouns_list'} = undef;
$this-> {'stop_list'} = undef;
$this->{'PMIMeasure'}=undef;
$this->{'prediction'}=undef;
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

#making sure to bless this object 

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

#making sure this is assigned the object reference

my $this = shift;

$this->{'Key'} = shift;
$this->{'File_Location'} = shift;
$this-> {'adverbs_list'} = shift;
$this-> {'verbs_list'} = shift;
$this-> {'adjectives_list'} = shift;
$this-> {'nouns_list'} = shift;
$this-> {'stop_list'} = shift;

}


=head2 __PACKAGE__->setMaxResults(\%args)

Purpose: This function  sets the maximum number of results retrived

Valid arguments are :

=over 4

=item *

B<maxResults>

I<Number>. The maximum number of results we want to be able to retrieve. Should be less than 10.

=back

=cut

sub setMaxResults
{
    my $this = shift;
    $maxResults = shift;

    $this-> {'maxResults'} =$maxResults;


}

#this function sets the language restriction

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

#

sub setSafeSearch
{
    my $this = shift;
    $Restrict = shift;

    $this-> {'Restrict'} =$Restrict;


}



=head2 __PACKAGE__->measureSemanticRelatedness(\%args)

Purpose: this is function is used to measure the relatedness between two words it basically 
calls the measureSemanticRelatedness function which is in  the Rate class


Valid arguments are :

=over 4

=item *

B<searchString1>

I<string>. The search string which can be a phrase or word

=item *

B<searchString2>

I<string>.   The search string which can be a phrase or word

=back

Returns: Returns the object containing the PMI measure. ($search->{'PMI'}).

=cut


sub measureSemanticRelatedness
{
  my $this = shift;
  my $searchString1=shift;
  my $searchString2=shift;


 require WebService::GoogleHack::Rate;

 $results=WebService::GoogleHack::Rate::measureSemanticRelatedness($this, $searchString1, $searchString2);

  print "\nRelatedness is ";

#  print $results->{'PMI'};
#  print "\n\n";

 return $this;

}


=head2 __PACKAGE__->predictSemanticOrientation(\%args)

Purpose: this function tries to predict the semantic orientation of a paragraph of text need


Valid arguments are :

=over 4

=item *

B<config_file> 

I<string>. The location of the review file

=item *

B<positive_inference>. 

I<string>.   Positive inference such as excellent 

=item *

B<negative_inference>.

I<string>.    Negative inference such a poor


=item *

B<trace_file>.

I<string>.   The location of the trace file. If a file_name is given, the results are stored in this file


=back

Returns : the PMI measure and the prediction which is 0 or 1.


=cut

sub predictSemanticOrientation
{
  my $searchInfo=shift;
    $config_file=shift;
    $positive_inference=shift;
    $negative_inference=shift;
    $trace_file=shift;

    require WebService::GoogleHack::Rate;
 
    $results=WebService::GoogleHack::Rate::predictSemanticOrientation($searchInfo, $config_file ,$positive_inference,$negative_inference,$trace_file);

    $this->{'PMIMeasure'}=$results->{'PMIMeasure'};
    $this->{'prediction'}=$results->{'prediction'};

    return $this;

}


=head2 __PACKAGE__->phraseSpelling(\%args)

Purpose: This is function is used to retrieve a spelling suggestion from Google


Valid arguments are :

=over 4

=item *

B<$searchString> 

I<string>.  Need to pass the search string, which can be a single word 



=back

Returns: Returns suggested spelling if there is one, otherwise returns "No Spelling Suggested":


=cut

sub phraseSpelling
{
  my $this = shift;
  my $searchString=shift;
 
 require WebService::GoogleHack::Spelling;
  $this->{'correction'} = WebService::GoogleHack::Spelling::spellingSuggestion($this, $searchString);

 return $this->{'correction'};
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

Returns: Returns a GoogleHack object containing the search results.

=cut


sub Search
{
  my $this = shift;
  my $searchString=shift;
  my $num_results=shift;
 
  require WebService::GoogleHack::Search;
 
  $results=WebService::GoogleHack::Search::searchPhrase($this, $searchString,$num_results);

 # print "\n Printing here ";
 # print $results->{'snippet'}->[0];
 
  $this->{'NumResults'}=$results->{'NumResults'};
  $this-> {'snippet'} = $results->{'snippet'};
  $this-> {'searchTime'} =$results->{'searchTime'};
  
 return $this;

}



=head2 __PACKAGE__->initConfig(\%args)

Purpose:  this function is used to read a configuration file containing informaiton such as the Google-API key, the words list etc.


Valid arguments are :

=over 4

=item *

B<filename> 

I<string>.  Location of the configuration file.

=back

returns : Returns an object which contains the parsed information.

=cut

sub initConfig
{

my $this=shift;
my $filename=shift;

    require WebService::GoogleHack::Text;


#calling the read config function in text

    $results=WebService::GoogleHack::Text::readConfig("$filename");

    $this->{'Key'}=$results->{'Key'};
    $this->{'File_Location'}=$results->{'File_Location'};
    $this-> {'adverbs_list'} = $results->{'adverbs_list'};
    $this-> {'verbs_list'} =$results->{'verbs_list'}  ;
    $this-> {'adjectives_list'} =$results->{'adjectives_list'} ;
    $this-> {'nouns_list'} = $results->{'nouns_list'} ;
    $this-> {'stop_list'} = $results->{'stop_list'} ;

return $this;

}


=head2 __PACKAGE__->printConfig(\%args)

Purpose:  This function is used to print the information read from a configuration file 

No arguments.

=cut

sub printConfig
{

    $this=shift;

    print "\n This is the information retrieved from the configuration file\n";

    print "\n Key:";
    print $this->{'Key'};
    
    print "\n WSDL Location:";
    print  $this->{'File_Location'};
    
    print "\n Adverbs File Location:";
    print $this-> {'adverbs_list'};
    print "\n Verbs File Location:";
    print $this-> {'verbs_list'}  ;
    
    print "\n Adjectives File Location:";
    print $this-> {'adjectives_list'} ;
    
    print "\n Nouns File Location:";
    print $this-> {'nouns_list'}  ;

    print "\n Stop List File Location:";
    print $this-> {'stop_list'} ;
    
    print "\n\n";

}



=head2 __PACKAGE__->getSearchSnippetWords(\%args)

Purpose:  Given a search word, this function tries to retreive the text surrounding the search word in the retrieved snippets. 

Valid arguments are :

=over 4

=item *

B<searchString> 

I<string>.  The search string which can be a word or phrase


=item *

B<proximity> 

I<string>. The number of words surrounding the searchString (Not Implemented yet 


=back

returns : Returns an object which contains the parsed information

=cut

sub getSearchSnippetWords
{

# the google-hack object containing the searchInfo

    my  $searchInfo = shift;
    my  $searchString = shift;
    my $proximity = shift;
    my $trace_file=shift;

    require WebService::GoogleHack::Search;

    $results=WebService::GoogleHack::Search::searchPhrase($searchInfo, $searchString);


    @strings=();
    $count=0;
    require WebService::GoogleHack::Text;

# I am just checking the first 10 snippets since the snippets get more irrelevant as
# the hit number increases

    while( $count < 10)
    {
# removing html tags from the resulting snippet

	$strings[$count]=WebService::GoogleHack::Text::removeHTML($results->{'snippet'}->[$count]);

	$count++;
   }
    
%results_final=WebService::GoogleHack::Text::getSurroundingWords($searchString,5 , @strings);


#if we need to write results to the trace_file

if($trace_file ne "")
{
    $temp="\n Words Surrounding search phrase $searchString in Snippets\n\n";

while( ($Key, $Value) = each(%results_final) ){
  $temp=$temp."Key: $Key, Value: $Value \n";

}

open(DAT,">>$trace_file") || die("Cannot Open $trace_file to write");

print DAT $temp;

close(DAT);


}
    return %results_final;

}


=head2 __PACKAGE__->getCachedSurroundingWords(\%args)

  Purpose:  Given a search word, this function tries to retreive the text surrounding the search word in the retrieved CACHED Web pages. It basically does the search and passes the search results to the WebService::GoogleHack::Text::getCachedSurroundingWords function.

Valid arguments are :

=over 4

=item *

B<searchString> 

I<string>.  The search string which can be a word or phrase

=item *

B<trace_file>.

I<string>.   The location of the trace file. If a file_name is given, the results are stored in this file

=back

returns : Returns a hash with the keys being the words and the values being the frequency of occurence.

=cut

sub getCachedSurroundingWords
{

# the google-hack object containing the searchInfo
    my  $searchInfo = shift;
    my  $searchString = shift;
    my $trace_file=shift;

    require WebService::GoogleHack::Search;

    %words=();

    $results=WebService::GoogleHack::Search::searchPhrase($searchInfo, $searchString);


   for($i=0; $i< 10; $i++)
   {
       print "\n";
       print $results->{'url'}->[$i];
       print "\n";
       if($results->{'url'}->[$i])
       {

	   use LWP::Simple;
	   $url=$results->{'url'}->[$i];
	   $cachedPage=get("$url");
	   
#print $webpage;
	   	   
	   #$cachedPage=WebService::GoogleHack::Search::getCachedPage($searchInfo,);
	
	   $cachedPaget=WebService::GoogleHack::Text::parseWebpage($cachedPage);
	   print "\n Printing Cached Page\n\n";
	   print $cachedPaget;	   
	   @temp=();

# get the cached sentences 
	   @temp=WebService::GoogleHack::Text::getCachedSentences($searchString,$cachedPaget);
       }   
  
       $no_words=@temp;

#inserting words surrounding the searchstring into the words hash.

       for($j=0; $j < $no_words; $j++)
       {
	   $temp_string=lc($ttemp[$j]);

	   $words{"$temp_string"}++ if exists $words{"$temp_string"};	
	   
	   $words{"$temp_string"}=1 if !exists $words{"$temp_string"};	;
       }
       
   }
 
#   $results->{'snippet'}->[0];

#if trace file then write results to file

    if($trace_file ne "")
    {
	$temp="\n Words Surrounding search phrase $searchString in Cached webpages\n\n";
	
	while( ($Key, $Value) = each(%words) ){
	    $temp=$temp."Key: $Key, Value: $Value \n";
	    
 #  $semantic_strings[$count]="$Key ";
	    # print $semantic_strings[$count];
	    # $count++;
	}
	
	open(DAT,">$trace_file") || die("Cannot Open $trace_file to write");
	
	print DAT $temp;

	close(DAT);
	
	
    }
    
    return %words;
   
}




=head2 __PACKAGE__->getSearchSnippetSentences(\%args)

  Purpose:  Given a search word, this function tries to retreive the sentences in the snippet.It basically does the search and passes the search results to the WebService::GoogleHack::Text::getSnippetSentences function


Valid arguments are :

=over 4

=item *

B<searchString> 

I<string>.  The search string which can be a word or phrase

=item *

B<trace_file>.

I<string>.   The location of the trace file. If a file_name is given, the results are stored in this file

=back

returns : Returns an array of strings.

=cut

sub getSnippetSentences
{ 
    my  $searchInfo = shift;
    my $searchString=shift;
    my $trace_file=shift;

    @temp=();

    $results=WebService::GoogleHack::Search::searchPhrase($searchInfo, $searchString);

    for($i=0; $i < 10; $i++)
    {
	if($results->{'snippet'}->[$i])
	    
	{
	  #  print $results->{'snippet'}->[$i];
	  #  print "\n";
	    $temp[$i] = WebService::GoogleHack::Text::removeHTML($results->{'snippet'}->[$i]);
	}
	
    }

    @strings=WebService::GoogleHack::Text::getSnippetSentences(@temp);

    $size=@strings;

  if($trace_file ne "")
    {
	$temp="\n Snippet Sentences for $searchString\n\n";
	
	for($i=0; $i < $size; $i++)
	{	 
   $temp=$temp.$strings[$i]."\n";
	}    
 #  $semantic_strings[$count]="$Key ";
	    # print $semantic_strings[$count];
	    # $count++;
	
	
	open(DAT,">$trace_file") || die("Cannot Open $trace_file to write");
	
	print DAT $temp;

	close(DAT);
	
}


    return @strings;

}


=head2 __PACKAGE__->getCachedSurroundingSentences(\%args)

  Purpose:  Given a search word, this function tries to retreive the sentences in the cached web page.

Valid arguments are :

=over 4

=item *

B<searchString> 

I<string>.  The search string which can be a word or phrase

=item *

B<trace_file>.

I<string>.   The location of the trace file. If a file_name is given, the results are stored in this file

=back

returns : Returns a hash which contains the parsed sentences as values and the key being the web URL.

=cut

sub getCachedSurroundingSentences
{ 
    my  $searchInfo = shift;
    my $searchString=shift;
    my $trace_file=shift;

    $results=WebService::GoogleHack::Search::searchPhrase($searchInfo, $searchString);

    for($i=0; $i< 10; $i++)
    {
	if($results->{'url'}->[$i])
	{
	    $cachedPage=WebService::GoogleHack::Search::getCachedPage($searchInfo,$results->{'url'}->[$i]);
	    
	    $url_value=$results->{'url'}->[$i];

	    @temp=();
	    @temp=WebService::GoogleHack::Text::getCachedSentences($searchString,$cachedPage);
	    
	    $pageContents{"$url_value"}=@temp;
	    
	}
	
    } 
    
    return %pageContents;
}





=head2 __PACKAGE__->getSearchCommonWords(\%args)

  Purpose:Given two search words, this function tries to retreive the common text/words surrounding the search strings in the retrieved snippets.

Valid arguments are :

=over 4

=item *

B<searchString1> 

I<string>.  The search string which can be a word or phrase


=item *

B<searchString2> 

I<string>.  The search string which can be a word or phrase

=item *

B<trace_file>.

I<string>.   The location of the trace file. If a file_name is given, the results are stored in this file

=back

returns : Returns a hash which contains the parsed sentences as values and the key being the web URL.

=cut

sub getSearchCommonWords
{

# the google-hack object containing the searchInfo

    my  $searchInfo = shift;
    my  $searchString1 = shift;  
    my  $searchString2 = shift;
    my $trace_file=shift;

    require WebService::GoogleHack::Search;

    print "\n\nOne $searchString1, Two $searchString2";
    $results1=WebService::GoogleHack::Search::searchPhrase($searchInfo, $searchString1)
;
    @strings1=(); 

    $count=0;  

    require WebService::GoogleHack::Text;
     $innc=0;
    while( $count < 10)
    {
	#print "here";
	#print $results1->{'snippet'}->[$count];
	if($results1->{'snippet'}->[$count] ne "")
	{
	    $strings1[$innc++]=WebService::GoogleHack::Text::removeHTML($results1->{'snippet'}->[$count]);
	}
	
	$count++;
    }
    
    
    $results2=WebService::GoogleHack::Search::searchPhrase($searchInfo, $searchString2);
    @strings2=(); 
    $count=0;
    

    
# I am just checking the first 10 snippets since the snippets get more irrelevant as the hit number increases
    $innc=0;
   
    while( $count < 10)
    {
# removing html tags from the resulting snippet
if($results2->{'snippet'}->[$count] ne "")
   {
   $strings2[$innc++]=WebService::GoogleHack::Text::removeHTML($results2->{'snippet'}->[$count]);

}
		#print "\n String 2 ";	print $strings2[$count];
	$count++;
   }
   
    $count=0;


%results_final1=WebService::GoogleHack::Text::getSurroundingWords($searchString1,5 , @strings1);




%sequence_occs=();

while( ($Key, $Value) = each(%results_final1) ){

    $temp_string=""; 
    @stem = Text::English::stem( "$Key" );
    print "\n This is the stem for $Key:$stem[0]\n";;
    $temp_string=$stem[0];
  
	$sequence_occs{"$temp_string"}++ if exists $sequence_occs{"$temp_string"};
	
#else if the sequence does not in the array, then insert it into the array
	
	$sequence_occs{"$temp_string"}=1 if !exists $sequence_occs{"$temp_string"};
    	    
    
    #   print "\n Key : $Key, $value";
    
}



%results_final2=WebService::GoogleHack::Text::getSurroundingWords($searchString2,5 , @strings2);


while( ($Key, $Value) = each(%results_final2) ){

    $temp_string="";
    @stem = Text::English::stem( "$Key" );


    $temp_string=$stem[0];

   $sequence_occs{"$temp_string"}++ if exists $sequence_occs{"$temp_string"};

#else if the sequence does not in the array, then insert it into the array
 
   $sequence_occs{"$temp_string"}=1 if !exists $sequence_occs{"$temp_string"};

}

 
# print "\n\n\n\n";
    while( ($Key, $Value) = each(%sequence_occs) ){
	
	if($sequence_occs{"$Key"} > 1)
	    
	{
	  
	}
	else
	{
	    #print "\n Not Here for seq occs\n";
	    delete($sequence_occs{"$Key"}) 
		
	    }
    }
    
    #reading in the stop list
    
    %stop_list=WebService::GoogleHack::Text::getWords("$searchInfo->{'stop_list'}");
    
    
    while( ($Key, $Value) = each(%stop_list) ){
    
	delete($sequence_occs{"$Key"}) 
	    
	}


    $fileContent="\n Intersecting Words for $searchString1 & $searchString2\n\n";

    $fileContent.="\nWord List for $searchString1\n";
    $fileContent.="=================================\n";
    
    while( ($Key, $Value) = each(%results_final1) ){
	
	    $fileContent.="\n$Key";
	    
	}
	
	$fileContent.="\n\n\nWord List for $searchString2\n";
	$fileContent.="=================================\n";
	
	while( ($Key, $Value) = each(%results_final2) ){
	
	     $fileContent.="\n$Key";
	    
	 }

	$fileContent.="\n\nIntersecting Words\n";
	$fileContent.="========================\n";

    delete($sequence_occs{""});   
    delete($sequence_occs{"-"});
    
    while( ($Key, $Value) = each(%sequence_occs) ){
	
	$fileContent.="\n$Key";
	
    }
    
if($trace_file ne "")
{
    open(DAT,">>$trace_file") || die("Cannot Open $trace_file to write");
    
    print DAT $fileContent;
    
    close(DAT);
}


return %sequence_occs;

}


=head2 __PACKAGE__->getWordClusters(\%args)

  Purpose:Given a search string, this function retreive the top frequency words, and does a search on those words, and builds a list of words that can be regarded as a cluster of related words.

Valid arguments are :

=over 4

=item *

B<searchString1> 

I<string>.  The search string which can be a word or phrase

=item *=item *

B<iterations> 

I<number>.  The number of iterations that you want the function to search and build cluster on.


B<trace_file>.

I<string>.   The location of the trace file. If a file_name is given, the results are stored in this file

=back

returns : Returns a hash which contains the parsed sentences as values and the key being the web URL.

=cut

sub getWordClusters
{
    my  $searchInfo = shift;
    my $searchString=shift;
    my $iterations=shift;
    my $trace_file=shift;


    $k=0;

   
	$results=WebService::GoogleHack::Search::searchPhrase($searchInfo, $searchString);
     
	$count=0;  
	
	require WebService::GoogleHack::Text;
	
	@strings1=();
	
    while( $count < 10)
    {
	
	$strings1[$count]=WebService::GoogleHack::Text::removeHTML($results->{'snippet'}->[$count]);
	
	$count++;
    }
    
%results_final=WebService::GoogleHack::Text::getSurroundingWords($searchString,5 , @strings1);

 require WebService::GoogleHack::Text;

    %stop_list=WebService::GoogleHack::Text::getWords("$searchInfo->{'stop_list'}");

    @stopwords=();
    $count=0;

while( ($Key, $Value) = each(%stop_list) ){

    delete($results_final{"$Key"}) 

}


  
    
    $clusters=();
    $count=0;

   
    delete($results_final{""}); 

    
}


=head2 __PACKAGE__->getPairWordClusters(\%args)

  Purpose:Given two search strings, this function retreive the snippets for each string, and then finds the intersection of words, and then repeats the search with the intersection of words.

Valid arguments are :

=over 4

=item *

B<searchString1> 

I<string>.  The search string which can be a word or phrase

=item *

B<searchString2> 

I<string>.  The search string which can be a word or phrase


=item *

B<iterations> 

I<number>.  The number of iterations that you want the function to search and build cluster on.

=item *

B<trace_file>.

I<string>.   The location of the trace file. If a file_name is given, the results are stored in this file

=back

returns : Returns a hash which contains the intersecting words as keys and the values being the frequency of occurence.

=cut

sub getPairWordClusters
{

# the google-hack object containing the searchInfo

    my  $searchInfo = shift;
    my  $searchString1 = shift;  
    my  $searchString2 = shift;
    my  $trace_file=shift;


    print "i am in word clusters" ;
    #first, doing a search with the given strings, and finding the intersecting words
    #this associative array would contain the word as a key and the frequency of occurence as the
    #value

    %first_intersection=WebService::GoogleHack::getSearchCommonWords($searchInfo, $searchString1, $searchString2, $trace_file);

    
    @intersection=();
    
    $count=0;
    
    
    #we need to use this since we are using Set::Scalar to find the intersection of words

    while( ($Key, $Value) = each(%first_intersection) ){
if($Key ne "")
{
    $intersection[$count++]= "$Key";
}
	
    }
    
    #for each word in the set of intersecting words
    for($i=0; $i <  $count; $i++)
    {
	%temp=();
	
	#now I am calling this funciton to return the set of words in the snippet 
	#for each intersecting word
	
	%temp=WebService::GoogleHack::getSearchSnippetWords($searchInfo, $intersection[$i], 5, $trace_file);

	#now, again to use Set::Scalar i need to store this stuff in an array
	#arrays would array0.array1 etc etc.

	$varname="array$i";
	#print "\n Array name is $varname\n";
	#initializing the new array

	@$varname=();


	$count1=0;
	
	while( ($Key, $Value) = each(%temp) ){
	#pushing words into the array
	    if($Key ne "")
	    {
		$$varname[$count1++]= "$Key";	    
	    }
	}
	
    }

    #this variable will basically contain all the words    
    
    %cluster=();
    
    for($i=0; $i < $count; $i++)
    {
	#once again assigning the correct name for the array
	
	$varname="array$i";
	
	#initializing the variable $s to the base array. 
	$s = Set::Scalar->new;
	$s = Set::Scalar->new(@$varname);
 
#	print $s, "\n";
	#now, i am going to check array0 against array1,2,3,4...
	# in the next loop i am going to check array1 against array2,3,4...etc

	for($j=$i + 1; $j < $count; $j++)
	{	
	    $tempvarname="array$j";
	    $temp = Set::Scalar->new;
	    $temp = Set::Scalar->new(@$tempvarname);
	    
	    $size = $temp->size; #

	    $tempIntersect=  $temp * $s;

	    while (defined(my $e = $tempIntersect->each))
	    {
		$temp_string="";
		$temp_string=$e;
		
		if($e eq "car")
{
    print "\n\n\n Here ";
    print $cluster{"$temp_string"};
}
		$cluster{"$temp_string"}++ if exists $cluster{"$temp_string"};
		
#else if the sequence does not in the array, then insert it into the array
		
		$cluster{"$temp_string"}=1 if !exists $cluster{"$temp_string"};
		
		
		
	    }


	}
    
    }
 
delete($cluster{""});   
delete($cluster{"-"});
delete($cluster{"a"});
require WebService::GoogleHack::Text;

%stop_list=WebService::GoogleHack::Text::getWords("$searchInfo->{'stop_list'}");


while( ($Key, $Value) = each(%stop_list) ){
    
    delete($cluster{"$Key"}) 
    
    
}


$fileContent="";
$fileContent.="\n\nWord Cluster\n";
$fileContent.="=================\n";
$extended_fileContent="\n\n Extended Cluster for $searchString1 & $searchString2\n\n";

while( ($Key, $Value) = each(%cluster) ){
    
    if($cluster{"$Key"} > 1)    
{
    $fileContent.="\n$Key, $Value";
}
else
{
    #print "\n Not Here for seq occs\n";
    $extended_fileContent.="\n$Key, $Value";

	
    }
}


$fileContent.=$extended_fileContent;

#while( ($Key, $Value) = each(%cluster) ){

#	print $Key, $Value, "\n";
#    $fileContent.="\n$Key, $Value";
#    
#}


if($trace_file ne "")
{
    open(DAT,">>$trace_file") || die("Cannot Open $trace_file to write");
    
    print DAT $fileContent;
    
    close(DAT);
}


    return %cluster;
    
}



=head2 __PACKAGE__->getText(\%args)

  Purpose:Given a search string, this function will retreive the resulting URLs from Google, follow those links, and retrieve the text from there.  The function will then clean up the text and store it in a file along with the URL, Date and time of retrieval.The file will be stored under the name of the search string.

Valid arguments are :

=over 4

=item *

B<searchString> 

I<string>.  The search string which can be a word or phrase.

=item *

B<iterations> 

I<number>.  The number of iterations that you want the function to search and build cluster on.

=item *

B<path_to_data_directory>.

I<string>.   The location where the file containing the retrived information has to be stored.

=back

returns : Returns nothing.

=cut

sub getText
{
    my  $searchInfo = shift;
    my  $searchString = shift;  
    my  $path_to_write=shift;
    my  $numberResults=shift;
    

 ($Second, $Minute, $Hour, $Day, $Month, $Year, $WeekDay, $DayOfYear, $IsDST) = localtime(time);

$Month = $Month + 1; 

if($Month < 10)
{
    $Month = "0" . $Month; 
}


if($Day < 10)
{
    $Day = "0" . $Day; 
}

$Year=$Year+1900;

$date=$Month."-".$Day."-".$Year;

    $results=WebService::GoogleHack::Search::searchPhrase($searchInfo, $searchString);
    
    for($i=0; $i< 10 ; $i++)
    {
	if(($results->{'url'}->[$i]) ne "")
	{
	    
	    $url=$results->{'url'}->[$i];
	    $webPage="";
	    $webPage=LWP::Simple::get("$url");
	    
	    require WebService::GoogleHack::Text;

	    $webPaget=WebService::GoogleHack::Text::parseWebpage($webPage);

	    @stem = Text::English::stem( "$searchString" );
	    $file_name=  $path_to_write.$stem[0].".txt";
	    
	    print $webPaget;
       	    $temp="\n\nURL: $url, Date Retrieved:  $date\n\n";
	    $temp=$temp.$webPaget;
    
	    open(DAT,">>$file_name") || die("Cannot Open $file_name to write");
	    

	    
	    print DAT $temp;
	    
	    close(DAT);
	    
	}
    }
    
    
}


1;
    











