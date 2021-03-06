﻿package Eyebot::Scan;

use Moose;
use Eyebot::Factory;
use Eyebot::Functions;

our @pluginsD = ();
our @pluginsS = ();
our $func = Eyebot::Functions->new();

sub loadPluginsDynamic(){
	my $self = shift;
	
	if(!scalar(@pluginsD)){
		opendir(my $dh, "./Plugins/Tests/Dynamic/") || die "$!\n";
		my @plug = sort grep {/\.pm$/} readdir($dh);
		closedir $dh;
		my $x=0;
		foreach my $d (@plug){
			$d =~ s/\.pm//g;
			push(@pluginsD, Eyebot::Factory->create($d, "Tests::Dynamic"));
			$func->write("| Plugin name: $pluginsD[$x]->{name} v.$pluginsD[$x]->{version} Loaded.") if($pluginsD[$x]->status() == 1);
			$x++;
		}
	}
}

	
sub runDynamic(){
	my ($self, @urls) = @_;
	# plugins start
	foreach my $p (@pluginsD){
		$p->execute(@urls) if($p->status() == 1);
		$p->clean()  if($p->status() == 1);
	}
	# plugins end
}

	
sub loadPluginsStatic(){
	my $self = shift;

	if(!scalar(@pluginsS)){
		opendir(my $dh, "./Plugins/Tests/Static/") || die "$!\n";
		my @plug = sort grep {/\.pm$/} readdir($dh);
		closedir $dh;
		my $x =0;
		foreach my $d (@plug){
			$d =~ s/\.pm//g;
			push(@pluginsS, Eyebot::Factory->create($d, "Tests::Static"));
			$func->write("| Plugin name: $pluginsS[$x]->{name} v.$pluginsS[$x]->{version} Loaded.") if($pluginsS[$x]->status() == 1);
			$x++;
		}
	}
}
	

sub runStatic(){
	my ($self, $url) = @_;
	# plugins start
	foreach my $p (@pluginsS){
		$p->execute($url) if($p->status() == 1);
		$p->clean()  if($p->status() == 1);
	}
	# plugins end
}

1;
