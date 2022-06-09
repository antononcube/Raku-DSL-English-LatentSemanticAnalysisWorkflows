
use DSL::English::LatentSemanticAnalysisWorkflows::Grammar;
use Test;

plan 7;

# Shortcut
my $pLSAMONCOMMAND = DSL::English::LatentSemanticAnalysisWorkflows::Grammar;

#-----------------------------------------------------------
# Extract statistical thesaurus command tests
#-----------------------------------------------------------

# 1
ok $pLSAMONCOMMAND.parse('extract statistical thesaurus'),
        'extract statistical thesaurus';

# 2
ok $pLSAMONCOMMAND.parse('extract statistical thesaurus with 12 synonyms'),
        'extract statistical thesaurus with 12 synonyms';

# 3
ok $pLSAMONCOMMAND.parse('show statistical thesaurus of word1, word2, and word3' ),
        'show statistical thesaurus of word1, word2, and word2';

# 4
ok $pLSAMONCOMMAND.parse('show statistical thesaurus for the words: word1, word2, and word3' ),
        'show statistical thesaurus of for the words: word1, word2, and word2';

# 5
ok $pLSAMONCOMMAND.parse('show statistical thesaurus of word1, word2, and word3 using 12 synonyms per word' ),
        'show statistical thesaurus of word1, word2, and word2 using 12 synonyms per word';

# 6
ok $pLSAMONCOMMAND.parse('what are the top nearest neighbors of word1, word2, and word3' ),
        'what are the top nearest neighbors of word1, word2, and word3';

# 7
ok $pLSAMONCOMMAND.parse('what are the nns of word1, word2, word3' ),
        'what are the nns of word1, word2, word2';

done-testing;
