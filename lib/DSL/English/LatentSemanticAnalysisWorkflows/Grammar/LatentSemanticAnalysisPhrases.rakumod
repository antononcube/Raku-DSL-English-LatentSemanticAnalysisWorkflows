use v6;

use DSL::Shared::Roles::English::CommonParts;
use DSL::Shared::Utilities::FuzzyMatching;

# Latent Semantic Analysis (LSA) phrases
role DSL::English::LatentSemanticAnalysisWorkflows::Grammar::LatentSemanticAnalysisPhrases
        does DSL::Shared::Roles::English::CommonParts {

    # For some reason using <item> below gives the error: "Too many positionals passed; expected 1 argument but got 2".

    # LSA specific
    token analysis { 'analysis' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'analysis') }> }
    token component { 'component' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'component') }> }
    token decomposition { 'decomposition' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'decomposition') }> }
    token document { 'document' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'document') }> }
    token documents { 'documents' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'documents') }> }
    token entries { 'entries' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'entries') }> }
    token factorization { 'factorization' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'factorization') }> }
    token identifier { 'identifier' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'identifier') }> }
    token independent { 'independent' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'independent') }> }
    token indexing { 'indexing' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'indexing') }> }
    token ingest { 'ingest' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'ingest') }> | 'load' | 'use' | 'get' }
    token item { 'item' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'item') }> }
    token latent { 'latent' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'latent') }> }
    token matrix { 'matrix' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'matrix') }> }
    token negative { 'negative' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'negative') }> }
    token nonnegative { 'non-negative' | 'nonnegative' }
    token partition { 'partition' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'partition') }> }
    token principal { 'principal' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'principal') }> }
    token query { 'query' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'query') }> }
    token represent { 'represent' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'represent') }> }
    token semantic { 'semantic' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'semantic') }> }
    token singular { 'singular' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'singular') }> }
    token synonym { 'synonym' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'synonym') }> }
    token synonyms { 'synonyms' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'synonyms') }> }
    token table-noun { 'table' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'table') }> }
    token term { 'term' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'term') }> }
    token thesaurus { 'thesaurus' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'thesaurus') }> }
    token threshold { 'threshold' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'threshold') }> }
    token topic { 'topic' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'topic') }> }
    token topics { 'topics' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'topics') }> }
    token weight { 'weight' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'weight') }> }
    token word { 'word' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'word') }> }

    rule doc-term-mat { [ <document> | 'item' ] [ <term> | <word> ] <matrix> }
    rule lsa-object { <lsa-phrase>? 'object' }
    rule lsa-phrase { <latent> <semantic> <analysis> | 'lsa' | 'LSA' }
    rule lsi-phrase { <latent> <semantic> <indexing> | 'lsi' | 'LSI' }
    rule matrix-entries { [ <doc-term-mat> | <matrix> ]? <entries> }
    rule number-of-terms-phrase { <number-of>? <terms> }
    rule the-outliers { <the-determiner> <outliers> }

    # Document term matrix creation related
    rule data-element { 'sentence' | 'paragraph' | 'section' | 'chapter' | 'word' }
    rule data-elements { 'sentences' | 'paragraphs' | 'sections' | 'chapters' | 'words' }

    rule docs { 'document' | 'documents' | 'item' | 'items' }
    rule terms { 'word' | 'words' | 'term' | 'terms' }

    rule stemming-rules-phrase { 'stemming' ['rules']? }
    rule stop-words-phrase { 'stop' 'words' }

    rule text-corpus-phrase { 'texts' | 'text' [ 'corpus' | 'collection' ]? }

    # Topics and thesaurus
    rule statistical-thesaurus-phrase { <statistical>? <thesaurus> }
    rule topics-table-phrase { 'topics' 'table' }

    # LSI specific
    token frequency { 'frequency' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'frequency') }> }
    token function { 'function' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'function') }> }
    token functions { 'function' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'function') }> | 'functions' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'functions') }> }
    token global { 'global' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'global') }> }
    token local { 'local' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'local') }> }
    token normalization { 'normalization' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'normalization') }> }
    token normalizer { 'normalizer' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'normalizer') }> }
    token normalizing { 'normalizing' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'normalizing') }> }

    rule global-function-phrase { <global> <term> ?<weight>? <function> }
    rule local-function-phrase { <local> <term>? <weight>? <function> }
    rule normalizer-function-phrase { [ <normalizer> | <normalizing> | <normalization> ] <term>? <weight>? <function>? }

    # Matrix factorization specific
    rule ICA-phrase { <independent> <component> <analysis> }
    rule NNMF-phrase { [ <non-prefix> <negative> | <nonnegative> ] <matrix> <factorization> }
    rule PCA-phrase { <principal> <component> <analysis> }
    rule SVD-phrase { <singular> <value-noun> <decomposition> }
}