#!/usr/local/bin/perl 

=head1 NAME 

WebService::GoogleHack - Perl package that ties together all GoogleHack modules.

=head1 SYNOPSIS

    use WebService::GoogleHack;

    my $google = new WebService::GoogleHack;

    #Initializing the object to the contents of the configuration file
    # API Key, GoogleSearch.wsdl file location.

    $google->initConfig("initconfig.txt");

    #Printing the contents of the configuration file
    $google->printConfig();

    #Measure the semantic relatedness between the words "white house" and 
    #"president".

    $measure=$google->measureSemanticRelatedness("white house","president");

    print "\nRelatedness measure between white house and president is: ";
    print $measure."\n";

    #Going to search for words that are related to "toyota" and "ford" 
    my @terms=();
    push(@terms,"toyota");
    push(@terms,"ford");

    #The parameters are the search terms, number of web page results to look 
    #at, the number of iterations,output file and the "true" indicates that the
    #diagnostic data should be stored in the file "results.txt"

    $results=$google->wordClusterInPage(\@terms,10,25,1,"results.txt","true");

    print $results;


=head1 DESCRIPTION

WebService::GoogleHack - Is a Perl package that interacts with the Google API,
and has some basic functionalities that allow the user to interact with 
Googleand retrieve results. It also  has some Natural Language Processing 
capabilities, such as the ability to predict the semantic orienation of words, 
build word clusters, and find words that are common to a pair of words.

Related Modules:

WebService::GoogleHack::Text 

WebService::GoogleHack::Search

WebService::GoogleHack::Rate 

WebService::GoogleHack::Spelling

=head1 Required Packages

Brill Tagger 

    Installation file and instructions @ : 
   
    http://www.cs.jhu.edu/~brill/RBT1_14.tar.Z

Required PERL Modules

    SOAP::Lite;

    Set::Scalar;

    Text::English;

    LWP::Simple;

    URI::URL;

    LWP::UserAgent;

    HTML::LinkExtor;
 
    Data::Dumper;

=head1 PACKAGE METHODS

=head2 __PACKAGE__->new()

Purpose: This function creates an object of type GoogleHack and returns a blessed reference.

=head2 __PACKAGE__->initConfig(configLocation)

Purpose:  This function is used to read a configuration file containing 
informaiton such as the Google-API key, the words list etc.

Valid arguments are :

=over 4

=item *

B<configLocation> 

I<string>.  Location of the configuration file.

=back

returns : Returns an object which contains the parsed information.

=head2 __PACKAGE__->printConfig()

Purpose:  This function is used to print the information read from a 
configuration file 

No arguments.

=head2 __PACKAGE__->setMaxResults(maxResults)

Purpose: This function sets the maximum number of results retrieved

Valid arguments are :

=over 4

=item *

B<maxResults>

I<Number>. The maximum number of results we want to be able to retrieve from a Google search. Should be less than 10.

=back

=head2 __PACKAGE__->setlr(lr)

Purpose: This this function used to set the language restriction.

Valid arguments are :

=over 4

=item *

B<lr>

I<string>. Language Restricion eg, "lang_eng", This will restrict the google 
search to web pages in english.

=back

=head2 __PACKAGE__->setStartPos(StartPos)

Purpose: This function sets the startposition for the search results. This should be an integer
between 0 and 1000.

Valid arguments are :

=over 4

=item *

B<StartPos>

I<string>.

=back

=head2 __PACKAGE__->setRestrict(Restrict)

Purpose: This function sets the restrict search to a specific domain on.

Valid arguments are :

=over 4

=item *

B<Restrict>

I<String>. UncleSam for the US Government

=back

=head2 __PACKAGE__->setSafeSearch(Restrict)

Purpose: This functions enables safe search, Restricts search to non-abusive material.

Valid arguments are :

=over 4

=item *

B<Restrict>

I<Boolean>. "True" or "False".

=back

=head2 __PACKAGE__->measureSemanticRelatedness(searchString1,searchString2)

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

=head2 __PACKAGE__->predictSemanticOrientation(reviewfile,positive_inference,negative_inference,trace_file)

Purpose: this function tries to predict the semantic orientation of a paragraph of text need

Valid arguments are :

=over 4

=item *

B<reviewfile> 

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

=head2 __PACKAGE__->phraseSpelling(searchString)

Purpose: This is function is used to retrieve a spelling suggestion from Google


Valid arguments are :

=over 4

=item *

B<searchString> 

I<string>.  Need to pass the search string, which can be a single word 

=back

Returns: Returns suggested spelling if there is one, otherwise returns "No Spelling Suggested":


=head2 __PACKAGE__->Search(searchString,num_results)

Purpose: This function is used to query googles 

Valid arguments are :

=over 4

=item *

B<searchString> 

I<string>.  Need to pass the search string, which can be a single word or phrase, maximum ten words

=item *

B<num_results> 

I<integer>. The number of results you wast to retrieve, default is 10. Maximum is 1000.


=back

Returns: Returns a GoogleHack object containing the search results.

=head2 __PACKAGE__->getSearchSnippetWords(searchString,numResults,trace_file)

Purpose:  Given a search word, this function tries to retreive the text 
surrounding the search word in the retrieved snippets. 

Valid arguments are :

=over 4

=item *

B<searchString> 

I<string>.  The search string which can be a word or phrase

=item *

B<numResults> 

I<string>. The number of results to be processed from google.

=item *

B<trace_file>.

I<string>.   The location of the trace file. If a file_name is given, the results are stored in this file

=item *

B<proximity> 

I<string>. The number of words surrounding the searchString (Not Implemented) 
yet 

=back

returns : Returns an object which contains the parsed information

=head2 __PACKAGE__->getCachedSurroundingWords(searchString,trace_file)

Purpose:  Given a search word, this function tries to retreive the text 
surrounding the search word in the retrieved CACHED Web pages. It basically 
does the search and passes the search results to the 
WebService::GoogleHack::Text::getCachedSurroundingWords function.

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

=head2 __PACKAGE__->getSearchSnippetSentences(searchString,trace_file)

Purpose:  Given a search word, this function tries to retreive the 
sentences in the snippet.It basically does the search and passes the 
search results to the WebService::GoogleHack::Text::getSnippetSentences 
function

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

=head2 __PACKAGE__->getCachedSurroundingSentences(searchString,trace_file)

Purpose:  Given a search word, this function tries to retreive the 
sentences in the cached web page.

Valid arguments are :

=over 4

=item *

B<searchString> 

I<string>.  The search string which can be a word or phrase

=item *

B<trace_file>.

I<string>.   The location of the trace file. If a file_name is given, 
the results are stored in this file

=back

returns : Returns a hash which contains the parsed sentences as values and the
key being the web URL.

=head2 __PACKAGE__->getSearchCommonWords(searchString1,searchString2,trace_file,stemmer)

Purpose:Given two search words, this function tries to retreive the common 
text/words surrounding the search strings in the retrieved snippets.

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

I<string>.   The location of the trace file. If a file_name is given, the 
results are stored in this file

=item *

B<stemmer>.

I<bool>. Porter Stemmer on or off.

=back

returns : Returns a hash which contains the intersecting words.

=head2 __PACKAGE__->getWordClustersInSnippets(searchString1,iterations,number,trace_file)

Purpose:Given a search string, this function retreive the top frequency words
, and does a search on those words, and builds a list of words that can be 
regarded as a cluster of related words.

Valid arguments are :

=over 4

=item *

B<searchString1> 

I<string>.  The search string which can be a word or phrase

=item *=item *

B<iterations> 

I<number>.  The number of iterations that you want the function to search and 
build cluster on.


B<trace_file>.

I<string>.   The location of the trace file. If a file_name is given, the 
results are stored in this file

=back

returns : Returns a set of words as a hash.

=head2 __PACKAGE__->getClustersInSnippets(searchString1,searchString2,iterations,number,trace_file)

Purpose:Given two search strings, this function retreive the snippets for 
each string, and then finds the intersection of words, and then repeats the 
search with the intersection of words.

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

I<number>.  The number of iterations that you want the function to search and 
build cluster on.

=item *

B<trace_file>.

I<string>.   The location of the trace file. If a file_name is given, the 
results are stored in this file

=back

returns : Returns a hash which contains the intersecting words as keys and the
 values being the frequency of occurence.

=head2 __PACKAGE__->getText(searchString,iterations,number,path_to_data_directory)

Purpose:Given a search string, this function will retreive the resulting 
URLs from Google, follow those links, and retrieve the text from there.  The 
function will then clean up the text and store it in a file along with the URL,
 Date and time of retrieval.The file will be stored under the name of the 
search string.

Valid arguments are :

=over 4

=item *

B<searchString> 

I<string>.  The search string which can be a word or phrase.

=item *

B<iterations> 

I<number>.  The number of iterations that you want the function to search and 
build cluster on.

=item *

B<path_to_data_directory>.

I<string>.   The location where the file containing the retrived information 
has to be stored.

=back

returns : Returns nothing.

=head2 __PACKAGE__->getWordsInPage(searchTerms,numResults,frequencyCutoff,iteration,numberofSearchTerms,bigrams,trace_file_path)

Purpose:Given a set of search temrs, this function will retreive the resulting 
URLs from Google, it will then follow those links, and retrieve the text from there.  
Once all the text is collected, the function finds the intersecting or co-occurring words
between the top N results. This function is basically used by the function wordClusterInPage.

Valid arguments are :

=over 4

=item *

B<searchTerms> 

I<string>.  An array which contains each search term (It can only be a word not phrase).

=item *

B<numResults> 

I<number>.  The number of web pages results to be looked at.

=item *

B<frequencyCutoff> 

I<number>.  Words occuring less than the frequencyCutoff would be excluded from results.


=item *

B<iteration> 

I<number>.  The current iteration number.

=item *

B<numberofSearchTerms> 

I<number>.  The number of search terms in the initial set.

=item *

B<bigrams> 

I<number>.  The bigram cutoff.Set to 0 to exclude bigrams.


=item *

B<trace_file_path>.

I<string>.   The location of the trace file.

=back

returns : Returns nothing.

=head2 __PACKAGE__->wordClusterInPage(searchTerms,numResults,frequencyCutoff,numIterations,path_to_data_directory, html)

Purpose:Given two or more words, this function tries to find a set of related words. This is the Google-Hack baseline algorithm 1.

=over 4

=item *

B<searchTerms> 

I<string>.  The array of search terms (Can only be a word).
=item *

B<numResults> 

I<number>.  The number of web pages results to be looked at.

=item *

B<numResults> 

I<number>.  The number of web pages results to be looked at.


=item *

B<frequencyCutoff> 

I<number>.  Words occuring less than the frequencyCutoff would be excluded from results.

=item *

B<numIterations> 

I<number>.  The number of iterations that you want the function to search and build cluster on.

=item *

B<path_to_data_directory>.

I<string>.   The location where the file containing the retreived information 
has to be stored.

=back

returns : Returns an html or text version of the results.

=head2 __PACKAGE__->Algorithm2(searchTerms,numResults,frequencyCutoff,bigramCutoff,numIterations,scoreType,scoreCutOff,path_to_data_directory, html)

Purpose:Given two or more words, this function tries to find a set of related words. This is the Google-Hack baseline algorithm 1.

=over 4

=item *

B<searchTerms> 

I<string>.  The array of search terms (Can only be a word).
=item *

B<numResults> 

I<number>.  The number of web pages results to be looked at.

=item *

B<numResults> 

I<number>.  The number of web pages results to be looked at.


=item *

B<frequencyCutoff> 

I<number>.  Words occuring less than the frequencyCutoff would be excluded from results.

=item *

B<bigramCutoff> 

I<number>. Bigrams occuring less than the bigramCutoff would be excluded from results.

=item *

B<numIterations> 

I<number>.  The number of iterations that you want the function to search and build cluster on.

=item *

B<scoreType>

I<number>.  Takes on the values 1,2 or 3 indicating the relatedness measure to be used.

=item *

B<scoreCutOff> 

I<number>. Words and Bigrams with relatedness score greater than the scoreCutOff would be excluded from results.


=item *

B<path_to_data_directory>.

I<string>.   The location where the file containing the retreived information 
has to be stored.

=back

returns : Returns an html or text version of the results.

=head2 __PACKAGE__->predictWordSentiment(infile,positive_inference,negative_inference,$htmlFlag,$traceFile)

Purpose:Given an file containing text, this function tries to find the positive and negative words.

=over 4

=item *

B<infile> 

I<string>. The input file

=item *

B<positive_inference> 

I<string>. A positive word such as "Excellent"

=item *

B<negative_inference>.

I<string>. A negative word such as "Bad"

=item *

B<htmlFlag>.

I<string>. Set to "true" if you want the results to be HTML formatted

B<tracefile>.

I<string>. Set to a file if you want the results to be written to the given filename.

=back

returns : Returns an html or text version of the results.

=head2 __PACKAGE__->predictPhraseSentiment(infile,positive_inference,negative_inference,$htmlFlag,$traceFile)

Purpose:Given an file containing text, this function tries to find the positive and negative phrases. The function
selects phrases based on the patterns given in the "Thumbs up or Down" paper.

=over 4

=item *

B<infile> 

I<string>. The input file

=item *

B<positive_inference> 

I<string>. A positive word such as "Excellent"

=item *

B<negative_inference>.

I<string>. A negative word such as "Bad"

=item *

B<htmlFlag>.

I<string>. Set to "true" if you want the results to be HTML formatted

B<tracefile>.

I<string>. Set to a file if you want the results to be written to the given filename.

=back

returns : Returns an html or text version of the results.

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

=cut


package WebService::GoogleHack;

our $VERSION = '0.09';

use SOAP::Lite;
use Set::Scalar;
use Text::English;
use LWP::Simple;
use URI::URL;
use LWP::UserAgent;
use HTML::LinkExtor;
use Data::Dumper;

my $global_url="";

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
$this-> {'basedir'} = undef;
$this-> {'taggerdir'} = undef;
$this->{'PMIMeasure'}=undef;
$this->{'prediction'}=undef;
$this-> {'maxResults'} =10;
$this-> {'StartPos'} =0;
$this-> {'Filter'} ="false";
$this-> {'Restrict'} ="";
$this-> {'safeSearch'} ="false";
$this-> {'lr'} ="";
$this-> {'oe'} ="";
$this-> {'ie'} ="";
$this-> {'url'} = undef;
$this-> {'cachedPage'} = undef;
$this-> {'title'} = undef;

#making sure to bless this object 

bless $this;

return $this;
}




sub init
{

#making sure this is assigned the object reference

my $this = shift;

$this->{'Key'} = shift;
$this->{'File_Location'} = shift;
$this-> {'basedir'} = shift;
$this-> {'taggerdir'} = shift;

}


sub setMaxResults
{
    my $this = shift;
    $maxResults = shift;
    $this-> {'maxResults'} =$maxResults;
}

#this function sets the language restriction


sub setlr
{
    my $this = shift;
    $lr = shift;
    $this-> {'lr'} =$lr;
}


sub setoe
{
    my $this = shift;
    $oe = shift;

    $this-> {'oe'} =$oe;


}


sub setie
{
    my $this = shift;
    $ie = shift;

    $this-> {'ie'} =$ie;


}

sub setStartPos
{
    my $this = shift;
    $StartPos = shift;

    $this-> {'StartPos'} =$StartPos;


}

sub setFilter
{
    my $this = shift;
    $Filter = shift;

    $this-> {'Filter'} =$Filter;


}

sub setRestrict
{
    my $this = shift;
    $Restrict = shift;

    $this-> {'Restrict'} =$Restrict;


}

sub setSafeSearch
{
    my $this = shift;
    $Restrict = shift;

    $this-> {'Restrict'} =$Restrict;


}

sub measureSemanticRelatedness
{
  my $this = shift;
  my $searchString1=shift;
  my $searchString2=shift;

  print "i am here";

 require WebService::GoogleHack::Rate;

 $results=WebService::GoogleHack::Rate::measureSemanticRelatedness($this, $searchString1, $searchString2);

 return $results;

}


sub predictSemanticOrientation
{
  my $searchInfo=shift;
  my $infile=shift;
  my $positive_inference=shift;
  my $negative_inference=shift;
  my $trace_file=shift;

  require WebService::GoogleHack::Text;
  
  WebService::GoogleHack::Text::Boundary($this,$infile);
  
  WebService::GoogleHack::Text::POSTagData($this);
   
  require WebService::GoogleHack::Rate;

  my $taggedInput=$this->{'basedir'}."Temp/temp.fr.tg";
  
 my $results=WebService::GoogleHack::Rate::predictSemanticOrientation($searchInfo,$taggedInput,$positive_inference,$negative_inference,$trace_file);
  
    return $results;

}

sub phraseSpelling
{
  my $this = shift;
  my $searchString=shift;
 
 require WebService::GoogleHack::Spelling;
  $this->{'correction'} = WebService::GoogleHack::Spelling::spellingSuggestion($this, $searchString);

 return $this->{'correction'};
}


sub Search
{
  my $this = shift;
  my $searchString=shift;
  my $num_results=shift;
 
  require WebService::GoogleHack::Search;
 
  $results=WebService::GoogleHack::Search::searchPhrase($this, $searchString,$num_results);

  $this->{'NumResults'}=$results->{'NumResults'};
  $this-> {'snippet'} = $results->{'snippet'};
  $this-> {'searchTime'} =$results->{'searchTime'};
  $this-> {'url'} = $results->{'url'};
  $this-> {'title'} = $results->{'title'};
 
  return $this;

}


sub initConfig
{

my $this=shift;
my $filename=shift;

    require WebService::GoogleHack::Text;


#calling the read config function in text

    $results=WebService::GoogleHack::Text::readConfig("$filename");
    $this->{'Key'}=$results->{'Key'};
    $this->{'File_Location'}=$results->{'File_Location'};
    $this-> {'basedir'} = $results->{'basedir'};
    $this-> {'taggerdir'} =$results->{'taggerdir'}  ;

return $this;

}


sub printConfig
{

    $this=shift;

    print "\n This is the information retrieved from the configuration file\n";

    print "\n Key:";
    print $this->{'Key'};
    
    print "\n WSDL Location:";
    print  $this->{'File_Location'};
    
    print "\n Base Directory:";
    print $this-> {'basedir'};

    print "\n Tagger Directory:";
    print $this-> {'taggerdir'} ;
    
    print "\n\n";

}


sub getSearchSnippetWords
{

# the google-hack object containing the searchInfo

    my  $searchInfo = shift;
    my  $searchString = shift;
    my  $numResults = shift;
    my  $trace_file=shift;
    my  $proximity = shift;
    require WebService::GoogleHack::Search;

  
    if(!defined($numResults))
    {
	$numResults=10;
    }

  $results=WebService::GoogleHack::Search::searchPhrase($searchInfo, $searchString,$numResults);


    @strings=();
    $count=0;
    require WebService::GoogleHack::Text;

# I am just checking the first 10 snippets since the snippets get more irrelevant as
# the hit number increases

    while( $count < $numResults)
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





sub getSearchCommonWords
{

# the google-hack object containing the searchInfo

    my  $searchInfo = shift;
    my  $searchString1 = shift;  
    my  $searchString2 = shift;
    my  $numResults=shift;
    my  $trace_file=shift;
    my $stemmer=shift;

    my $stoplist_location=$searchInfo->{'basedir'}."Datafiles/stoplist.txt";
    
    if(!defined($numResults))
    {
	$numResults=10;
    }

    if(!defined($stemmer))
    {
	$stemmer="false";
    }

 #   print $trace_file;
    require WebService::GoogleHack::Search;

    print "\n\nOne $searchString1, Two $searchString2";
    $results1=WebService::GoogleHack::Search::searchPhrase($searchInfo, $searchString1, $numResults)
;
    @strings1=(); 

    $count=0;  

    require WebService::GoogleHack::Text;
     $innc=0;
    while( $count < $numResults)
    {
	#print "here";
	#print $results1->{'snippet'}->[$count];
	if($results1->{'snippet'}->[$count] ne "")
	{
	    $strings1[$innc++]=WebService::GoogleHack::Text::removeHTML($results1->{'snippet'}->[$count]);
	}
	
	$count++;
    }
    
    
    $results2=WebService::GoogleHack::Search::searchPhrase($searchInfo, $searchString2, $numResults);
    @strings2=(); 
    $count=0;
    

    
# I am just checking the first 10 snippets since the snippets get more irrelevant as the hit number increases
    $innc=0;
   
    while( $count < $numResults)
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


%results_final1=WebService::GoogleHack::Text::getSurroundingWords($searchString1,5 , @strings1, $stemmer);




%sequence_occs=();

while( ($Key, $Value) = each(%results_final1) ){

    $temp_string=""; 
    $Key=~s/[\,\\\/\:\(\)\[\]\{\}\_\-\?]//g;

if($stemmer eq "true")
{
    @stem = Text::English::stem( "$Key" );
    print "\n This is the stem for $Key:$stem[0]\n";;
    $temp_string=$stem[0];
}
else
{
    $temp_string="$Key"; 
}
 
	$sequence_occs{"$temp_string"}++ if exists $sequence_occs{"$temp_string"};
	
#else if the sequence does not in the array, then insert it into the array
	
	$sequence_occs{"$temp_string"}=1 if !exists $sequence_occs{"$temp_string"};
    	    
    
    #   print "\n Key : $Key, $value";
    
}



%results_final2=WebService::GoogleHack::Text::getSurroundingWords($searchString2,5 , @strings2, $stemmer);


while( ($Key, $Value) = each(%results_final2) ){

    $temp_string="";
if($stemmer eq "true")
{
    @stem = Text::English::stem( "$Key" );
    $temp_string=$stem[0];
}
else
{
    $temp_string="$Key";

}

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
    
    %stop_list=WebService::GoogleHack::Text::getWords("$stoplist_location");
    
    
    while( ($Key, $Value) = each(%stop_list) ){
    
	delete($sequence_occs{"$Key"}) 
	    
	}


$date=getDateHeader();

$fileContent="\n\n\n================================================================";
$fileContent.="\n\n Query Date - $date - Intersecting Words for $searchString1 & $searchString2\n\n";
$fileContent.="================================================================\n\n";
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
#return $fileContent;

}


sub getWordClustersInSnippets
{
    my  $searchInfo = shift;
    my $searchString=shift;
    my $iterations=shift;
    my $trace_file=shift;

    my $stoplist_location=$searchInfo->{'basedir'}."Datafiles/stoplist.txt";
    
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
    
    %stop_list=WebService::GoogleHack::Text::getWords("$stoplist_location");
    
    @stopwords=();
    $count=0;
    
    while( ($Key, $Value) = each(%stop_list) ){
	
	delete($results_final{"$Key"}) 
	    
}
    
    $clusters=();
    $count=0;
   
    delete($results_final{""});     
}



sub getClustersInSnippets
{

# the google-hack object containing the searchInfo

    my  $searchInfo = shift;
    my  $searchString1 = shift;  
    my  $searchString2 = shift;
    my  $numResults=shift;
    my  $cutOff=shift;
    my  $trace_file=shift;

    my $stoplist_location=$searchInfo->{'basedir'}."Datafiles/stoplist.txt";

  if(!defined($numResults))
  {
      $numResults=10;
  }
 if(!defined($cutOff))
  {
      $cutOff=1;
  }

    print "i am in word clusters" ;
    #first, doing a search with the given strings, and finding the intersecting words
    #this associative array would contain the word as a key and the frequency of occurence as the
    #value

    
%first_intersection=WebService::GoogleHack::getSearchCommonWords($searchInfo, 
$searchString1, $searchString2, $numResults,$trace_file);

    
    @intersection=();
    
    $count=0;
    
    
    #we need to use this since we are using Set::Scalar to find the intersection of words

    while( ($Key, $Value) = each(%first_intersection) ){
	$Key=~s/[\,\\\/\:\(\)\[\]\{\}\_\-\?]//g;
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
	
	%temp=WebService::GoogleHack::getSearchSnippetWords($searchInfo, $intersection[$i], $numResults, $trace_file);

	#now, again to use Set::Scalar i need to store this stuff in an array
	#arrays would array0.array1 etc etc.

	$varname="array$i";

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

%stop_list=WebService::GoogleHack::Text::getWords("$stoplist_location");


while( ($Key, $Value) = each(%stop_list) ){
    
    delete($cluster{"$Key"}) 
    
    
}


$fileContent="";
$fileContent.="\n\nWord Cluster\n";
$fileContent.="=================\n";
$extended_fileContent="\n\n Extended Cluster for $searchString1 & $searchString2\n\n";

while( ($Key, $Value) = each(%cluster) ){
    
    if($cluster{"$Key"} >= $cutOff)    
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


    return $fileContent;
    
}

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
	    
	    #print $webPaget;
       	    $temp="\n\nURL: $url, Date Retrieved:  $date\n\n";
	    $temp=$temp.$webPaget;
    
	    open(DAT,">>$file_name") || die("Cannot Open $file_name to write");
	    

	    
	    print DAT $temp;
	    
	    close(DAT);
	    
	}
    }
    
return $temp;
    
}

sub getDateHeader
{

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

if($Minute < 10)
{
    $Minute = "0" . $Minute; 
}

if($Hour < 10)
{
    $Hour = "0" . $Hour; 
}

if($Second < 10)
{
    $Second = "0" . $Second; 
}

$Year=$Year+1900;


$date=$Month."-".$Day."-".$Year." @ ".$Hour.":".$Minute.":".$Second;

return $date;

}



sub getWordsInPage
{

    my $searchInfo = shift;# the google-hack object containing the searchInfo
    my $ref_searchStrings = shift;  #the search strings
    my $numResults=shift; # the number of results to look at
    my $cutOff=shift; #the cutoff -- remnove words which occur less than cutoff
    my $iterations=shift;
    my $numSearchTerms=shift;
    my $bigram=shift;
    my $trace_file=shift;  #output to tracefile
    my $stoplist_location=$searchInfo->{'basedir'}."Datafiles/stoplist.txt";
    my %searchHash=();
    #retrieving words in the stop list
  

    # setting default numresults and cut off 

    if(!defined($numResults))
    {
	$numResults=10;
    }
    if(!defined($cutOff))
    {
	$cutOff=5;
    }

    #array of searchstrings

    my @searchStrings=@{$ref_searchStrings};
    my $size=$#searchStrings +1;
    my @permutations=();
    my @fileContent=();

     # for the number of searchstrings
     # creating all the permutations of the words
     # the thing abt google is that "toyota and ford" doesnt give the same results as "ford and toyota".

    if($iterations > 0)
    {	
	#for(my $i=0;$i< 2;$i++)
	#{
	    #push(@permutations,$searchStrings[$i]);
	#    $searchHash{$searchStrings[$i]}=1;
	#}
	
	for(my $i=$numSearchTerms;$i< $size;$i++)
	{
	   #push(@permutations,$searchStrings[$i]);
	   #$searchHash{$searchStrings[$i]}=1;

	    for(my $j=$numSearchTerms;$j< $size;$j++)
	    {
		if($i != $j)
		{ 
		    my $string=$searchStrings[$i]." AND ".$searchStrings[$j];  
		    print "\n Pushing into permutations $string";
		    push(@permutations,$string);
		}
	    }
	}
	      
    }
    
    else
    {
	for(my $i=0;$i< $size;$i++)
	{	
	  #  print "\n Pushing into permutations $searchStrings[$i]";
	  #  push(@permutations,$searchStrings[$i]);

	    my @tempTerms = split(/\s+/, $searchStrings[$i]);	

	    foreach my $term (@tempTerms)
	    {
		$term=lc($term); 
		print "\n term is $term:";		
		$term=~s/\s+//g;
		if($term ne "")
		{
		    print "\n second term is ";
		    $searchHash{$term}=1;	
		}
	    }

	    undef @tempTerms;

	    $searchHash{$searchStrings[$i]}=1;
	    
	    for(my $j=0;$j< $size;$j++)
	    {
		if($i != $j)
		{   
		    my $string=$searchStrings[$i]." AND ".$searchStrings[$j];
		    print "\n Pushing into permutations $string";
		    push(@permutations,$string);
		}
	    }
	}
	
    }
    
   
    my $count=0;

    foreach my $query (@permutations)
    {

	#doing the actual search

	require WebService::GoogleHack::Search;
	my $results=WebService::GoogleHack::Search::searchPhrase($searchInfo, $query);
	print "\n\n\n Query is here $query\n";
	$t=$count+1;
	#saving the url's
	$global_url.="\n<B>URL Set $t</B>";
	

	# now for each url, I am going through the urls in the url.

	for(my $i=0; $i< $numResults ; $i++)
	{
 	    if(($results->{'url'}->[$i]) ne "")
	    {
	
	 	my $url = $results->{'url'}->[$i];  # for instance 

		print "\n\n$i, $url:";
		my $ua = LWP::UserAgent->new; 
		my @links = ();

		sub callback {
		    my($tag, %attr) = @_;
		    return if $tag ne 'a';  # we only look closer at <img ...>
		    push(@links, values %attr);
		}

		my $p = HTML::LinkExtor->new(\&callback); 
		# Request document and parse it as it arrives
		my $res = $ua->request(HTTP::Request->new(GET => $url),
				    sub {$p->parse($_[0])});  
		# Expand all image URLs to absolute ones
		my $base = $res->base;
		@links = map { $_ = url($_, $base)->abs; } @links; 
		push(@links,$url);
		
		#for each link in a url
 		foreach my $webPage (@links)
		{		  
                  if($webPage=~m/(.pdf)/gs)
                   {
                    print "\n Matched $url";
                    }
                 else
                 {
	
		    my $content=LWP::Simple::get("$webPage");  
#print "\n".$content;
		    $global_url.="\n<br><a href=\'$webPage\'>$webPage</a>";
		    my $cachedPage=WebService::GoogleHack::Text::parseWebpage($content);	
		    $cachedPage=lc($cachedPage);
		    $fileContent[$count].="\n\n$cachedPage";
                   }

 		}
            }
	}
	
	$global_url.="\n\n<br>";

$count++;$searchStrings[$i]
    }

    require WebService::GoogleHack::Text;

  %stop_list=WebService::GoogleHack::Text::getWords("$stoplist_location");

    my %frequencyMatrix=();
    %matrix=();
    $count=0;
    my $data=();
    my $index=0;
    my @bwords=();
    my $str="";
    my $tsize=2;

# the array filecontent now has the text from each url and its subset of urls.
    
    foreach $context (@fileContent)
    {   
	my @words=();

#    $context=~s/[0-9]//gs; 
	$context=~tr/a-zA-z.!?/ /cs;
	$context=~tr/[|]|^|_|-|&|\#|\@|~|\'/ /s;
	$context=~s/\s+/ /g;
	$_=$context;

	if($bigram >= 1)
	{
	    while(/(\s*)(((\s|\w|\d)+)(.|\!|\?))/g)
	    {
		@bwords=();
		@bwords=split(/\s/, $3);
		for(my $i=0;$i<=$#bwords ;$i++)
		{	
		    if(!exists $stop_list{"$bwords[$i]"})	
		    {
			$temp=$i+$tsize;
			
			for(my $j=$i+1; $j<$temp;$j++)
			{
			    if($j<($#bwords+1))
			    {
				if( !exists $stop_list{"$bwords[$j]"})		   
				{
				    $str="$bwords[$i] $bwords[$j]";
				    #t    print "\n Bigram is $str";
				    $matrix{"$permutations[$count]"}->{"$str"}++ if exists $matrix{"$permutations[$count]"}->{"$str"};
				    $frequencyMatrix{"$str"}++ if exists $frequencyMatrix{"$str"};

				    $matrix{"$permutations[$count]"}->{"$str"}=1 if !exists $matrix{"$permutations[$count]"}->{"$str"};
				    $frequencyMatrix{"$str"}=1  if !exists  $frequencyMatrix{"$str"};
				}
			    }
			}
		    }
		}
#		$data[$index++] =;
	    }
	    
	}

	@words = split(/\s+|\,|\?|\./, $context);	
	
    foreach my $word (@words)
    {
	#$word=~s/[\"!;:\'\`\{\(\}\)\[\]\s\=\+\-\/0-9\|\&\$%]//g;
	$word=~s/[^\w]//g;
	if($word ne "")
	{
	    if ((!exists $stop_list{"$word"}) && (!exists $searchHash{"$word"}))
		#    if ((!exists $stop_list{"$word"}))
	    {  
		$matrix{"$permutations[$count]"}->{"$word"}++ if exists $matrix{"$permutations[$count]"}->{"$word"};
		$frequencyMatrix{"$word"}++ if exists $frequencyMatrix{"$word"};
		
		$matrix{"$permutations[$count]"}->{"$word"}=1 if !exists $matrix{"$permutations[$count]"}->{"$word"};
		$frequencyMatrix{"$word"}=1  if !exists  $frequencyMatrix{"$word"};
	    }
	}
	
       	
    }
    
    $count++;
}

$count=0;


#removing words below cutff

for my $word ( keys %matrix ) {
    
    my $varname="var".$count;
    @$varname=();
    my $k=0;

    for my $context ( keys %{ $matrix{$word} } ) {


	if($bigram >= 1)
	{
	    my @tem=split(/\s+/,$context);
	    
	    if(($#tem+1) > 1)
	    {
		
		if($matrix{$word}{$context} >= $bigram)
		{
		    print "\n $context, $matrix{$word}{$context}";		
		    $$varname[$k++]=$context;
		}
		
		
	    }
	    
	}
	
	if($matrix{$word}{$context} >= $cutOff)
	{
	  
	    $$varname[$k++]=$context;
	}

    }
    $count++;
}


%cluster=();


#finding the intersection
%stop_list=WebService::GoogleHack::Text::getWords("$stoplist_location");

for(my $i=0;$i<$count; $i++)
{
	$varname="var$i";
	
	#initializing the variable $s to the base array. 
	$s = Set::Scalar->new;
	$s = Set::Scalar->new(@$varname);
 
	for($j=$i + 1; $j < $count; $j++)
	{	
	    $tempvarname="var$j";
	    $temp = Set::Scalar->new;
	    $temp = Set::Scalar->new(@$tempvarname);
	    
	    $size = $temp->size; #

	    $tempIntersect=  $temp * $s;

	    while (defined(my $e = $tempIntersect->each))
	    {
		$temp_string="";
		$temp_string=$e;
	  if (!exists $stop_list{"$temp_string"})
	    { 
		#$cluster{"$temp_string"}++ if exists $cluster{"$temp_string"};
	#print "\n $temp_string $frequencyMatrix{$temp_string}";
#		$cluster{"$temp_string"}= if exists $cluster{"$temp_string"};

		#print "\n $temp_string";
#else if the sequence does not in the array, then insert it into the array
		
		$cluster{"$temp_string"}=$frequencyMatrix{"$temp_string"} if !exists $cluster{"$temp_string"};		       
	    }

	    }
	}
   
}

    return %cluster;
    
}


sub wordClusterInPage
{
    my $searchInfo = shift;
    my $ref_searchStrings = shift;  
    my $numResults=shift;
    my $cutOff=shift;
    my $iterations=shift;
    my $trace_file=shift;
    my $html=shift;
    my %htmlresults=();
    my $numSearchTerms=0;

    my @searchTerms=@{$ref_searchStrings};
    
    %results=WebService::GoogleHack::getWordsInPage($searchInfo, $ref_searchStrings, $numResults,$cutOff,0,2,0,$trace_file);


    

    my $htmlContent="";
    my $fileContent="";

    my $Relatedness=0;
    my $tempScore="";

    $htmlContent.="<TABLE><TR><TD> <B> Result Set 1 </B> </TD></TR>";
    $fileContent="\n Result Set 1 \n";

    foreach my $key (sort  { $results{$b} <=> $results{$a} } (keys(%results))) {
	$htmlContent.="<TR><TD>$key : $results{$key} </TD></TR>";   	
	$fileContent.="\n $key : $results{$key}";   	
    }
    
    $htmlContent.="\n</TABLE>\n";
    $fileContent.="\n ";

    print "\n Got done with first round";

    for(my $i=1; $i < $iterations; $i++)
    {
	print "\n I am now in $i round";

	@searchStrings=();	

	foreach my $term (@searchTerms)
	{
	    push(@searchStrings, $term);
	}
    
	for my $word ( keys %cluster) {
	   
	    print "\n key is $word";
	    if($cluster{"$word"} > 0)
	    {		
		push(@searchStrings,$word);
		$numSearchTerms++;
	    }
	}


	%cluster=();
	%cluster=WebService::GoogleHack::getWordsInPage($this, \@searchStrings, $numResults,$cutOff,$i,2,0,$trace_file);

	my $k=$i+1;
	$htmlContent.="\n<br><TABLE><TR><TD> <B> Result Set $k </B> </TD></TR>";
	$fileContent.="\n Result Set $k \n";
	
	$Relatedness="No Score";
	$tempScore=0;

	foreach my $key (sort  { $cluster{$b} <=> $cluster{$a} } (keys(%cluster))) {
	    $htmlContent.="\n<TR><TD>$key:$cluster{$key}</TD></TR>";
	    $fileContent.="\n$key";
	}

        $htmlContent.="\n\n</TABLE><BR><BR>";  
	$fileContent.="\n\n";
	
    }

    $htmlContent.=$global_url;  
    $fileContent.=$global_url;

    if($trace_file ne "")
    {
	open(DAT,">$trace_file") || die("Cannot Open $trace_file to write");
	print DAT $fileContent;	
	close(DAT);      
    }

    
    if($html eq "true")
    {
	return $htmlContent;
    }
    else
    {
	return $fileContent;
    }

 #   undef cluster;
 #   unde
}

sub Algorithm2
{
    my $searchInfo = shift;
    my $ref_searchStrings = shift;  
    my $numResults=shift;
    my $cutOff=shift;   
    my $bigramCutOff=shift;
    my $iterations=shift;
    my $scoreType=shift;  
    my $scoreCutOff=shift;
    my $trace_file=shift;
    my $html=shift;
    my %htmlresults=();
    my $numSearchTerms=0;


    my @searchTerms=@{$ref_searchStrings};

    my $numTerms=$#searchTerms+1;


    print "\n numberof terms $numTerms\n";

    %results=WebService::GoogleHack::getWordsInPage($searchInfo, $ref_searchStrings, $numResults,$cutOff,0,$numTerms,$bigramCutOff,$trace_file);

    if(!defined($scoreCutOff))
    {
	$scoreCutOff=40;
    }


    print "\nScoreType is $scoreType, ScoreCutOff $scoreCutOff\n";

  

    my $htmlContent="";
    my $fileContent="";

    my $Relatedness=0;
    my $tempScore="";

    $htmlContent.="<TABLE><TR><TD> <B> Result Set 1 </B> </TD></TR>";
    $fileContent="\n Result Set 1 \n";

    while( ($Key, $Value) = each(%results) ){     
	$Relatedness="";
  	$tempScore=0;

	foreach my $term (@searchTerms)
	{
	    require WebService::GoogleHack::Rate;	print "\n $term, $Key";
	   # $Relatedness = WebService::GoogleHack::Rate::measureSemanticRelatedness($searchInfo,$term,$Key); 
	    if($scoreType == 1)
	    {
		print "\n In score 1";
		$Relatedness = WebService::GoogleHack::Rate::relatednessScore1($searchInfo,$term,$Key); 
	    }
	    elsif($scoreType == 2)
	    {
		$Relatedness = WebService::GoogleHack::Rate::relatednessScore2($searchInfo,$term,$Key); 
	    }
	    else
	    {
		$Relatedness = WebService::GoogleHack::Rate::relatednessScore3($searchInfo,$term,$Key); 
	    }

	    $tempScore+=$Relatedness;	 
	}

	$tempScore=$tempScore/$numTerms;

	if(($scoreType == 3) || ($scoreType == 3))
	{
	    $tempScore=abs($tempScore);
	}
	
	$tempScore=sprintf("%.2f",$tempScore);

	if($tempScore < $scoreCutOff)
	{
	    $cluster{"$Key"}=$results{"$Key"};
	    $htmlResults{"$Key"}=$tempScore;
	}
    }
    

    foreach my $key (sort  { $htmlResults{$a} <=> $htmlResults{$b} } (keys(%htmlResults))) {
	$htmlContent.="<TR><TD>$key : $htmlResults{$key}, </TD><TD>$cluster{$key} </TD></TR>";   	
	$fileContent.="\n $key : $htmlResults{$key}";   	
    }

    $htmlContent.="\n</TABLE>\n";
    $fileContent.="\n ";

    print "\n Got done with first round";

    for(my $i=1; $i < $iterations; $i++)
    {
	print "\n I am now in $i round";
	@searchStrings=();
	
    	foreach my $term (@searchTerms)
	{
	    push(@searchStrings, $term);
	}

	for my $word ( keys %cluster) {
	   
	 
	    if($cluster{"$word"} > 0)
	    {		
		print "\n key is $word";
		push(@searchStrings,$word);
		$numSearchTerms++;
	    }
	}


	%cluster=();
	%cluster=WebService::GoogleHack::getWordsInPage($this, \@searchStrings, $numResults,$cutOff,$i,$numTerms,$bigramCutOff,$trace_file);

	my $k=$i+1;
	$htmlContent.="\n<br><TABLE><TR><TD> <B> Result Set $k </B> </TD></TR>";
	$fileContent.="\n Result Set $k \n";
	
	$Relatedness="No Score";
	$tempScore=0;

	while( ($Key, $Value) = each(%cluster) ){
#jumbo     
	    $Relatedness="";
	    $tempScore=0;
	    
	    foreach my $term (@searchTerms)
	    {
		print "\n $term, $Key";
		#$Relatedness = measureSemanticRelatedness($searchInfo,$term,$Key);   
		if($scoreType == 1)
		{
		    $Relatedness = WebService::GoogleHack::Rate::relatednessScore1($searchInfo,$term,$Key); 
		}
		elsif($scoreType == 2)
		{
		    $Relatedness = WebService::GoogleHack::Rate::relatednessScore2($searchInfo,$term,$Key); 
		}
		else
		{
		    $Relatedness = WebService::GoogleHack::Rate::relatednessScore3($searchInfo,$term,$Key); 
		}
		
		$tempScore+=$Relatedness;	 		
		#$tempScore.=$Relatedness.",\n";
	    }

	    $tempScore=$tempScore/$numTerms;
	    $tempScore=abs($tempScore);
	    $tempScore=sprintf("%.2f",$tempScore);	
	    
	    $htmlContent.="\n<TR><TD>$Key:$tempScore, </TD><TD>$cluster{$Key}</TD></TR>";
	    $fileContent.="\n$Key";
	    $results{"$Key"}=$cluster{"$Key"}  if !exists $results{"$Key"};;

	}	

        $htmlContent.="\n\n</TABLE><BR><BR>";  
	$fileContent.="\n\n";
	
    }

    $htmlContent.=$global_url;  
    $fileContent.=$global_url;

    if($trace_file ne "")
    {
	open(DAT,">$trace_file") || die("Cannot Open $trace_file to write");
	print DAT $fileContent;	
	close(DAT);      
    }

    
    if($html eq "true")
    {
	return $htmlContent;
    }
    else
    {
	return $fileContent;
    }
}

sub predictWordSentiment
{
    my $this=shift;
    my $infile=shift;
    my $positive_inference=shift;
    my $negative_inference=shift;
    my $htmlFlag=shift;
    my $traceFile=shift;

    require WebService::GoogleHack::Rate;
    
    my $results=WebService::GoogleHack::Rate::predictWordSentiment($this,$infile,$positive_inference,$negative_inference,$htmlFlag,$traceFile);

    return $results;
}

sub predictPhraseSentiment
{   
    my $this=shift;
    my $infile=shift;
    my $positive_inference=shift;
    my $negative_inference=shift;
    my $htmlFlag=shift;
    my $traceFile=shift;

    require WebService::GoogleHack::Text;
    
    WebService::GoogleHack::Text::Boundary($this,$infile);    
    WebService::GoogleHack::Text::POSTagData($this);
        
    require WebService::GoogleHack::Rate;
    
    my $taggedInput=$this->{'basedir'}."Temp/temp.fr.tg";
    
    my $results=WebService::GoogleHack::Rate::predictPhraseSentiment($this,$taggedInput,$positive_inference,$negative_inference,$htmlFlag,$traceFile);
   
    return $results;
    
}

1;
    













