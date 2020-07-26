package Plugins::Tests::Static::checkPUT;

use Eyebot::Http;
use Eyebot::Functions;

	my $func = Eyebot::Functions->new();
	my $http = Eyebot::Http->new();

sub new {
    my $class    = shift;
    my $self     = {name => "PUT method test", version => 1.1};
	our $enabled  = 1;
    return bless $self, $class;
}


sub execute(){
	my ($self,$url) = @_;

	$func->write("|"." "x99);
	$func->write("|"." "x99);
	$func->write("| Test PUT mothod:");
    &CheckPut($url);
	}

	
sub CheckPut(){
	my $url = shift;
	my $h = Eyebot::Http->new();
	my $resp = $h->PUT($url."Eyebot.txt", "Eyebot123 Eyebot123");
	$resp = $h->GET($url."Eyebot.txt");
	if($resp =~/Eyebot123/){
		$vulnerable++;
		$func->write("="x100);
		$func->write("| PUT method is enabled");
		$func->write("| [+] Vul[$vulnerable]: $url/Eyebot.txt");
		$func->write("="x100);
	}
}

sub status(){
 my $self = shift;
 return $enabled;
}



sub clean(){
 my $self = shift;
}

1;
