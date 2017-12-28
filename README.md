# python_to_perl
assign1 of comp2041

Your task in this assignment is to write a Python compiler. Generally compilers take a high level language as input and output assembler, which can then can be directly executed. Your compiler will take a Python script as input and output a Perl script. Such a translation is useful because programmers sometimes need to convert Python scripts to Perl.
Possible reasons for this include integration of existing Python code into a Perl program and shifting a complete Python program to a new platform which requires Perl.

Your task in this assignment is to automate this conversion. You must write a Perl program which takes as input a Python script and outputs an equivalent Perl program.

The translation of some Python code to Perl is straightforward. The translation of other Python code is difficult or infeasible. So your program will not be able to translate all Python code to Perl. But a tool that performs only a partial translation of Python to Perl could still be very useful.

You should assume the Perl code output by your program will be subsequently read and modified by humans. In other words you have to output readable Perl code. For example, you should aim to preserve variable names and comments, and to output properly indented Perl code.

You must write your translator in Perl (for assignment 2 there will be no restriction on language).


Subset 1
variables
numeric constants
arithmetic operators: + - * / // % **
assignment (single values only)
examples of subset 1

Subset 2
logical operators: or, and, not
comparison operators: <, <=, >, >=, !=, == (numeric arguments only)
bitwise operators: | ^ & << >> ~
single-line if, while statements
break, continue
examples of subset 2

Subset 3
multi-line if, while statements
range(), 1 or 2 arguments
single & multi-line for statements
sys.stdout.write()
sys.stdin.readline()
int() one argument form only
examples of subset 3

Subset 4
lists (Perl arrays) including indexing ([]), append(), pop() with no argment, or with constant argument
len() applied to lists & strings
sys.stdin.readlines()
iteration over sys.stdin (e.g. for line in sys.stdin)
dicts including the keys method
sorted(), no optional arguments
string formatting with the % operator
examples of subset 4

Subset 5
comparison operators: <, <=, >, >=, <>, !=, == (string arguments)
concatenations operators: + += (string & list arguments)
sys.argv
: (arrays)
split(), join() methods for strings (including optional maxsplit parameter)
raw strings (r'')
re.match, re.search, re.sub
open() including the optional second parameter (mode).
fileinput.input(), sys.stdin
functions
