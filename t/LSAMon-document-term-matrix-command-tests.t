use v6;
use lib 'lib';
use DSL::English::LatentSemanticAnalysisWorkflows::Grammar;
use Test;

plan 13;

# Shortcut
my $pLSAMONCOMMAND = DSL::English::LatentSemanticAnalysisWorkflows::Grammar;

#-----------------------------------------------------------
# Make document-term matrix command tests
#-----------------------------------------------------------

ok $pLSAMONCOMMAND.parse('create a document term matrix'),
        'create a document term matrix';

ok $pLSAMONCOMMAND.parse('make the document word matrix'),
        'make the document word matrix';

ok $pLSAMONCOMMAND.parse('make the document word matrix using no stop words'),
        'make the document word matrix using no stop words';

ok $pLSAMONCOMMAND.parse('make the document term matrix using automatic stop words and automatic stemming rules'),
        'make the document term matrix using automatic stop words and automatic stemming rules';

ok $pLSAMONCOMMAND.parse('make document term matrix with no stemming rules and no stop words'),
        'make document term matrix with no stemming rules and no stop words';

ok $pLSAMONCOMMAND.parse('make document term matrix with automatic stop words and without stemming rules'),
        'make document term matrix with automatic stop words and without stemming rules';

ok $pLSAMONCOMMAND.parse('make the document term matrix without stemming and with automatic stop words'),
        'make the document term matrix without stemming and with automatic stop words';

ok $pLSAMONCOMMAND.parse('make the document term matrix with `Automatic` stemming rules and with `Automatic` stop words'),
        'make the document term matrix with `Automatic` stemming rules and with `Automatic` stop words';

ok $pLSAMONCOMMAND.parse('make the document term matrix using default stemming rules and with default stop words'),
        'make the document term matrix using default stemming rules and with default stop words';

ok $pLSAMONCOMMAND.parse('make the document term matrix with stemming'),
        'make the document term matrix with stemming';

ok $pLSAMONCOMMAND.parse('make the document term matrix with stemming and without stop words'),
        'make the document term matrix with stemming and without stop words';

ok $pLSAMONCOMMAND.parse('make the document term matrix without stemming'),
        'make the document term matrix without stemming';

ok $pLSAMONCOMMAND.parse('make the document term matrix without stop words'),
        'make the document term matrix without stop words';

done-testing;
