
use DSL::English::LatentSemanticAnalysisWorkflows::Grammar;
use Test;

plan 13;

# Shortcut
my $pLSAMONCOMMAND = DSL::English::LatentSemanticAnalysisWorkflows::Grammar;

#-----------------------------------------------------------
# Extract topics command tests
#-----------------------------------------------------------

# 1
ok $pLSAMONCOMMAND.parse('extract 60 topics'),
        'extract 60 topics';

# 2
ok $pLSAMONCOMMAND.parse('extract 23 topics using SVD'),
        'extract 23 topics using SVD';
# 3
ok $pLSAMONCOMMAND.parse('extract 23 topics using max steps 12'),
        'extract 23 topics using max steps 12';

# 4
ok $pLSAMONCOMMAND.parse('extract 23 topics using 20 maximum iterations'),
        'extract 23 topics using 20 maximum iterations';

# 5
ok $pLSAMONCOMMAND.parse('extract 23 topics with the method NonNegativeMatrixFactorization'),
        'extract 23 topics with the method NonNegativeMatrixFactorization';

# 6
ok $pLSAMONCOMMAND.parse('extract 30 topics with the method ica and 20 max steps'),
        'extract 23 topics with the method ica and 20 max steps';

# 7
ok $pLSAMONCOMMAND.parse('extract 30 topics with method SVD and maximum iterations 20'),
        'extract 23 topics with the method NNMF and 20 max steps';

# 8
ok $pLSAMONCOMMAND.parse('extract 30 topics with NNMF and steps 20'),
        'extract 23 topics with NNMF and steps 20';

# 9
ok $pLSAMONCOMMAND.parse('extract 30 topics with nnmf, max steps 20, and min number of documents per term 100'),
        'extract 30 topics with nnmf, max steps 20, and min number of documents per term 100';

#-----------------------------------------------------------
# Show topics table
#-----------------------------------------------------------

# 10
ok $pLSAMONCOMMAND.parse('show topics table'),
        'show topics table';

# 11
ok $pLSAMONCOMMAND.parse('show topics table with 6 columns'),
        'show topics table with 6 columns';

# 12
ok $pLSAMONCOMMAND.parse('show topics table with 12 columns and 10 terms'),
        'show topics table with 12 columns and 10 terms';

# 13
ok $pLSAMONCOMMAND.parse('echo topics table with number of table columns 12 and number of terms 20'),
        'echo topics table with number of table columns 12 and number of terms 20';

done-testing;
