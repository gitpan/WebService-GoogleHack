#!/usr/local/bin/perl 

=head1 NAME

WebService::GoogleHack::Rate - This module implements a simple relatedness measure and semantic orientation related type functions.

=head1 SYNOPSIS

#create an object of type Rate
use WebService::GoogleHack::Rate;

my $rate = WebService::GoogleHack::Rate->new(); 

$results=$rate->measureSemanticRelatedness("string 1", "string 2");

#The PMI measure is stored in the variable $results, and it can also 
#be accessed as $rate->{'PMI'};

$results=$rate->predictSemanticOrientation("file", "positive", "negative","trace file");

#The resutls can be accessed through 
#$results->{'prediction'} 
#$results->{'PMI Measure'}
#$rate->{'prediction'} &
#$rate->{'PMI Measure'}


=head1 DESCRIPTION

WebService::GoogleHack::Rate - This package uses Google to do some basic 
natural language processing. For example, given two words, say "knife" and 
"cut", the module has the ability to retrieve a semantic relatedness measure,
 commonly known as the PMI (Pointwise mututal information) measure. The 
larger the measure the more related the words are.
The package can also predict the semantic orientation of a given paragraph of 
english text. A positive measure means that the paragraph has a positive 
meaning, and negative measure means the opposite.

=head1 PACKAGE METHODS

=head2 __PACKAGE__->new()

Purpose: This function creates an object of type Rate and returns a blessed reference.

=head2 __PACKAGE__->init(Params Given Below)

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

=head2 __PACKAGE__->measureSemanticRelatedness(searchString1,searchString2)

Purpose: this is function is used to measure the relatedness between two words.

Valid arguments are :

=over 4

=item *

B<searchString1>

I<string>. The search string which can be a phrase or word

=item *

B<searchString2>

I<string>.   The search string which can be a phrase or word

=back

Returns: Returns the object containing the PMI measure.

=head2 __PACKAGE__->predictSemanticOrientation(review_file,positive_inference,negative_inference,trace_file)

Purpose: this function tries to predict the semantic orientation of a paragraph of text.


Valid arguments are :

=over 4

=item *

B<review_file> 

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


package WebService::GoogleHack::Rate;

our $VERSION = '0.05';

use SOAP::Lite;

sub new
{
my $this = {};

$this-> {'Key'} = undef;
$this-> {'File_Location'} = undef;
$this->{'releated'}=undef;
$this->{'PMIMeasure'}=undef;
$this->{'prediction'}=undef;
$this-> {'adjectives_list'} = undef;
$this-> {'adverbs_list'} = undef;
$this-> {'verbs_list'} = undef;
$this-> {'nouns_list'} = undef;
this-> {'stop_list'} = undef;

 bless $this;
 
return $this;
} 

sub init
 {
    my $this = shift;    
    $this->{'Key'} = shift;
    $this->{'File_Location'} = shift;
    
}

sub measureSemanticRelatedness
{
    my $searchInfo = shift;
    my $searchString=shift;
 #   my $searchString2=shift; 
    my $context=shift;
    $temp_string1="\"".$searchString." AND ".$context."\"";    
  #  $temp_string2=$searchString2." AND ".$context; 
   
    require WebService::GoogleHack::Search;
    
    $results1=WebService::GoogleHack::Search::searchPhrase($searchInfo, $searchString);
   $result_counte=$results1->{NumResults}; 

    $results3=WebService::GoogleHack::Search::searchPhrase($searchInfo, $temp_string1);

 $result_count1=$results3->{NumResults};

    $results5=WebService::GoogleHack::Search::searchPhrase($searchInfo, $context);

$result_counti=$results5->{NumResults};
       
    $pmi=log(($result_count1) / ($result_counte * $result_counti));
    $pmi=sprintf("%.4f",$pmi);
    #print "here rate pmi $pmi $result_count1,$result_counte,$result_counti";
    return $pmi;

} 
 

sub predictSemanticOrientation
{
    #$this=shift;    
    my  $searchInfo = shift;
    my  $review_file=shift;
    my $positive_inference=shift;
    my $negative_inference=shift;
    my $trace_file=shift;
    my $flag;
 
    print "\n The review file is $review_file";
    print "\n";

   require WebService::GoogleHack::Text;

    %nouns_list=WebService::GoogleHack::Text::getWords("$searchInfo->{'nouns_list'}");
    %verbs_list=WebService::GoogleHack::Text::getWords("$searchInfo->{'verbs_list'}");
  %adjectives_list=WebService::GoogleHack::Text::getWords("$searchInfo->{'adjectives_list'}");
   %adverbs_list=WebService::GoogleHack::Text::getWords("$searchInfo->{'adverbs_list'}");

if($flag eq "false")
{
    @semantic_strings=WebService::GoogleHack::Text::getSentences
($review_file,3,"false");
}
else
{    
@semantic_strings=WebService::GoogleHack::Text::getSentences($review_file,3,"true");
}
 
    $count=0;
    $temp_words=();
    $strings_count=@semantic_strings;
    $so_count=0;
    $so_strings=();
    
    
    $check_string=();


    
    print "\n\n Making Phrases ";
  
    print "\n Number of Semantic Strings ";
    print "$strings_count \n";

	while($count < $strings_count)
	{
	    @temp_words = split(/\s+/, "$semantic_strings[$count]");
	    $t= $#temp_words;

	 
	    
#	    print "$count";
	    
# JJ & NN/NN & anything
	    
	    if ((exists $adjectives_list{"$temp_words[1]"}) && (exists $nouns_list{"$temp_words[2]"}) )
	    {
		$temp=$temp_words[1]." ".$temp_words[2];
		
		if (!exists $check_string{"$temp"})
		{
		    $check_string{"$temp"}=1;
		    $so_strings[$so_count]=$temp_words[1]." ".$temp_words[2];
		    
		    # print "\n Case1 ";   
		    # print $so_strings[$so_count];
		    
		    $so_count++;
		}
		
	    }
	    

	    
# RB & JJ ~NN/NNS
	    
	    if ((exists $adverbs_list{"$temp_words[1]"}) && (exists $adjectives_list{"$temp_words[2]"}) && (!exists $nouns_list{"$temp_words[3]"}))
	    {
		
		$temp=$temp_words[1]." ".$temp_words[2];
		
		if (!exists $check_string{"$temp"})
		{
		    $check_string{"$temp"}=1;
		    $so_strings[$so_count]=$temp_words[1]." ".$temp_words[2];
		    #print "\n  Case2 ";   
		    #print $so_strings[$so_count];
		    
		    $so_count++;
		    
		}
		
	    }
	    
	    
#JJ & JJ ~NN/NNS
	    
	    if ((exists $adjectives_list{"$temp_words[1]"}) && (exists $adjectives_list{"$temp_words[2]"}) && (!exists $nouns_list{"$temp_words[3]"}))
	    {
		
		$temp=$temp_words[1]." ".$temp_words[2];
		
		if (!exists $check_string{"$temp"})
		{
		    $check_string{"$temp"}=1;
		    $so_strings[$so_count]=$temp_words[1]." ".$temp_words[2];
		    #print "\n  Case3 ";   
		    #print $so_strings[$so_count];
		    
		    $so_count++;
		    
		}
		
	    }
	    
	    
#NN/NNS JJ ~NN/NNS
	    
	    if ((exists $nouns_list{"$temp_words[1]"}) && (exists $adjectives_list{"$temp_words[2]"}) && (!exists $nouns_list{"$temp_words[3]"}))
	    {
		
		$temp=$temp_words[1]." ".$temp_words[2];
		
		if (!exists $check_string{"$temp"})
		{
		    $check_string{"$temp"}=1;
		    $so_strings[$so_count]=$temp_words[1]." ".$temp_words[2];
		    #print "\n  Case4 ";   
		    #print $so_strings[$so_count];
		    
		    $so_count++;
		    
		}
		
	    }
	    
# RB & VB & anything
	    
	    if ((exists $adverbs_list{"$temp_words[1]"}) && (exists $verbs_list{"$temp_words[2]"}))
	    {
		$temp=$temp_words[1]." ".$temp_words[2];
		
		if (!exists $check_string{"$temp"})
		{
		    $check_string{"$temp"}=1;
		    $so_strings[$so_count]=$temp_words[1]." ".$temp_words[2];
				    $so_count++;
		    
		}
		
	    }

	    $count++;
	    
}

    require WebService::GoogleHack::Search;

    $rs_neg=0;
    $rs_pos=0;

    $results_positive=WebService::GoogleHack::Search::searchPhrase($searchInfo, $positive_inference,10);

    $rs_pos=$results_positive->{NumResults};

    $results_negative=WebService::GoogleHack::Search::searchPhrase($searchInfo, $negative_inference,10);

    $rs_neg=$results_negative->{NumResults};

    $k=0;
    $write_file="";
    
    
    if($trace_file)
    {
	$write_file=" Querying Google \n\n"."Count of $positive_inference: ". $rs_pos . "\n Count of $negative_inference: ".$rs_neg;
    }
    
  #  print "\n so count is $so_count";
    my $rs_query1=0;
    my $rs_query2=0;
   
    $write_file.="\n Phrases Extracted\n\n";

while($k< $so_count)
{
    $write_file.="\n".$so_strings[$k]." AND $positive_inference"."\n";
    $write_file.="\n".$so_strings[$k]." AND $negative_inference"."\n";
    $k++;
}

$k=0;

while($k< $so_count)
{


$query1= $so_strings[$k]." AND $positive_inference";

$query2= $so_strings[$k]." AND $negative_inference";



$results_query1=WebService::GoogleHack::Search::searchPhrase($searchInfo,$query1);

$rs_query1=$results_query1->{NumResults};

$results_query2=WebService::GoogleHack::Search::searchPhrase($searchInfo,$query2);
$rs_query2=$results_query2->{NumResults};

if($trace_file)
{
    $write_file=$write_file. "\n===============================================\n";
    $write_file=$write_file."\n"."\nNumber of Results \"$query1\" is  ".$rs_query1."\n\n";
}

$num=  $rs_query1 * $rs_neg;
$den=  $rs_query2- * $rs_pos +0.01;

if($num == 0)
{
   # print "here";
    $semantic_orientation[$k]=0;
}
else
{
    $semantic_orientation[$k]= log ($num/$den);
}

if($trace_file)
{
    $write_file=$write_file."\n"."\nNumber of Results \"$query2\"s  ".$rs_query2."\n"."\n\nThe semantic orientation is $semantic_orientation[$k]\n\n";
}

$k++;

}

$i=0;

$average_so=0;

while($i < $k)
{
    $average_so=$average_so + $semantic_orientation[$i];
    $i++;
}

$average_so=$average_so/($k+1);

$this->{'PMIMeasure'}=$average_so;

if($average_so >= 0)
{
$this->{'prediction'}=1;
}
else
{
$this->{'prediction'}=0;
}

$write_file=$write_file."\n\n Final SO Measure is $average_so\n\n";

open(DAT,">$trace_file") || die("Cannot Open $trace_file to write");

print DAT $write_file;

close(DAT);

return $write_file;

#return $this;
}


 # remember to end the module with this
1 ;
 




