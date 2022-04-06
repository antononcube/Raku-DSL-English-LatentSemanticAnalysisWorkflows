=begin pod

=head1 DSL::English::LatentSemanticAnalysisWorkflows

C<DSL::English::LatentSemanticAnalysisWorkflows> package has grammar classes and action classes for the parsing and
interpretation of English natural speech commands that specify Latent Semantic Analysis (LSA) workflows.

=head1 Synopsis

    use DSL::English::LatentSemanticAnalysisWorkflows;
    my $rcode = ToLatentSemanticAnalysisWorkflowCode("make the document term matrix");

=end pod

unit module DSL::English::LatentSemanticAnalysisWorkflows;

use DSL::Shared::Utilities::CommandProcessing;

use DSL::English::LatentSemanticAnalysisWorkflows::Grammar;
use DSL::English::LatentSemanticAnalysisWorkflows::Actions::Bulgarian::Standard;
use DSL::English::LatentSemanticAnalysisWorkflows::Actions::English::Standard;
use DSL::English::LatentSemanticAnalysisWorkflows::Actions::Python::LSAMon;
use DSL::English::LatentSemanticAnalysisWorkflows::Actions::R::LSAMon;
use DSL::English::LatentSemanticAnalysisWorkflows::Actions::Russian::Standard;
use DSL::English::LatentSemanticAnalysisWorkflows::Actions::WL::LSAMon;

my %targetToAction{Str} =
    "Bulgarian"        => DSL::English::LatentSemanticAnalysisWorkflows::Actions::Bulgarian::Standard,
    "English"          => DSL::English::LatentSemanticAnalysisWorkflows::Actions::English::Standard,
    "Python"           => DSL::English::LatentSemanticAnalysisWorkflows::Actions::Python::LSAMon,
    "Python-LSAMon"    => DSL::English::LatentSemanticAnalysisWorkflows::Actions::Python::LSAMon,
    "LSAMon-Python"    => DSL::English::LatentSemanticAnalysisWorkflows::Actions::Python::LSAMon,
    "R"                => DSL::English::LatentSemanticAnalysisWorkflows::Actions::R::LSAMon,
    "LSAMon-R"         => DSL::English::LatentSemanticAnalysisWorkflows::Actions::R::LSAMon,
    "R-LSAMon"         => DSL::English::LatentSemanticAnalysisWorkflows::Actions::R::LSAMon,
    "Mathematica"      => DSL::English::LatentSemanticAnalysisWorkflows::Actions::WL::LSAMon,
    "Russian"          => DSL::English::LatentSemanticAnalysisWorkflows::Actions::Russian::Standard,
    "WL"               => DSL::English::LatentSemanticAnalysisWorkflows::Actions::WL::LSAMon,
    "WL-LSAMon"        => DSL::English::LatentSemanticAnalysisWorkflows::Actions::WL::LSAMon,
    "LSAMon-WL"        => DSL::English::LatentSemanticAnalysisWorkflows::Actions::WL::LSAMon;

my %targetToAction2{Str} = %targetToAction.grep({ $_.key.contains('-') }).map({ $_.key.subst('-', '::') => $_.value }).Hash;
%targetToAction = |%targetToAction , |%targetToAction2;

my Str %targetToSeparator{Str} =
    "Bulgarian"        => "\n",
    "English"          => "\n",
    "R"                => " %>%\n",
    "R-LSAMon"         => " %>%\n",
    "LSAMon-R"         => " %>%\n",
    "Mathematica"      => " \\[DoubleLongRightArrow]\n",
    "Python"           => "",
    "Python-LSAMon"    => "",
    "LSAMon-Python"    => "",
    "Russian"          => "\n",
    "WL"               => " \\[DoubleLongRightArrow]\n",
    "WL-LSAMon"        => " \\[DoubleLongRightArrow]\n",
    "LSAMon-WL"        => " \\[DoubleLongRightArrow]\n";

my Str %targetToSeparator2{Str} = %targetToSeparator.grep({ $_.key.contains('-') }).map({ $_.key.subst('-', '::') => $_.value }).Hash;
%targetToSeparator = |%targetToSeparator , |%targetToSeparator2;


#-----------------------------------------------------------
proto ToLatentSemanticAnalysisWorkflowCode(Str $command, | ) is export {*}

multi ToLatentSemanticAnalysisWorkflowCode( Str $command, :$target = 'R-LSAMon',  *%args ) {
    return ToLatentSemanticAnalysisWorkflowCode( $command, $target, |%args);
}

multi ToLatentSemanticAnalysisWorkflowCode( Str $command, Str $target = 'R-LSAMon', *%args ) {

    my $lang = %args<language>:exists ?? %args<language> !! 'English';
    $lang = $lang.wordcase;

    my $gname = "DSL::{$lang}::LatentSemanticAnalysisWorkflows::Grammar";

    try require ::($gname);
    if ::($gname) ~~ Failure { die "Failed to load the grammar $gname." }

    my Grammar $grammar = ::($gname);

    DSL::Shared::Utilities::CommandProcessing::ToWorkflowCode( $command,
                                                               :$grammar,
                                                               :%targetToAction,
                                                               :%targetToSeparator,
                                                               :$target,
                                                               |%args )
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
