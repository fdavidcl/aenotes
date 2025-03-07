# Output a pdf
$pdf_mode = 1;
$pdflatex = 'pdflatex -output-directory=. -shell-escape %O %S';

# By default compile only the file called 'main.tex'
@default_files = ('notes.tex');

# Compile the glossary and acronyms list (package 'glossaries')
add_cus_dep( 'acn', 'acr', 0, 'makeglossaries' );
add_cus_dep( 'glo', 'gls', 0, 'makeglossaries' );
$clean_ext .= " acr acn alg glo gls glg";
sub makeglossaries {
   my ($base_name, $path) = fileparse( $_[0] );
   pushd $path;
   my $return = system "makeglossaries", $base_name;
   popd;
   return $return;
}

# Compile the nomenclature (package 'nomencl')
add_cus_dep( 'nlo', 'nls', 0, 'makenlo2nls' );
sub makenlo2nls {
    my ($base_name, $path) = fileparse( $_[0] );
    system( "makeindex -s nomencl.ist -o \"$base_name.nls\" \"$base_name.nlo\"" );
}
