#!/usr/local/bin/perl 
=head1 GoogleHack web interface server

=head1 SYNOPSIS

ghack_server.pl acts as a server to which the web interface connects to for all user queries.
The server then retrieves the results of the queries and sends it back to the web interface.

=head1 DESCRIPTION

To install the server please follow these steps:

1) Change the lib path to the path where WebService::GoogleHack has been installed on your machine.
 
use lib "/home/lib/perl5/site_perl/";

2) Change the following variables accordingly:

$BASEDIR = '/webspace/cgi-bin/ghack'; 

$localport = 32983;

$lock_file = "$BASEDIR/ghack_server.lock";

$error_log = "$BASEDIR/error.log";

Basedir should be the path to the cgi-bin directory in which google_hack.cgi 
resides.

The localport should be a number above 1024, and less than around 66,000. Make
 sure that localport number is the same on both the client and server side.

The lockfile & error_log variables will remain the same. 

3)If your ghack server is running behind a firewall, you will need to
edit the file /etc/sysconfig/iptables to allow clients to connect to the machine through the port you had given.  There is a line that looks like this:

-A RH-Firewall-1-INPUT -p tcp --dport XXXXX -j ACCEPT

Where XXXXX is the port that your client will be connecting to (the value of $localport in ghack_server.pl).

Now start the server by running the ghack_server.pl as you would run a 
regular perl file.

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

use lib "/home/vold/47/rave0029/lib/perl5/site_perl/";
use strict;

###########################################################
# Please make sure to change the value of these variables #
# according to documentation                              # 
###########################################################

my $BASEDIR = '/home/vold/47/rave0029/www/cgi-bin/ghack';
my $localport = 32983;
my $lock_file = "$BASEDIR/ghack_server.lock";
my $error_log = "$BASEDIR/error.log";

my $lockfh;
{
    if (-e $lock_file) {
	die "Lock file `$lock_file' already exists.  Make sure that another\n",
	    "instance of $0 isn't running, then delete the lock file.\n";
    }
    open ($lockfh, '>', $lock_file)
      or die "Cannot open lock file `$lock_file' for writing: $!";
    print $lockfh $$;
    close $lockfh or die "Cannot close lock file `lock_file': $!";
}
END {
    if (open FH, '<', $lock_file) {
	my $pid = <FH>;
	close FH;
	unlink $lock_file if $pid eq $$;
    }
}

# prototypes:
sub getlock ();
sub releaselock ();

use sigtrap handler => \&bailout, 'normal-signals';
use IO::Socket::INET;

use SOAP::Lite;
use WebService::GoogleHack;

# reset (untaint) the PATH
$ENV{PATH} = '/bin:/usr/bin:/usr/local/bin';

# automatically reap child processes
$SIG{CHLD} = 'IGNORE';

# re-direct STDERR from wherever it is now to a log file
close STDERR;
open (STDERR, '>', $error_log) or die "Could not re-open STDERR";
chmod 0664, $error_log;


# The is the socket we listen to
my $socket = IO::Socket::INET->new (LocalPort => $localport,
				    Listen => SOMAXCONN,
				    Reuse => 1,
				    Type => SOCK_STREAM
				   ) or die "Could not be a server: $!";

print "SERVER started on port $localport "; 

my $search = new WebService::GoogleHack;

############################################################
# Change to you config file path                           #
############################################################

$search->initConfig("");

ACCEPT:
while (my $client = $socket->accept) {
    my $childpid;
    if ($childpid = fork) {
	# we're the parent here, so we just go wait for the next request
	next ACCEPT;
    }

    defined $childpid or die "Could not fork: $!";

    # here we're the child, so we actually handle the request
    my @requests;
    while (my $request = <$client>) {
	last if $request eq "\015\012";
	push @requests, $request;
    }

    foreach my $i (0..$#requests) {
        my $request = $requests[$i];
	my $rnum = $i + 1;
	$request =~ m/^(\w)\b/;
	my $type = $1 || 'UNDEFINED';
	my $query=$request;

#user wants word cluster
	if ($type eq 'c')
	{		   
	    my ($dummy,$searchString,$numResults,$cutOffs,$numIterations)= split(/\t/, $query);
	    my @terms=();
	    
	    my @temp= split(/:/, $searchString);
	    
	    foreach my $word (@temp)
	    {
	       if($word ne "")
	       {
		   push(@terms,$word);
	       }
	   
	    }
	  
 my $results=$search->wordClusterInPage(\@terms,$numResults,$cutOffs,$numIterations,"results.txt","true");
	    
	    print $client "$results";
	    print $client "\015\012";
	}
#if user wants to measure semantic relatedness/ PMI score
	elsif ($type eq 'p')
	{		   
	    my ($dummy,$searchString1,$searchString2)= split(/\t/, $query);
	    	  
	    my $results=$search->measureSemanticRelatedness($searchString1,$searchString2);
	 

	    print $client "$results";
	    print $client "\015\012";
	}
	else {
	    print $client "! Bad request type `$type'\015\012";
	}
    }

    # Terminate ALL messages with CRLF (\015\012).  Do NOT use
    # \r\n (the meaning of \r and \n varies on different platforms).
    print $client "\015\012";

 EXIT_CHILD:
    $client->close;
    $socket->close;

    # don't let the child accept:
    exit;
}

$socket->close;
exit;

# A signal handler, good for most normal signals (esp. INT).  Mostly we just
# want to close the socket we're listening to and delete the lock file.
sub bailout
{
    my $sig = shift;
    $sig = defined $sig ? $sig : "?UNKNOWN?";
    $socket->close if defined $socket;
    print STDERR "Bailing out (SIG$sig)\n";
    releaselock;
    unlink $lock_file;
    exit 1;
}


use Fcntl qw/:flock/;

# gets a lock on $lockfh.  The return value is that of flock.
sub getlock ()
{
    open $lockfh, '>>', $lock_file
	or die "Cannot open lock file $lock_file: $!";
    flock $lockfh, LOCK_EX;
}

# releases a lock on $lockfh.  The return value is that of flock.
sub releaselock ()
{
    flock $lockfh, LOCK_UN;
    close $lockfh;
}

__END__
























