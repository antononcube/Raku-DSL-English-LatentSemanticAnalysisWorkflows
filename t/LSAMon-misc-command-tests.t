use v6;
use lib 'lib';
use DSL::English::LatentSemanticAnalysisWorkflows::Grammar;
use Test;

plan 2;

# Shortcut
my $pLSAMONCOMMAND = DSL::English::LatentSemanticAnalysisWorkflows::Grammar;

#-----------------------------------------------------------
# Statistics command tests
#-----------------------------------------------------------

# 1
ok $pLSAMONCOMMAND.parse('compute the document term statistics'),
        'compute the document term statistics';

# 2
ok $pLSAMONCOMMAND.parse('show the term document histogram'),
        'show the term document histogram';

done-testing;
