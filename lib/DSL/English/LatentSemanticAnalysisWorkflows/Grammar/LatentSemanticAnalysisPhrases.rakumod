use v6;

use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Utilities::FuzzyMatching;

# Latent Semantic Analysis (LSA) phrases
role DSL::English::LatentSemanticAnalysisWorkflows::Grammar::LatentSemanticAnalysisPhrases
        does DSL::Shared::Roles::English::PipelineCommand {

    # For some reason using <item-noun> below gives the error: "Too many positionals passed; expected 1 argument but got 2".

    # LSA specific

    proto token analysis-noun {*}
    token analysis-noun:sym<English> { :i 'analysis' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'analysis', 2) }> }

    proto token component-noun {*}
    token component-noun:sym<English> { :i 'component' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'component', 2) }> }

    proto token decomposition-noun {*}
    token decomposition-noun:sym<English> { :i 'decomposition' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'decomposition', 2) }> }

    proto token entries-noun {*}
    token entries-noun:sym<English> { :i 'entries' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'entries', 2) }> }

    proto token factorization-noun {*}
    token factorization-noun:sym<English> { :i 'factorization' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'factorization', 2) }> }

    proto token independent-adjective {*}
    token independent-adjective:sym<English> { :i 'independent' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'independent', 2) }> }

    proto token indexing-noun {*}
    token indexing-noun:sym<English> { :i 'indexing' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'indexing', 2) }> }

    proto token item-noun {*}
    token item-noun:sym<English> { :i 'item' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'item', 2) }> }

    proto token items-noun {*}
    token items-noun:sym<English> { :i 'items' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'items', 2) }> }

    proto token latent-adjective {*}
    token latent-adjective:sym<English> { :i 'latent' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'latent', 2) }> }

    proto token negative-adjective {*}
    token negative-adjective:sym<English> { :i 'negative' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'negative', 2) }> }

    proto token nonnegative-adjective {*}
    token nonnegative-adjective:sym<English> { :i  'non-negative' | 'nonnegative'  }

    proto token partition-noun {*}
    token partition-noun:sym<English> { :i 'partition' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'partition', 2) }> }

    proto token principal-adjective {*}
    token principal-adjective:sym<English> { :i 'principal' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'principal', 2) }> }

    proto token query-noun {*}
    token query-noun:sym<English> { :i 'query' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'query', 2) }> }

    proto token rules-noun {*}
    token rules-noun:sym<English> { :i 'rules' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'rules', 2) }> }

    proto token semantic-adjective {*}
    token semantic-adjective:sym<English> { :i 'semantic' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'semantic', 2) }> }

    proto token singular-adjective {*}
    token singular-adjective:sym<English> { :i 'singular' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'singular', 2) }> }

    proto token stemming-noun {*}
    token stemming-noun:sym<English> { :i 'stemming' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'stemming', 2) }> }

    proto token stop-adjective {*}
    token stop-adjective:sym<English> { :i 'stop' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'stop', 2) }> }

    proto token stop-noun {*}
    token stop-noun:sym<English> { :i 'stop' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'stop', 2) }> }

    proto token synonym-noun {*}
    token synonym-noun:sym<English> { :i 'synonym' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'synonym', 2) }> }

    proto token synonyms-noun {*}
    token synonyms-noun:sym<English> { :i 'synonyms' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'synonyms', 2) }> }

    proto token term-noun {*}
    token term-noun:sym<English> { :i 'term' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'term', 2) }> }

    proto token terms-noun {*}
    token terms-noun:sym<English> { :i 'terms' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'terms', 2) }> }

    proto token thesaurus-noun {*}
    token thesaurus-noun:sym<English> { :i 'thesaurus' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'thesaurus', 2) }> }

    proto token topic-noun {*}
    token topic-noun:sym<English> { :i 'topic' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'topic', 2) }> }

    proto token topics-noun {*}
    token topics-noun:sym<English> { :i 'topics' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'topics', 2) }> }


    proto token document-term-phrase {*}
    token document-term-phrase:sym<English> { :i [ <document-noun> | 'doc' | 'item' ] [ '-' | '-vs-' | \h+ ] [ <term-noun> | <word-noun> ]  }

    proto rule doc-term-mat {*}
    rule doc-term-mat:sym<English> {  [ <document-noun> | <item-noun> ] [ <term-noun> | <word-noun> ] <matrix-noun>  }

    proto rule doc-term-mat-phrase {*}
    rule doc-term-mat-phrase:sym<English> {  <document-term-phrase> <matrix-noun>  }

    proto rule ingest-directive {*}
    rule ingest-directive:sym<English> {  <ingest-verb> | <load-verb> | <use-verb> | <get-verb>  }

    proto rule lsa-object {*}
    rule lsa-object:sym<English> {  <lsa-phrase>? <object-noun>  }

    proto rule lsa-phrase {*}
    rule lsa-phrase:sym<English> {  <latent-adjective> <semantic-adjective> <analysis-noun> | 'lsa' | 'LSA'  }

    proto rule lsi-phrase {*}
    rule lsi-phrase:sym<English> {  <latent-adjective> <semantic-adjective> <indexing-noun> | 'lsi' | 'LSI'  }

    proto rule matrix-entries {*}
    rule matrix-entries:sym<English> {  [ <doc-term-mat-phrase> | <matrix-noun> ]? <entries-noun>  }

    proto rule number-of-terms-phrase {*}
    rule number-of-terms-phrase:sym<English> {  <number-of>? <terms-noun>  }

    proto rule the-outliers {*}
    rule the-outliers:sym<English> {  <the-determiner> <outliers>  }

    # Document term matrix creation related

    proto rule data-element {*}
    rule data-element:sym<English> { 'sentence' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'sentence', 2) }> | 'paragraph' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'paragraph', 2) }> | 'section' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'section', 2) }> | 'chapter' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'chapter', 2) }> | 'word' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'word', 2) }> }

    proto rule data-elements {*}
    rule data-elements:sym<English> { 'sentences' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'sentences', 2) }> | 'paragraphs' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'paragraphs', 2) }> | 'sections' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'sections', 2) }> | 'chapters' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'chapters', 2) }> | 'words' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'words', 2) }> }


    proto rule docs {*}
    rule docs:sym<English> {  <document-noun> | <documents-noun> | 'docs' | <item-noun> | <items-noun>  }

    proto rule terms-phrase {*}
    rule terms-phrase:sym<English> {  <word-noun> | <words-noun> | <term-noun> | <terms-noun>  }


    proto rule stemming-rules-phrase {*}
    rule stemming-rules-phrase:sym<English> {  <stemming-noun> [<rules-noun>]?  }

    proto rule stop-words-phrase {*}
    rule stop-words-phrase:sym<English> {  <stop-adjective> <words-noun>  }


    proto rule text-corpus-phrase {*}
    rule text-corpus-phrase:sym<English> {  'texts' | 'text' [ 'corpus' | 'collection' ]?  }

    # Topics and thesaurus

    proto rule statistical-thesaurus-phrase {*}
    rule statistical-thesaurus-phrase:sym<English> {  <statistical>? <thesaurus-noun>  }

    proto rule topics-table-phrase {*}
    rule topics-table-phrase:sym<English> {  <topics-noun> <table-noun> | <table-noun> <of-preposition> <topics-noun> }


    # LSI specific

    proto token frequency-noun {*}
    token frequency-noun:sym<English> { :i 'frequency' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'frequency', 2) }> }

    proto token global-adjective {*}
    token global-adjective:sym<English> { :i 'global' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'global', 2) }> }

    proto token inverse-adjective {*}
    token inverse-adjective:sym<English> { :i 'inverse' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'inverse', 2) }> }

    proto token local-adjective {*}
    token local-adjective:sym<English> { :i 'local' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'local', 2) }> }

    proto token normalization-noun {*}
    token normalization-noun:sym<English> { :i 'normalization' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'normalization', 2) }> }

    proto token normalizer-noun {*}
    token normalizer-noun:sym<English> { :i 'normalizer' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'normalizer', 2) }> }

    proto token normalizing-noun {*}
    token normalizing-noun:sym<English> { :i 'normalizing' | ([\w]+) <?{ is-fuzzy-match($0.Str, 'normalizing', 2) }> }


    proto rule global-function-phrase {*}
    rule global-function-phrase:sym<English> {  <global-adjective> <term-noun> ?<weight-noun>? <function-noun>  }

    proto rule join-type-phrase {*}
    rule join-type-phrase:sym<English> {  <join-verb>? <type-noun>  }

    proto rule local-function-phrase {*}
    rule local-function-phrase:sym<English> {  <local-adjective> <term-noun>? <weight-noun>? <function-noun>  }

    proto rule normalizer-function-phrase {*}
    rule normalizer-function-phrase:sym<English> {  [ <normalizer-noun> | <normalizing-noun> | <normalization-noun> ] <term-noun>? <weight-noun>? <function-noun>?  }

    # Matrix factorization specific

    proto rule ICA-phrase {*}
    rule ICA-phrase:sym<English> {  <independent-adjective> <component-noun> <analysis-noun>  }

    proto rule NNMF-phrase {*}
    rule NNMF-phrase:sym<English> {  [ <non-prefix> <negative-adjective> | <nonnegative-adjective> ] <matrix-noun> <factorization-noun>  }

    proto rule PCA-phrase {*}
    rule PCA-phrase:sym<English> {  <principal-adjective> <component-noun> <analysis-noun>  }

    proto rule SVD-phrase {*}
    rule SVD-phrase:sym<English> {  <singular-adjective> <value-noun> <decomposition-noun>  }
}
