=begin pod

=head1 DSL::English::LatentSemanticAnalysisWorkflows

C<DSL::English::LatentSemanticAnalysisWorkflows> package has grammar classes and action classes for the parsing and
interpretation of English natural speech commands that specify Latent Semantic Analysis (LSA) workflows.

=head1 Synopsis

    use DSL::English::LatentSemanticAnalysisWorkflows;
    my $rcode = to_LSAMon_R("make the document term matrix");

=end pod

unit module DSL::English::LatentSemanticAnalysisWorkflows;

use DSL::Shared::Utilities::MetaSpecifications;

use DSL::English::LatentSemanticAnalysisWorkflows::Grammar;
use DSL::English::LatentSemanticAnalysisWorkflows::Actions::Python::LSAMon;
use DSL::English::LatentSemanticAnalysisWorkflows::Actions::R::LSAMon;
use DSL::English::LatentSemanticAnalysisWorkflows::Actions::WL::LSAMon;

my %targetToAction =
    "Python"           => DSL::English::LatentSemanticAnalysisWorkflows::Actions::Python::LSAMon,
    "Python-LSAMon"    => DSL::English::LatentSemanticAnalysisWorkflows::Actions::Python::LSAMon,
    "R"                => DSL::English::LatentSemanticAnalysisWorkflows::Actions::R::LSAMon,
    "R-LSAMon"         => DSL::English::LatentSemanticAnalysisWorkflows::Actions::R::LSAMon,
    "Mathematica"      => DSL::English::LatentSemanticAnalysisWorkflows::Actions::WL::LSAMon,
    "WL"               => DSL::English::LatentSemanticAnalysisWorkflows::Actions::WL::LSAMon,
    "WL-LSAMon"        => DSL::English::LatentSemanticAnalysisWorkflows::Actions::WL::LSAMon;

my %targetToSeparator{Str} =
    "R"                => " %>%\n",
    "R-LSAMon"         => " %>%\n",
    "Mathematica"      => " ==>\n",
    "Python"           => "\n",
    "Python-LSAMon"    => "\n",
    "WL"               => " ==>\n",
    "WL-LSAMon"        => " ==>\n";


#-----------------------------------------------------------
sub has-semicolon (Str $word) {
    return defined index $word, ';';
}

#-----------------------------------------------------------
proto ToLatentSemanticAnalysisWorkflowCode(Str $command, Str $target = "R-LSAMon" ) is export {*}

multi ToLatentSemanticAnalysisWorkflowCode ( Str $command where not has-semicolon($command), Str $target = "R-LSAMon" ) {

    die 'Unknown target.' unless %targetToAction{$target}:exists;

    my $match = DSL::English::LatentSemanticAnalysisWorkflows::Grammar.parse($command, actions => %targetToAction{$target} );
    die 'Cannot parse the given command.' unless $match;
    return $match.made;
}

multi ToLatentSemanticAnalysisWorkflowCode ( Str $command where has-semicolon($command), Str $target = 'R-LSAMon' ) {

    my $specTarget = get-dsl-spec( $command, 'target');

    $specTarget = !$specTarget ?? $target !! $specTarget.value;

    die 'Unknown target.' unless %targetToAction{$specTarget}:exists;

    my @commandLines = $command.trim.split(/ ';' \s* /);

    @commandLines = grep { $_.Str.chars > 0 }, @commandLines;

    my @cmdLines = map { ToLatentSemanticAnalysisWorkflowCode($_, $specTarget) }, @commandLines;

    @cmdLines = grep { $_.^name eq 'Str' }, @cmdLines;

    return @cmdLines.join( %targetToSeparator{$specTarget} ).trim;
}

#-----------------------------------------------------------
proto to_LSAMon_Python($) is export {*}

multi to_LSAMon_Python ( Str $command ) {
    return ToLatentSemanticAnalysisWorkflowCode( $command, 'Python-LSAMon' );
}

#-----------------------------------------------------------
proto to_LSAMon_R($) is export {*}

multi to_LSAMon_R ( Str $command ) {
    return ToLatentSemanticAnalysisWorkflowCode( $command, 'R-LSAMon' );
}

#-----------------------------------------------------------
proto to_LSAMon_WL($) is export {*}

multi to_LSAMon_WL ( Str $command ) {
    return ToLatentSemanticAnalysisWorkflowCode( $command, 'WL-LSAMon' );
}
