use v6;
use lib 'lib';
use DSL::English::LatentSemanticAnalysisWorkflows::Grammar;
use Test;

plan 5;

# Shortcut
my $pLSAMONCOMMAND = DSL::English::LatentSemanticAnalysisWorkflows::Grammar;

#-----------------------------------------------------------
# Representation command
#-----------------------------------------------------------

# 1
ok $pLSAMONCOMMAND.parse('represent by topics the query ji989'),
        'represent by topics the query ji989';

# 2
ok $pLSAMONCOMMAND.parse('represent by terms query ji989'),
        'represent by terms the query ji989';

# 3
ok $pLSAMONCOMMAND.parse('represent by terms the query "why here why now"'),
        'represent by terms query "why here why now"';

# 4
ok $pLSAMONCOMMAND.parse('represent by topics " why here why now "'),
        'represent by topics "why here why now"';

# 5
ok $pLSAMONCOMMAND.parse('represent by terms why here why now'),
        'represent by topics why here why now';

done-testing;