#!/usr/bin/perl -w

# Starting point for COMP[29]041 assignment 1
# http://www.cse.unsw.edu.au/~cs2041/assignments/pypl
# written by Daisong Yu (z5098539) September 2017

$prev_tab_count = 0;
$cur_tab_count = 0;
$front_brackets = 0;
$back_brackets = 0;

while ($line = <>) {

	chomp $line;

	if ($line =~ /^#!/ && $. == 1) {

		print "#!/usr/bin/perl -w\n";

	} elsif ($line =~ /^\s*(#|$)/) {

        # Blank & comment lines can be passed unchanged

		print "$line\n";

	} elsif($line =~ /import sys/) {

		print "\n";

	} elsif($line =~ /sys.stdin.readline/) { 

		$prev_tab_count = $cur_tab_count; #count how many tab or space in front of the line; if the current number of 
		$line =~ /^([\t\s]*)/;            #space or tab less than previou's then there should be a } before the current line
		$cur_tab_count = length($1);      #this part of code is also used in rest of program many times
		$j = 0;

		if($cur_tab_count < $prev_tab_count){

			while($j < $prev_tab_count - $cur_tab_count){

				$i = 0;

				while($i < $cur_tab_count){

					print " ";
					$i+=1;

				}

				print "}\n";
				$j+=4;
				$i+=4;
				$back_brackets+=1;
			}
		}
 
		$line =~ s/([a-zA-Z]+)/\$$1/g;
		$line =~ s/= .*/= <STDIN>\;/;
		print "$line\n";

	} elsif($line =~ /^\s*break$/){

		$prev_tab_count = $cur_tab_count;
		$line =~ /^([\t\s]*)/;
		$cur_tab_count = length($1);
		$j = 0;

		if($cur_tab_count < $prev_tab_count){

			while($j < $prev_tab_count - $cur_tab_count){

				$i = 0;

				while($i < $cur_tab_count){

					print " ";
					$i+=1;
				}

				print "}\n";
				$j+=4;
				$i+=4;
				$back_brackets+=1;
			}
		}	

		$line =~ s/break/last\;/;
		print "$line\n";

	} elsif($line =~ /^\s*continue$/) {

		$prev_tab_count = $cur_tab_count;
		$line =~ /^([\t\s]*)/;
		$cur_tab_count = length($1);
		$j = 0;

		if($cur_tab_count < $prev_tab_count){

			while($j < $prev_tab_count - $cur_tab_count){

				$i = 0;
				while($i < $cur_tab_count){

					print " ";
					$i+=1;
				}
				print "}\n";
				$j+=4;
				$i+=4;
				$back_brackets+=1
			}
		}
	
		$line =~ s/continue/next/;
		print "$line\n";


	}elsif($line =~ /^(\s*)print *\((.*) ?, ?(.*)\)/){ #handle print has comma, if there is comma in the print(,) then enter this conditon 
		#print "enter print with comma\n";
		$prev_tab_count = $cur_tab_count;
		$line =~ /^([\t\s]*)/;
		$cur_tab_count = length($1);
		$j = 0;

		if($cur_tab_count < $prev_tab_count){

			while($j < $prev_tab_count - $cur_tab_count){

				$i = 0;

				while($i < $cur_tab_count){
					print " ";
					$i+=1;
				}

				print "}\n";
				$j+=4;
				$i+=4;
				$back_brackets+=1;
			}
		}	
	
		$line =~ /^(\s*)print *\((.*)\)/;
		$space = $1;
		$comma_part = $2;
		$end_flag = 0;
		@diff_part = split(',', $comma_part); #take the part inside the print function and split it by ,

		foreach $diff_part (@diff_part){ #then depends on different regex when make differnt output

			if($diff_part =~ /^\s*\"(.*)\"/){

				print "$space";
				print "print \"$1\"\;\n";

			}elsif ($diff_part =~ /^\s*([a-zA-Z]+)\s*$/){

				print "$space";
				print "print \"\$$1\"\;\n";

			}elsif($diff_part =~ /^\s*end *= *\'\'/){

				$end_flag = 1;

			}elsif($diff_part =~ /(.*)\[(.*)\]/){

				#print "$space";
				#print "print \$$1\[\$$2\]\;\n";
				$diff_part =~ s/([a-zA-Z]+)/\$$1/g;
				print "$space";
				print "print $diff_part\;\n";
			}

		}

		if($end_flag == 0){

			print "print \"\\n\"\;\n";

		}

	}  elsif ($line =~ /^\s*print *\("(.*)"\)$/) {
	
		$prev_tab_count = $cur_tab_count;
		$line =~ /^([\t\s]*)/;
		$cur_tab_count = length($1);
	
		$j = 0;
		$i = 0;

		if($cur_tab_count < $prev_tab_count){

			while($j<$prev_tab_count - $cur_tab_count){

				$i = 0;
				while($i < $cur_tab_count){
					print " ";
					$i+=1;
				}
				print "}\n";
				$back_brackets+=1;
				$j+=4;
				$i+=4;
			}
		}

		$line =~ /^(\s*)print *\("(.*)"\)$/;
		print "$1print \"$2\\n\"\;";
		print "\n";

	} elsif ($line =~ /^\s*print *\((.*) ([\*\+\-\/\%]+) (.*)\)/) { #match the print with the operation 

		$prev_tab_count = $cur_tab_count;
		$line =~ /^([\t\s]*)/;	
		$cur_tab_count = length($1);
		$j = 0;

		if($cur_tab_count < $prev_tab_count){

			while($j< $prev_tab_count - $cur_tab_count){

				$i = 0;
				while($i < $cur_tab_count){

					print " ";
					$i+=1;
				}

				print "}\n";
				$j+=4;
				$i+=4;
				$back_brackets+=1;
				#print "2\n";
			}
		}

		$line =~ /^(\s*)print *\((.*)\)/;
		$space = $1;
		$operation = $2;
		$operation =~ s/([a-zA-Z]+)/\$$1/g;
		print "$space";
		print "print $operation, \"\\n\"\;";

		print "\n";

	} elsif($line =~ /^(\s*)print *\(\)$/) {

		$prev_tab_count = $cur_tab_count;
		$line =~ /^([\t\s]*)/;
		$cur_tab_count = length($1);

		$j = 0;

		if($cur_tab_count < $prev_tab_count){

			while($j < $prev_tab_count - $cur_tab_count){

				$i = 0;
				while($i < $cur_tab_count){
					print " ";
					$i+=1;
				}
				print "}\n";
				$j+=4;
				$i+=4;
				$back_brackets+=1;
				#print "3\n";
			}
		}

		$line =~ /^(\s*)print *\(\)$/;	
		print "$1print \"\\n\"\;";
		print "\n";

	} elsif($line =~/^(\s*)print\(len\((.*)\)\)/) {
		$space = $1;
		$name = $2;
		
		print "$space";
		print "print length\(\$$name\), \"\\n\"\;\n";

	}elsif ($line =~ /^(\s*)print *\((.*)\)$/){
	
		$prev_tab_count = $cur_tab_count;
		$line =~ /^([\t\s]*)/;
		$cur_tab_count = length($1);
		$j = 0;

		if($cur_tab_count < $prev_tab_count){

			while($j < $prev_tab_count - $cur_tab_count){

				$i = 0;
				while($i < $cur_tab_count){
					print " ";
					$i+=1;
				}
				print "}\n";
				$j+=4;
				$i+=4;
				$back_brackets+=1;
			}
		}

		$line =~ /^(\s*)print *\((.*)\)$/;
		$space = $1;
		$content = $2;	
		if($content =~ /\[.*\]/){
			print "$space";
			print "print \"\$$content\\n\"\;\n";
			
		}else{
	
			$line =~ /^(\s*)print *\((.*)\)$/;
			print "$1print \"\$$2\\n\"\;";
			print "\n";
		}

	} elsif($line =~ /sys.stdout.write\("(.*)"\)/) {
	
		$prev_tab_count = $cur_tab_count;
		$line =~/^([\t\s]*)/;
		$cur_tab_count = length($1);	

		$j = 0;
		if($cur_tab_count < $prev_tab_count){

			while($j<$prev_tab_count - $cur_tab_count){

				$i = 0;
				while($i < $cur_tab_count){
					print " ";
					$i+=1;
				}
				print "}\n";
				$j+=4;
				$i+=4;
				$back_brackets+=1;
				#print "4\n";
			}
		}

		$line =~ s/sys.stdout.write\(/print/;
		$line =~ s/\)/;/;
		print "$line\n";
		
	} elsif($line =~ /^(\s*)sys.stdout.write\((.*)\)/) {

		$prev_tab_count = $cur_tab_count;
		$line =~ /^([\t\s]*)/;
		$cur_tab_count = length($1);
		$j = 0;
		if($cur_tab_count < $prev_tab_count){

			while($j < $prev_tab_count - $cur_tab_count){

				$i = 0;
				while($i < $cur_tab_count){
					print " ";
					$i+=1;
				}
				print "}\n";
				$j+=4;
				$j+=4;
				$back_brackets+=1;
			}
		}
	
		$line = /^(\s*)sys.stdout.write\((.*)\)/;
	
		$space = $1;
		$name = $2;
		print "$space";
		print "print \"\$$name\\n\"\;\n";
	
	} elsif($line =~ /else:/){

		$line =~ s/else:/\} else {/;
		print "$line\n";

	} elsif($line =~ /^(\s*)for (.*) in range *\((.*), (.*)\):/){ 
	
		$prev_tab_count = $cur_tab_count;
		$line =~ /^([\t\s]*)/;
		$cur_tab_count = length($1);
		$j = 0;
		if($cur_tab_count < $prev_tab_count){

			while($j < $prev_tab_count - $cur_tab_count){

				$i = 0;
				while($i < $cur_tab_count){
					print " ";
					$i+=1;
				}
				print "}\n";
				$j+=4;
				$i+=4;
				$back_brackets+=1;
			}
		}

		$line =~ /^(\s*)for (.*) in range *\((.*), (.*)\):/;	

		$low = $3; #the low bond of range
		$high = $4;#the high bond of the range
		$space = $1;
		$name = $2;# i 	

		if($high =~ /[a-zA-Z]+/){ #if the high bond has variable

			if($high =~ /([a-zA-Z]+)$/){ # if the high bond is k we change it to k-1

				$high .= " - 1 ";
				$high =~ s/([a-zA-Z]+)/\$$1/;

			} else { #else if the high bond is k + something or k - something

				$high =~ /([a-zA-Z]+) ?(.*) ?([0-9]+)/;
				$sign_in_high = $2;
				$num_in_high = $3;
				$name_in_high = $1;

				if ($sign_in_high =~ /\+/) { #if it is k + something

					$num_in_high -= 1;

					if ($num_in_high == 0) { 

						$high = $name_in_high;

					} else {
						$high = $name_in_high;
						$high .= $sign_in_high;
						$high .= $num_in_high;
					}

					$high =~ s/([a-zA-Z]+)/\$$1/;

				} elsif ($sign_in_high eq "-"){ #if it is k - something

					$num_in_high += 1;
					$high = $name_in_high;
					$high .= $sign_in_high;
					$high .= $num_in_high;
					$high =~ s/$high/\$$high/;

				}
			}

		} else { #if there is no variable in range()

			$high = $high - 1;		

		}

		print "$space";
		print "foreach \$$name \($low..$high\) \{\n";	
		$front_brackets += 1;

	} elsif ($line =~ /while/){

		$prev_tab_count = $cur_tab_count;
		$line =~ /^([\t\s]*)/;
		$cur_tab_count = length($1);
		$j = 0;

		if($cur_tab_count < $prev_tab_count){

			while($j < $prev_tab_count - $cur_tab_count){

				$i = 0;
				while($i < $cur_tab_count){
					print " ";
					$i+=1;
				}
				print "}\n";
				$j+=4;
				$i+=4;
				$back_brackets+=1;
			}
		}
					
		if ($line =~ /:$/){ #if there is no other argument after while

			$front_brackets += 1;
			$line =~ s/while/while \(/;
			$line =~ s/:/\) \{/;
			$line =~ s/([a-zA-Z]+)/\$$1/g;
			$line =~ s/\$while/while/;
			print "$line\n";

		} elsif($line =~ /(while.*:)(.*)$/) { #if have something after while

			$front_brackets += 1;
			$tab_num = 1; #output need to have tab
			$first_part = $1; # the part before : including :
			$second_part = $2; #the part after :
			$first_part =~ s/([a-zA-Z]+)/\$$1/g; #add a $ before any word
			$first_part =~ s/\$while/while/; #remove the $ before while
			$first_part =~ s/while/while\(/;
			$first_part =~ s/:/\) {/;
			print "$first_part\n";

			comp_while("$second_part", "$tab_num");
				
		}

	} elsif($line =~ /elif/) {

		$line =~ s/([a-zA-Z]+)/\$$1/g;
		$line =~ s/\$elif/elsif/;
		$line =~ s/elsif/\} elsif \(/;
		$line =~ s/:/\) \{/;
		print "$line\n";
	 
	} elsif($line =~ /if/){

		$prev_tab_count = $cur_tab_count;
		$line =~ /^([\t\s]*)/;
		$cur_tab_count = length($1);
		$j = 0;
		if($cur_tab_count < $prev_tab_count){
			while($j < $prev_tab_count - $cur_tab_count){
				$i = 0;
				while($i < $cur_tab_count){
					print " ";
					$i+=1;
				}
				print "}\n";
				$j+=4;
				$i+=4;
				$back_brackets+=1;
			}
		}



		if($line =~ /:$/){ #if there is nothing after :
	
			$line =~ s/if ?/if\(/;
			$line =~ s/:/\){/;
			$line =~ s/([a-zA-Z]+)/\$$1/g;
			$line =~ s/\$if/if/;	
			$line =~ s/\$and/and/;	

			print "$line\n";
			$front_brackets+=1;

		} elsif($line =~ /(if.*:) (.*)/){

			$tab_num = 1;
			$first_part = $1;
			$second_part = $2;
			$first_part =~ s/if/if \(/;
			$first_part =~ s/:/\) {/;
			$first_part =~ s/([a-zA-Z]+)/\$$1/g;
			$first_part =~ s/\$if/if/;
			$first_part =~ s/\$and/and/; # change logical and
			$first_part =~ s/\$or/or/; #change logical or
			$first_part =~ s/\$not/not/;
			print "$first_part\n";
			$front_brackets+=1;
			#print "5\n";	
			comp_while("$second_part", "$tab_num");    
		}

	} elsif($line =~ /len\((.*)\)/) {


		$prev_tab_count = $cur_tab_count;
		$line =~ /^([\t\s]*)/;
		$cur_tab_count = length($1);
		$j = 0;

		if($cur_tab_count < $prev_tab_count){
			
			while($j < $prev_tab_count - $cur_tab_count){
				$i = 0;
				while($i < $cur_tab_count){
					print " ";
					$i+=1
				}

				print "}\n";
				$j+=4;
				$i+=4;
				$back_brackets+=1;
			}
		}
		
		$line =~ /len\((.*)\)/;

		$line =~ s/([a-zA-Z]+)/\$$1/g;
		$line .= ";";
		$line =~ s/\$len\(\$/@/;
		$line =~ s/\)//;
		print "$line\n";		

	} elsif($line =~ /for (.*) in sys.stdin:/) {
		
		print "foreach \$$1 \(<STDIN>\) {\n";
		$front_brackets+=1;

		
	} elsif($line =~ /^(\s*)(.*).append\((.*)\)/) {

		$prev_tab_count = $cur_tab_count;
		$line =~ /^([\t\s]*)/;
		$cur_tab_count = length($1);
		$j = 0;

		if($cur_tab_count < $prev_tab_count){
			while($j < $prev_tab_count - $cur_tab_count){
				$i = 0;

				while($i < $cur_tab_count){
					
					print " ";
					$i+=1;
				}

				print "}\n";
				$j+=4;
				$i+=4;
				$back_brackets+=1;
			}
		}
		
		$line =~ /^(\s*)(.*).append\((.*)\)/;

		$space = $1;
		$object = $2;
		$item = $3;
		
		print "$space";
		print "push \@$object, \$$item\;\n";
		
	} elsif($line =~ /.*= *\[\]/) {
		
	} elsif($line =~ /^(\s*)(.*) *= *\[(.+)\]/) {
		
		$space = $1;
		$list_name = $2;
		$list_content = $3;
	#	print "list name is: $list_name\n";
	#	print "list_content is: $list_content\n";
		$list_content =~ s/\'/\"/g;
		print "$space";
		print "\@$list_name = \($list_content\)\;\n";		
		
	} elsif ($line =~ /([a-zA-Z+]+)/) {
		#match the nomal line :no whlie no if no done no...
		$prev_tab_count = $cur_tab_count;
		$line =~ /^([\s]*)/;
		$cur_tab_count = length($1);
		$j = 0;
		$i = 0;

		if($cur_tab_count < $prev_tab_count){
		    while($j < $prev_tab_count - $cur_tab_count){
				$i = 0;
				while($i < $cur_tab_count){
					print " ";
					$i+=1;
				}
				print "}\n";
				$j+=4;
				$i+=4;
				$back_brackets+=1;
		    }
		}
	
		if($line =~ /\/\//){
			$line =~ s/\/\//\//;
		}
	

		$line =~ s/([a-zA-Z]+)/\$$1/g;
		$line .= ";";

		if($line =~ /= "\$/){
			$line =~ /\"(.*)\"/;
			$str = $1;
			$str =~ s/\$([a-zA-Z]+)/$1/g;
			$line =~ /\"(.*)\"/;
			$line =~ s/\"(.*)\"/\"$str\"/;
		
		}
	
		print "$line\n"

	} else {
		print "$line\n";	
	}
}


if($back_brackets<$front_brackets){

	print "}\n";
}

sub comp_while{ #function to handle the single line if and while statements

	my($input_line, $count_tab) = @_;
	my @lines = split('; ',$input_line);
	foreach my $single_line (@lines) {

		my $i = 0;
		while ($i < $count_tab) { #add the tab before each line 
			print "\t";
			$i+=1;
		}
		$i = 0;

		if($single_line =~ /^\s*print *\("(.*)"\)$/){
			print "print \"$1\\n\"\;";
			print "\n";
		}elsif($single_line =~ /^\s*print *\((.*) ([\*\+\-\/]) (.*)\)$/){
			print "print \$$1 $2 \$$3, \"\\n\"\;";
		}elsif($single_line =~ /^\s*print *\((.*)\)$/){
			print "print \"\$$1\\n\"\;";
			print "\n";
 		}elsif($single_line =~ /([a-zA-Z+])/){
			$single_line =~ s/([a-zA-Z]+)/\$$1/g;
			$single_line .= ";";
			print "$single_line\n";
		}else{
			print "$single_line\n";
		}
		
	}
	if($count_tab-1 == 0){
		print "}\n";
		$back_brackets+=1;
	}else {
		while($i<$count_tab-1){
			print "\t";
			$i+=1;
		}
		print "}\n";
		$back_brackets+=1;
	}

}
