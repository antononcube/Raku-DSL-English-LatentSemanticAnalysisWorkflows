=begin comment
#==============================================================================
#
#   Python-LSAMon actions in Raku Perl 6
#   Copyright (C) 2019-2021  Anton Antonov
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
#   antononcube @ gmai l . c om,
#   Windermere, Florida, USA.
#
#==============================================================================
#
#   For more details about Raku Perl6 see https://perl6.org/ .
#
#==============================================================================
#
#   The actions are implemented for the grammar:
#
#     LatentSemanticAnalysisWorkflowsGrammar::Latent-semantic-analysis-workflow-commmand
#
#   in the file :
#
#     https://github.com/antononcube/ConversationalAgents/blob/master/Packages/Perl6/DSL::English::LatentSemanticAnalysisWorkflows/lib/LatentSemanticAnalysisWorkflowsGrammar.pm6
#
#==============================================================================
=end comment

use v6;

use DSL::English::LatentSemanticAnalysisWorkflows::Grammar;
use DSL::Shared::Actions::English::Python::PipelineCommand;

class DSL::English::LatentSemanticAnalysisWorkflows::Actions::Python::LSAMon
        is DSL::Shared::Actions::English::Python::PipelineCommand {

  # Separator
  method separator() { '' }

  # Top
  method TOP($/) { make $/.values[0].made; }

  # workflow-command-list
  method workflow-commands-list($/) { '(' ~ make $/.values>>.made.join("\n") ~ ')'; }

  # workflow-command
  method workflow-command($/) { make $/.values[0].made; }

  # General
  method variable-names-list($/) { make '[' ~ $<variable-name>>>.made.join(', ') ~ ']'; }
  method quoted-variable-names-list($/) { make '[' ~ $<quoted-variable-name>>>.made.join(', ') ~ ']'; }
  method mixed-quoted-variable-names-list($/) { make '[' ~ $<mixed-quoted-variable-name>>>.made.join(', ') ~ ']'; }
  method quoted-keyword-variable-names-list($/) { make '[' ~ $<quoted-keyword-variable-name>>>.made.join(', ') ~ ']'; }
  method mixed-quoted-keyword-variable-names-list($/) { make '[' ~ $<mixed-quoted-keyword-variable-name>>>.made.join(', ') ~ ']'; }

  # Data load commands
  method data-load-command($/) { make $/.values[0].made; }
  method load-data($/) { make '.set_data( obj, ' ~ $/.values[0].made ~ ')'; }
  method data-location-spec($/) { make $<dataset-name>.made; }
  method use-lsa-object($/) { make $<dataset-name>.made; }

  # Create command
  method create-command($/) { make $/.values[0].made; }
  method create-simple($/) { make 'LatentSemanticAnalyzer()'; }
  method create-by-dataset($/) { make 'LatentSemanticAnalyzer(' ~ $<dataset-name> ~ ')'; }

  # Make document-term matrix command
  method make-doc-term-matrix-command($/) {
    if $<doc-term-matrix-parameters-spec> {
      make '.make_document_term_matrix( ' ~ $<doc-term-matrix-parameters-spec>.made ~ ')';
    } else {
      make '.make_document_term_matrix( )';
    }
  }

  method doc-term-matrix-parameters-spec($/) { make $/.values[0].made; }
  method doc-term-matrix-parameters-list($/) { make $<doc-term-matrix-parameter>>>.made.join(', '); }
  method doc-term-matrix-parameter($/) { make $/.values[0].made; }

  method doc-term-matrix-stemming-rules($/) { make $/.values[0].made; }
  method stemming-rules-spec($/) { make 'stemming_rules = ' ~ $/.values[0].made; }
  method no-stemming-rules-spec($/) { make 'stemming_rules = False'; }
  method stemming-spec-simple($/) {  make 'stemming_rules = None'; }

  method doc-term-matrix-stop-words($/) { make $/.values[0].made; }
  method stop-words-spec($/) { make 'stop_words = ' ~ $/.values[0].made; }
  method no-stop-words-spec($/) { make 'stop_words = False' }
  method stop-words-simple-spec($/) { make 'stop_words = NULL'; }

  # Data transformation commands
  method data-transformation-command($/) { make '.failure("Not implemented yet.")'; }

  # Data statistics commands
  method data-statistics-command($/) { make '.echo_document_term_matrix_statistics()'; }

  # Statistics command
  method statistics-command($/) { make 'Not implemented'; }

  # LSI command is programmed as a role.
  method lsi-apply-command($/) { make '.apply_term_weight_functions(' ~ $/.values[0].made ~ ')'; }
  method lsi-apply-verb($/) { make $/.Str; }
  method lsi-funcs-simple-list($/) { make $<lsi-global-func>.made ~ ', ' ~ $<lsi-local-func>.made ~ ", " ~ $<lsi-normalizer-func>; }
  method lsi-funcs-list($/) { make $<lsi-func>>>.made.join(', '); }
  method lsi-func($/) { make $/.values[0].made; }
  method lsi-global-func($/) { make 'global_weight_func = ' ~  $/.values[0].made; }
  method lsi-global-func-idf($/) { make '"IDF"'; }
  method lsi-global-func-entropy($/) { make '"Entropy"'; }
  method lsi-global-func-sum($/) { make '"ColummStochastic"'; }
  method lsi-func-none($/) { make '"None"';}

  method lsi-local-func($/) { make 'local_weight_func = ' ~  $/.values[0].made; }
  method lsi-local-func-frequency($/) { make '"None"'; }
  method lsi-local-func-binary($/) { make '"Binary"'; }
  method lsi-local-func-log($/) { make '"Log"'; }

  method lsi-normalizer-func($/) { make 'normalizer_func = ' ~  $/.values[0].made; }
  method lsi-normalizer-func-sum($/) { make '"Sum"'; }
  method lsi-normalizer-func-max($/) { make '"Max"'; }
  method lsi-normalizer-func-cosine($/) { make '"Cosine"'; }

  # Topics extraction
  method topics-extraction-command($/) {
    if $<topics-parameters-spec> {
      make '.extract_topics(number_of_topics = ' ~ $<topics-spec>.made ~ ", " ~ $<topics-parameters-spec>.made ~ ")";
    } else {
      make '.extract_topics(number_of_topics = ' ~ $<topics-spec>.made ~ ")";
    }
  }

  method topics-spec($/) { make $<number-value>.made; }

  method topics-parameters-spec($/) { make $<topics-parameters-list>.made; }
  method topics-parameters-list($/) { make $<topics-parameter>>>.made.join(', '); }
  method topics-parameter($/) { make $/.values[0].made; }


  method topics-max-iterations($/) { make 'max_steps = ' ~ $<number-value>.made; }

  method topics-initialization($/) { make 'number_of_initializing_documents =' ~ $<number-value>.made; }

  method min-number-of-documents-per-term($/) { make 'min_number_of_documents_per_term = ' ~ $<number-value>.made; }

  method topics-method($/) { make $/.values[0].made; }
  method topics-method-name($/) { make 'method = ' ~ $/.values[0].made; }
  method topics-method-SVD($/){ make '"SVD"'; }
  method topics-method-PCA($/){ make '"SVD"'; }
  method topics-method-NNMF($/){ make '"NNMF"'; }
  method topics-method-ICA($/){ make '"ICA"'; }

  # Show topics command
  method show-topics-command($/) { make $/.values[0].made;  }

  # Show topic table command
  method show-topics-table-command($/) {
    if $<topics-table-parameters-spec> {
      make '.echo_topics_table(' ~ $<topics-table-parameters-spec>.made ~ ')';
    } else {
      make '.echo_topics_table( )';
    }
  }

  method topics-table-parameters-spec($/) { make $/.values[0].made; }
  method topics-table-parameters-list($/) { make $<topics-table-parameter>>>.made.join(', '); }
  method topics-table-parameter($/) { make $/.values[0].made; }
  method topics-table-number-of-table-columns($/) { make 'numberOfTableColumns = ' ~ $<integer-value>.made; }
  method topics-table-number-of-terms($/) { make 'numberOfTerms = ' ~  $<integer-value>.made; }

  # Show thesaurus command
  method show-thesaurus-command($/) { make $/.values[0].made;  }

  # Show thesaurus table command
  method show-thesaurus-table-command($/) {
    if $<thesaurus-words-spec> {
      make '.echo_statistical_thesaurus(words = ' ~ $<thesaurus-words-spec>.made ~ ')';
    } else {
      make '.echo_statistical_thesaurus( )';
    }
  }

  # What are the term NN's command
  method what-are-the-term-nns($/) { make '.echo_statistical_thesaurus(words = ' ~ $<thesaurus-words-spec>.made ~ ')'; }

  method thesaurus-words-spec($/) { make $/.values[0].made; }
  method thesaurus-words-list($/) {
    my @words = $/.values[0].made.substr(1,*-1).subst(:g, '"', '').split(', ');
    make '[' ~ map( { '"' ~ $_ ~ '"' }, @words ).join(', ') ~ ']';
  }

  # Representation commands
  method represent-query-command($/) { make $/.values[0].made; }
  method represent-query-by-topics($/) { make '.represent_by_topics(query = ' ~ $<query-spec>.made ~ ')'; }
  method represent-query-by-terms($/) { make '.represent_by_terms(query = ' ~ $<query-spec>.made ~ ')'; }
  method query-spec($/) { make $/.values[0].made; }
  method query-words-list($/) { make '"' ~ $<variable-name>>>.made.join(' ') ~ '"'; }
  method query-variable($/) { make $/.Str; }
  method query-text($/) { make $/.Str; }

  # Pipeline command overwrites

  ## Setup code
  method setup-code-command($/) {
    make 'SETUPCODE' => q:to/SETUPEND/
    from LatentSemanticAnalyzer import *
    SETUPEND
  }
}
