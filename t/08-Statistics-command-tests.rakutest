
use DSL::English::LatentSemanticAnalysisWorkflows::Grammar;
use Test;

plan 4;

# Shortcut
my $pLSAMONCOMMAND = DSL::English::LatentSemanticAnalysisWorkflows::Grammar;

#-----------------------------------------------------------
# Make document-term matrix command tests
#-----------------------------------------------------------

# 1
ok $pLSAMONCOMMAND.parse('echo document term matrix statistics'),
        'echo document term matrix statistics';

# 2
ok $pLSAMONCOMMAND.parse('show statistics of the document term matrix'),
        'show statistics of the document term matrix';

# 3
ok $pLSAMONCOMMAND.parse('echo data summary'),
        'echo data summary';

# 4
ok $pLSAMONCOMMAND.parse('summarize the data'),
        'summarize the data';

done-testing;
