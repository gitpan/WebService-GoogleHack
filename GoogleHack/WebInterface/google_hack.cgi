!/usr/local/bin/perl -w

=head1 WebService::Google-Hack Web Interface

=head1 SYNOPSIS

The WebService::Google-Hack web interface provides an easy to use interface
for some of the features of WebService::Google-Hack.

=head1 DESCRIPTION

To install the interface please follow these steps:


1) Create a directory named ghack in your cgi-bin directory (Where all your cgi files reside). So it should be something like:

/webspace/cgi-bin/ghack

2) Next, copy the file named google_hack.cgi, which is given with the 
distribution of the google-hack package into your cgi-bin/ghack/ directory.

3) Open the google_hack.cgi file, and change the lib path to the path where 
WebService::GoogleHack has been installed on your machine.

use lib "/home/lib/perl5/site_perl/";

*Note:
The google_hack.cgi file is in the WebInterface directory of GoogleHack.
For eg: WebService/GoogleHack/WebInterface.

4) Now, in the google_hack.cgi  file (which is also given in the  WebInterface directory of GoogleHack),

Set the remotr_host, and remote_port variables to the correct values.

$remote_host = '';

$remote_port = '';

The remote host will be the IP address of the machine where the google_hack server will be running.
The remote port needs to be the same as the $localport variable in ghack_server.pl

You should now be able to use the web interface.

=head1 AUTHOR

Ted Pedersen, E<lt>tpederse@d.umn.eduE<gt> 

Pratheepan Raveendranathan, E<lt>rave0029@d.umn.eduE<gt> 

Jason Michelizzi, E<lt>mich0212@d.umn.eduE<gt>

Date 11/08/2004

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2003 by Pratheepan Raveendranathan, Ted Pedersen, Jason Michelizzi

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


use strict;

##########################################################
# Change to path                                         #
##########################################################

use lib "";


##########################################################
# Change to host ip address and port                     #
##########################################################
my $remote_host = '';
my $remote_port = '';

use CGI;
use Socket;

BEGIN {
    use CGI::Carp 'carpout';
    carpout(*STDOUT);
}

my $cgi = CGI->new;

# print the HTTP header
print $cgi->header;


my $action=$cgi->param ('action');
my $type=$cgi->param ('opt');
	
	   my $key = $cgi->param ('apikey');
	   
	   my $words;
	   my $frequency;
	   my $numPages;
	   my $numIterations;
	   my $wordS1;
	   my $wordS2;
	   my $review;

	   
	   if(!defined($action))
	   {
	       $action="first";
	   }

if($action eq "first")
{
    showPageStart();
}


if($action eq "Submit")
{
    
    if($type eq "wordcluster")
    {
	WordClusters();
    }
    elsif($type eq "pmi")
    {
	PMI();
    }
    elsif($type eq "review")
    {
	Review();
    }
    
}

if($action eq "Generate")
{
    
    $words = $cgi->param ('words');;
    $frequency = $cgi->param ('cutoff');;
    $numPages = $cgi->param ('numres');;
    $numIterations=$cgi->param ('numiters');;;
    generateWordCluster();
    
}

if($action eq "PMIMeasure")
{
    
    
    $wordS1 = $cgi->param ('searchString1');
    $wordS2 = $cgi->param ('searchString2');
    generatePMI();
#$numIterations = $cgi->param ('apikey');;
    
}

showPageEnd ();
exit;


sub showPageStart
{
    print <<"EOINTRO";
<html>
<head>
  <title>Google-Hack</title>
</head>
<body>

<B><p><font face="Arial" size="5" >p r o j e c t  &nbsp; </font> </B>
</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; <font size="6">&nbsp;</font><font size="4"><b>
</b>&nbsp;</font><font size="4" > <font face="Arial">g o o g l e
&nbsp;&nbsp; - h a c k&nbsp;&nbsp;</font></font></p>

<hr></hr>

<form action="google_hack.cgi" method="get" id="queryform" onreset="formReset()">
 <h1> Use GoogleHack </h1> <br>
   <label for="word1in" class="leftlabel">Which feature would you like to use?</label>

   <select name="opt">
        <option value="wordcluster"> Word Cluster</option>
        <option value="pmi">PMI Measure</option>
            </select><br />

<br><br>
  <label><b>Google API Key:</b></label>
  <input type="text" name="apikey" value="" > &nbsp;
<br><br>
(Please enter your Google API license key here, if you dont have one you can get it @  <a href="http://www.google.com/apis/"> http://www.google.com/apis</a>. <br>Or to proceed with default google-hack developer\'s key, select the feature that you would like to use and click on  submit.)

 <br>

  <br> 
      <input name="action" type="submit" value="Submit" />  <br>   <br> 
<a name='Developers'>
<font color="black">
<h3 align="left"><b>Developers</b></h3>

<a href="http://www.d.umn.edu/~tpederse">

Ted Pedersen
</a>, &nbsp;&nbsp;
<a href="http://www.d.umn.edu/~rave0029/research">

Pratheepan Raveendranathan

</a>

EOINTRO
}


sub WordClusters
{
print <<"Word_Clusters";
<B><p><font face="Arial" size="5" >p r o j e c t  &nbsp; </font> </B>
</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; <font size="6">&nbsp;</font><font size="4"><b>
</b>&nbsp;</font><font size="4" > <font face="Arial">g o o g l e
&nbsp;&nbsp; - h a c k&nbsp;&nbsp;</font></font></p>

<hr></hr>
<form action="google_hack.cgi" method="get" id="queryform" onreset="formReset()">
<h1> Word Clusters</h1>

<H2><b> Parameters</b> </H2>

<label><b>Top "N" web Pages:</b></label>
Word_Clusters

	print "<select name=\"numres\">\n";

for(my $i=10; $i <= 30; $i=$i+10)
{

       	    print "<option value=\"$i\">";
	    print $i;
	    print "</option>\n";
	
}
	print "</select> (This will be the number of web pages to parse, Defaults to 10, Maximum 50 )<br />\n";

print <<"Word_Clusters1";

<br><br>
<label><b>Frequency Cutoff &nbsp;&nbsp;&nbsp;: </b></label>

Word_Clusters1

	print "<select name=\"cutoff\">\n";

for(my $i=1; $i <= 20; $i++)
{
if($i==5)
{
  print "<option select value=\"$i\">";
     print $i;
     print "</option>\n ";
}
 else
{
     print "<option value=\"$i\">";
     print $i;
     print "</option>\n";
}
	
}
	print "</select> (Words with frequency less than given would not be considered, Max 20)<br />\n";

print <<"Word_Clusters2";
<br><br><label><b>No of Iterations&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b></label>
Word_Clusters2
	print "<select name=\"numiters\">\n";

for(my $i=1; $i <= 2; $i++)
{

       	    print "<option value=\"$i\">";
	    print $i;
	    print "</option>\n";
	
}
	print "</select> (This will be the number of iterations)<br />\n";

    print <<"Word_Clusters3";
<br>  <label><b>Words&nbsp;&nbsp;:</b></label>
<br>
<textarea name="words" value="" cols="80" rows="8"> 


</textarea>
<br>
(New Line/Space Delimited World List)<br><br> 
      <input name="action" type="submit" value="Generate" />


      <input name="action" type="submit" value="Back" />

 </form> 
Word_Clusters3

}

sub generateWordCluster
{
 socket (Server, PF_INET, SOCK_STREAM, getprotobyname ('tcp'));

    my $internet_addr = inet_aton ($remote_host)
	or die "Could not convert $remote_host to an Internet addr: $!\n";
    my $paddr = sockaddr_in ($remote_port, $internet_addr);

    unless (connect (Server, $paddr)) {
	print "<p>Cannot connect to server $remote_host:$remote_port</p>\n";
	close Server;
    }

 select ((select (Server), $|=1)[0]);
 
 $words=~s/\s+/:/g;
 print Server "c\t$words\t$numPages\t$frequency\t$numIterations\t\015\012\015\012";
 print <<"temp";
<B><p><font face="Arial" size="5" >p r o j e c t  &nbsp; </font> </B>
</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; <font size="6">&nbsp;</font><font size="4"><b>
</b>&nbsp;</font><font size="4" > <font face="Arial">g o o g l e
&nbsp;&nbsp; - h a c k&nbsp;&nbsp;</font></font></p>

<hr></hr>
temp

 print "\n<B>Google Hack Word Cluster Results for </B>";

            my @terms=();
	    my @temp= split(/:/, $words);
	    
	    foreach my $word (@temp)
	    {
	       if($word ne "")
	       {
		   print "<br>$word";
	       }
	   
	    }

 print "<br><br> Frequency Cutoff: $frequency <br># of Web Pages: $numPages <br># of Iterations: $numIterations<br>" ;

 while (my $line = <Server>) {
     last if $line eq "\015\012";
     print "<br>$line";
     
 }
 
 local $ENV{PATH} = "/usr/local/bin:/usr/bin:/bin:/ghack";
 my $t_osinfo = `uname -a` || "Couldn't get system information: $!";
 # $t_osinfo is tainted.  Use it in a pattern match and $1 will
 # be untainted.
 $t_osinfo =~ /(.*)/;
#    print "<p>HTTP server: $ENV{HTTP_HOST} ($1)</p>\n";
#    print "<p>Google server: $remote_host</p>\n";
 print "<hr />";
 close Server;
}


sub PMI
{
print <<"PMI";
<B><p><font face="Arial" size="5" >p r o j e c t  &nbsp; </font> </B>
</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; <font size="6">&nbsp;</font><font size="4"><b>
</b>&nbsp;</font><font size="4" > <font face="Arial">g o o g l e
&nbsp;&nbsp; - h a c k&nbsp;&nbsp;</font></font></p>

<hr></hr>
<form action="google_hack.cgi" method="get"  onreset="formReset()">
<h2> PMI Measure </h2>
(This feature allows you to find the Pointwise Mutual Information measure between two terms)<br><br>
  <label><b>Search String 1:</b></label>
<input type="text" name="searchString1" value="" > (Enter a term like dog) 
<br><br>
<label><b>Search String 2:</b></label>
<input type="text" name="searchString2" value=""> (Enter a term like cat)<br><br>

      <input name="action" type="submit" value="PMIMeasure" />
      <input name="action" type="submit" value="Back" />

 </form> 
PMI

}


sub generatePMI
{
 socket (Server, PF_INET, SOCK_STREAM, getprotobyname ('tcp'));

    my $internet_addr = inet_aton ($remote_host)
	or die "Could not convert $remote_host to an Internet addr: $!\n";
    my $paddr = sockaddr_in ($remote_port, $internet_addr);

    unless (connect (Server, $paddr)) {
	print "<p>Cannot connect to server $remote_host:$remote_port</p>\n";
	close Server;
    }

 select ((select (Server), $|=1)[0]);
 
 $wordS1=~s/\s+//g;
 $wordS2=~s/\s+//g;

 print Server "p\t$wordS1\t$wordS2\015\012\015\012";
 print <<"temp";
<B><p><font face="Arial" size="5" >p r o j e c t  &nbsp; </font> </B>
</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; <font size="6">&nbsp;</font><font size="4"><b>
</b>&nbsp;</font><font size="4" > <font face="Arial">g o o g l e
&nbsp;&nbsp; - h a c k&nbsp;&nbsp;</font></font></p>

<hr></hr>
temp

 print "\n<B>Google Hack PMI Measure for </B>";

 print "<br>$wordS1 AND $wordS2";

 print "<br>PMI Measure: ";

 while (my $line = <Server>) {
     last if $line eq "\015\012";
     print "<br>$line";
     
 }
 
 local $ENV{PATH} = "/usr/local/bin:/usr/bin:/bin:/ghack";
 my $t_osinfo = `uname -a` || "Couldn't get system information: $!";
 $t_osinfo =~ /(.*)/;
 print "<hr />";
 close Server;
}



sub showPageEnd
{
    print <<'ENDOFPAGE';

</body>
</html>
ENDOFPAGE
}

__END__

