#!/usr/bin/env perl6
use DSL::English::LatentSemanticAnalysisWorkflows;

sub MAIN( Str $commands ) {
    put ToLatentSemanticAnalysisWorkflowCode( $commands );
}

