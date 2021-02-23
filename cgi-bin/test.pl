#!/usr/bin/perl -T

use strict;
use warnings;
use CGI qw( :all -utf8 );

print header( -type => 'text/html', -charset => 'utf-8' ) .
	start_html(-style => {'src'=>'../style.css'}) ;
print div({-class=>"header"},h1("Saulės Gėlytės rankdarbių krautuvėlė"));

my $name;
my $email;
my @diys;
my $time;
my $from;
#parametru validacija:
if (param('name')=~/^[A-z ]+$/){
	$name=param('name');
}else{
	print p( 'Klaida ivedant varda');
	print a({-href=>"../registracija.html", -class=>"btn"},"Atgal");
	print div({-class=>"footer"},p("Tinklalapis kuriamas mokymosi tikslais"));
	end_html();
	exit;
}
if (param('email')=~/^[\w-\.]+@[\w-]+\.[a-z]{2,4}$/){
	$email=param('email');
}else{
	print p('Klaida ivedant el.pasta.');
	print a({-href=>"../registracija.html", -class=>"btn"},"Atgal");
	print div({-class=>"footer"},p("Tinklalapis kuriamas mokymosi tikslais"));
	end_html();
	exit;
}
foreach my $diy (param()){
	if ($diy=~/^diy[0-9]+$/){
		if (param($diy)=~/^[A-z]+$/){
			push(@diys, param($diy))
		}elsif (param($diy)!=""){
			print p('Klaida zymint rankdarbius');
			print a({-href=>"../registracija.html", -class=>"btn"},"Atgal");
			print div({-class=>"footer"},p("Tinklalapis kuriamas mokymosi tikslais"));
			end_html();
			exit;
		}
	} 
}
if (param('consult_time')=~/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/){
	$time=param('consult_time');
}elsif (param('consult_time')!=""){
	print p('Klaida pasirenkant laika');
	print a({-href=>"../registracija.html", -class=>"btn"},"Atgal");
	print div({-class=>"footer"},p("Tinklalapis kuriamas mokymosi tikslais"));
	end_html();
	exit;
}
if (param('came_from')=~/^[A-z]+$/){
	$from=param('came_from');
}elsif(param('came_from')!=""){
	print p('Klaida atsakant is kur suzinojote apie tinklalapi');
	print a({-href=>"../registracija.html", -class=>"btn"},"Atgal");
	print div({-class=>"footer"},p("Tinklalapis kuriamas mokymosi tikslais"));
	end_html();
	exit;
}
#tikrinimas ar data dar neuzimta:
open (my $inp, "../data/reservations.csv");
while(<$inp>){
	$_=~/,([0-9-]+)$/;
	if ($time eq $1 and $time!=""){
		#print p("\n $time   $1");
		print p('Deja, bet si diena jau uzimta, rinkites kita.');
		print a({-href=>"../registracija.html", -class=>"btn"},"Atgal");
		print div({-class=>"footer"},p("Tinklalapis kuriamas mokymosi tikslais"));
		end_html();
		close $inp;
		exit;
	}
}
close $inp;
#Sekmingo rezultato isvedimas ir naujos datos irasymas i rezervaciju faila:
print p('Registracija pavyko');
print a({-href=>"../registracija.html", -class=>"btn"},"Atgal");
#print p("$name \n $email \n @diys \n $time \n $from");
open (OUTF, '>>', "../data/reservations.csv") or die "Server error";
print OUTF ($name . "," . $email . ",");
print OUTF (@diys); 
print OUTF ("," . $from . "," . $time . "\n");
close OUTF;

print div({-class=>"footer"},p("Tinklalapis kuriamas mokymosi tikslais"));
print end_html() . "\n";
