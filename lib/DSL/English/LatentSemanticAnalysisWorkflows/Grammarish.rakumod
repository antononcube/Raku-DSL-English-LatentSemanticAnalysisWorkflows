=begin comment
#==============================================================================
#
#   Latent Semantic Analysis workflows grammar in Raku Perl 6
#   Copyright (C) 2019  Anton Antonov
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Written by Anton Antonov,
#   ʇǝu˙oǝʇsod@ǝqnɔuouoʇuɐ
#   Windermere, Florida, USA.
#
#==============================================================================
#
#   For more details about Raku Perl6 see https://perl6.org/ .
#
#==============================================================================
#
#  The grammar design in this file follows very closely the EBNF grammar
#  for Mathematica in the GitHub file:
#    https://github.com/antononcube/ConversationalAgents/blob/master/EBNF/English/Mathematica/LatentSemanticAnalysisWorkflowsGrammar.m
#
#==============================================================================
=end comment

role DSL::English::LatentSemanticAnalysisWorkflows::Grammarish {

    # TOP
    rule TOP { <workflow-command> }

    # Workflow commands list
    rule workflow-commands-list { [ [ <.ws>? <workflow-command> <.ws>? ]+ % <.list-of-commands-separator> ] <.list-of-commands-separator>? }

    # Workflow command
    rule workflow-command {
        <pipeline-command> |
        <data-load-command> |
        <create-command> |
        <make-doc-term-matrix-command> |
        <data-transformation-command> |
        <data-statistics-command> |
        <statistics-command> |
        <lsi-apply-command> |
        <topics-extraction-command> |
        <thesaurus-extraction-command> |
        <show-topics-command> |
        <show-thesaurus-command> |
        <represent-query-command> }

    # Load data
    rule data-load-command { <load-data> | <use-lsa-object> }

    rule load-data { <load-data-opening> <the-determiner>? <data-kind> [ <data>? <load-preposition> ]? <location-specification> | <load-data-opening> [ <the-determiner> ]? <location-specification> <data>? }
    rule data-reference { <data-noun> | <text-corpus-phrase> <data-noun>? }
    rule load-data-opening { <load-directive> <the-determiner>? <data-reference>}
    rule load-preposition { <for-preposition> | <of-preposition> | <at-preposition> | <from-preposition> }
    rule location-specification { <web-address> | <database-name> | <wl-expr> }
    rule web-address { <variable-name> }
    rule database-name { <variable-name> }
    rule data-kind { <variable-name> }

    rule use-lsa-object { <.use-verb> <.the-determiner>? <.lsa-object> <location-specification> }

    # Create command
    rule create-command { <create-simple> | <create-by-dataset> }
    rule create-simple { <create-directive> <a-determiner>? <simple>? <object-noun> <simple-way-phrase>? | <simple> <object-noun> [ <creation-noun> | <making> ] }
    rule create-by-dataset {
        [ <create-simple> | <create-directive> | <use-directive> ] [ <.by-preposition> | <.with-preposition> | <.from-preposition> ]? <.textual-adjective>? <.data>? [ <location-specification>]}

    # Make document-term matrix command
    rule make-doc-term-matrix-command { [ <compute-directive> | <generate-directive> ] [ <.the-determiner> | <.a-determiner> ]? <doc-term-mat-phrase> <doc-term-matrix-parameters-spec>? }

    rule doc-term-matrix-parameters-spec { <.using-preposition> <doc-term-matrix-parameters-list> }
    rule doc-term-matrix-parameters-list { <doc-term-matrix-parameter>+ % [ <.list-separator> <.using-preposition>? ]}
    rule doc-term-matrix-parameter { <doc-term-matrix-stemming-rules> | <doc-term-matrix-stop-words> }

    rule no-stemming-rules-spec { [ <no-determiner> | <without-preposition> ] <stemming-rules-phrase> }
    rule doc-term-matrix-stemming-rules { <no-stemming-rules-spec> | <.stemming-rules-phrase> <stemming-rules-spec> | <stemming-rules-spec> <.stemming-rules-phrase> | <stemming-spec-simple> }
    rule stemming-rules-spec { <trivial-parameter> | <wl-expr> }
    rule stemming-spec-simple { <stemming-rules-phrase> }

    rule doc-term-matrix-stop-words { <.stop-words-phrase> <stop-words-spec> || <stop-words-spec> <.stop-words-phrase> || <stop-words-simple-spec> }
    rule stop-words-spec { <trivial-parameter> | <wl-expr> }
    rule stop-words-simple-spec { <stop-words-phrase> }

    rule trivial-parameter { <trivial-parameter-none> | <trivial-parameter-empty> | <trivial-parameter-automatic> | <trivial-parameter-false> | <trivial-parameter-true> }
    rule trivial-parameter-none { 'none' | 'no' | 'NA' }
    rule trivial-parameter-empty { 'empty' | '{}' | 'c()' }
    rule trivial-parameter-automatic { <.automatic> | 'NULL' | 'default' }
    rule trivial-parameter-false { 'False' | 'FALSE' | 'F' | 'false' }
    rule trivial-parameter-true { 'True' | 'TRUE' | 'T' | 'true' }

    # Data transformation command
    rule data-transformation-command { <data-partition> }
    rule data-partition { <partition-noun> <data-reference>? [ <to-preposition> | <into-preposition> ] <data-elements> }
    rule data-spec-opening {<transform-verb>}
    rule data-type-filler { <data-noun> | <records> }

    # Data statistics command
    rule data-statistics-command { <summarize-data> }
    rule summarize-data { <summarize-directive> <the-determiner>? <data> | <display-directive> <data>? [ <summary> | <summaries> ] | <data-noun> <summary> }

    # LSI command is programmed as a role.
    # <lsi-apply-command>

    # Statistics command
    rule statistics-command { <.statistics-preamble> [ <docs-term-matrix-statistics> | <statistics-of-docs-term-matrix> | <docs-per-term> | <terms-per-doc> ] }
    rule statistics-preamble { [ <compute-and-display> | <display-directive> ] [ <the-determiner> | <a-determiner> | <some-determiner> ]? }
    rule docs-per-term { <docs> <per-preposition>? <terms-phrase> <statistic-spec>? }
    rule terms-per-doc { <terms-phrase> <per-preposition>? <docs> <statistic-spec>? }
    rule statistic-spec { <diagram-spec> | <summary-spec> }
    rule diagram-spec { <histogram> }
    rule summary-spec { <summary> | <statistics-noun> }
    rule docs-term-matrix-statistics { <doc-term-mat-phrase> <statistics-noun> }
    rule statistics-of-docs-term-matrix { <statistics-noun> [ <of-preposition> | <for-preposition> ] <the-determiner> <doc-term-mat-phrase> }

    # Thesaurus command
    rule thesaurus-extraction-command {[ <compute-directive> | <extract-directive> ] <thesaurus-spec>}
    rule thesaurus-spec { <statistical-thesaurus-phrase> [ <with-preposition> <thesaurus-parameters-spec> ]? }
    rule thesaurus-parameters-spec {<thesaurus-number-of-nns>}
    rule thesaurus-number-of-nns {<number-value> [ <number-of>? [ <nearest-neighbors-phrase> | <synonyms-noun> | <synonym-noun> <terms-phrase> ] [ <per-preposition> <terms-phrase> ]?] }

    # Topics extraction
    rule topics-extraction-command {[ <compute-directive> | <extract-directive> ] <topics-spec> [ <topics-parameters-spec> ]?}
    rule topics-spec { <number-value> <topics-noun> | <topics-noun> <number-value> }
    rule topics-parameters-spec { <.with-preposition> <topics-parameters-list>}
    rule topics-parameters-list { <topics-parameter>+ % <list-separator> }

    rule topics-parameter { <topics-max-iterations> | <topics-initialization> | <min-number-of-documents-per-term> | <topics-method>}
    rule topics-max-iterations { <.max-iterations-phrase> <number-value> | <number-value> <.max-iterations-phrase> }
    rule topics-initialization {  <random-adjective>? <number-value> <columns> <clusters> }
    rule min-number-of-documents-per-term { <.min-number-of-documents-per-term-phrase> <number-value> | <number-value> <.min-number-of-documents-per-term-phrase> }
    rule min-number-of-documents-per-term-phrase { <minimum> <number-of> <documents-noun> <per-preposition> <terms-phrase> }
    rule topics-method {[ <.the-determiner>? <.method-noun> ]? <topics-method-name> }

    ## May be this should be slot?
    ## Also, note that the method names are hard-coded.
    rule topics-method-name { <topics-method-SVD> | <topics-method-PCA> | <topics-method-NNMF> | <topics-method-ICA> }
    rule topics-method-SVD { 'svd' | 'SVD' | 'SingularValueDecomposition' | <SVD-phrase> }
    rule topics-method-PCA { 'pca' | 'PCA' | 'PrincipalComponentAnalysis' | <PCA-phrase> }
    rule topics-method-NNMF { 'nmf' | 'nnmf' | 'NMF' | 'NNMF' | 'NonNegativeMatrixFactorization' | 'NonnegativeMatrixFactorization' | <NNMF-phrase> }
    rule topics-method-ICA { 'ica' | 'ICA' | 'IndependentComponentAnalysis' | <ICA-phrase> }

    # Show topics table commands
    rule show-topics-command { <show-topics-table-command> }
    rule show-topics-table-command { <display-directive> <the-determiner>? <topics-table-phrase> <topics-table-parameters-spec>? }
    rule topics-table-parameters-spec { <.using-preposition> <topics-table-parameters-list> }
    rule topics-table-parameters-list { <topics-table-parameter>+ % <list-separator> }
    rule topics-table-parameter { <topics-table-number-of-table-columns> | <topics-table-number-of-terms> }

    rule number-of-table-columns-phrase { <number-of>? <table-noun>? <columns> }
    rule topics-table-number-of-table-columns { <.number-of-table-columns-phrase> <integer-value> | <integer-value> <.number-of-table-columns-phrase> }

    rule topics-table-number-of-terms {  <.number-of-terms-phrase> <integer-value> | <integer-value> <.number-of-terms-phrase> }

    rule show-thesaurus-command { <show-thesaurus-table-command> | <what-are-the-term-nns> }
    rule show-thesaurus-table-command { [ <compute-and-display> | <display-directive> ] <statistical>? <thesaurus-noun> <table-noun>? <thesaurus-table-parameters-spec>? }
    rule thesaurus-table-parameters-spec { [ <thesaurus-words-spec> | <thesaurus-table-additional-parameters-spec> ]+ }
    rule what-are-the-term-nns { <what-pronoun> <are-verb> <the-determiner>? <top-noun>? <nearest-neighbors-phrase> <thesaurus-words-spec> }
    token words-noun-colon { <words-noun> [ \h* ':' ]? }
    rule thesaurus-words-spec { [ <.for-preposition> | <.of-preposition> ] <.the-determiner>? <.words-noun-colon>? <thesaurus-words-list>}
    rule thesaurus-words-list { <mixed-quoted-variable-names-list> }
    rule thesaurus-table-additional-parameters-spec { <.using-preposition> <thesaurus-table-parameters-list> }
    rule thesaurus-table-parameters-list { <thesaurus-table-parameter>+ % <list-separator> }
    rule thesaurus-table-parameter { <topics-table-number-of-table-columns> | <thesaurus-number-of-synonyms> }

    rule thesaurus-number-of-synonyms { <.number-of-synonyms-phrase> <integer-value> | <integer-value> <.number-of-synonyms-phrase> }

    # Representation command
    rule represent-query-command { <represent-query-by-topics> | <represent-query-by-terms> }
    rule represent-query-by-topics { <represent-directive> <by-preposition> <topics-noun> <.the-determiner>? <.query-noun>? <query-spec> }
    rule represent-query-by-terms { <represent-directive> <by-preposition> <terms-noun> <.the-determiner>? <.query-noun>? <query-spec> }
    rule query-spec { <query-text> | <query-words-list> | <query-variable> }
    rule query-words-list { <variable-name>+ % ( <list-separator> | \h+ )  }
    rule query-variable { <variable-name> }
    token query-text { [\" ([ \w | '_' | '-' | '.' | \d ]+ | [\h]+)+ \"]  }
}
