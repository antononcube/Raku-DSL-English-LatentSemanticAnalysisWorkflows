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
  method workflow-commands-list($/) { make '(' ~ $/.values>>.made.join(" \n") ~ ')'; }

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
  method use-lsa-object($/) { make $<location-specification>.made; }

  # Create command
  method create-command($/) { make $/.values[0].made; }
  method create-simple($/) { make 'LatentSemanticAnalyzer()'; }
  method create-by-dataset($/) { make 'LatentSemanticAnalyzer(' ~ $<location-specification> ~ ')'; }

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
  method data-statistics-command($/) { make $/.values[0].made; }
  method summarize-data($/) { make '.echo_document_term_matrix_statistics()'; }
  method docs-term-matrix-statistics($/) { make '.echo_document_term_matrix_statistics()'; }

  # Statistics command
  method statistics-command($/) { make '.echo_document_term_matrix_statistics()'; }

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
  method topics-table-number-of-table-columns($/) { make 'number_of_table_columns = ' ~ $<integer-value>.made; }
  method topics-table-number-of-terms($/) { make 'number_of_terms = ' ~  $<integer-value>.made; }

  # Show thesaurus command
  method show-thesaurus-command($/) { make $/.values[0].made;  }

  # Show thesaurus table command
  method show-thesaurus-table-command($/) {
    my $res = '.echo_statistical_thesaurus(';

    if $<thesaurus-table-parameters-spec> {
      $res = $res ~ $<thesaurus-table-parameters-spec>.values>>.made.join(', ') ;
    }

    make $res ~ ')';
  }

  # What are the term NN's command
  method what-are-the-term-nns($/) { make '.echo_statistical_thesaurus(terms = ' ~ $<thesaurus-words-spec>.made ~ ')'; }

  method thesaurus-words-spec($/) { make $/.values[0].made; }
  method thesaurus-words-list($/) {
    my @words = $/.values[0].made.substr(1,*-1).subst(:g, '"', '').split(', ');
    make 'terms = [' ~ map( { '"' ~ $_ ~ '"' }, @words ).join(', ') ~ ']';
  }

  method thesaurus-table-parameters-spec($/) { make $/.values>>.made; }
  method thesaurus-table-additional-parameters-spec($/) { make $/.values>>.made; }
  method thesaurus-table-parameters-list($/) { make $<thesaurus-table-parameter>>>.made.join(', '); }
  method thesaurus-table-parameter($/) { make $/.values[0].made; }
  method thesaurus-number-of-synonyms($/) { make 'number_of_nearest_neighbors = ' ~  $<integer-value>.made; }

  # Representation commands
  method represent-query-command($/) { make $/.values[0].made; }
  method represent-query-by-topics($/) { make '.represent_by_topics(query = ' ~ $<query-spec>.made ~ ')'; }
  method represent-query-by-terms($/) { make '.represent_by_terms(query = ' ~ $<query-spec>.made ~ ')'; }
  method query-spec($/) { make $/.values[0].made; }
  method query-words-list($/) { make '"' ~ $<variable-name>>>.made.join(' ') ~ '"'; }
  method query-variable($/) { make $/.Str; }
  method query-text($/) { make $/.Str; }

  # Pipeline command overwrites
  ## Object
  method assign-pipeline-object-to($/) { make '.assign_to( ' ~ $/.values[0].made ~ ' )'; }

  ## Value
  method assign-pipeline-value-to($/) { make '.assign_value_to( ' ~ $/.values[0].made ~ ' )'; }
  method take-pipeline-value($/) { make '.take_value()'; }
  method echo-pipeline-value($/) { make '.echo_value()'; }
  method echo-pipeline-funciton-value($/) { make '.echo_function_value( ' ~ $<pipeline-function-spec>.made ~ ' )'; }

  ## Context
  method take-pipeline-context($/) { make '.take_context()'; }
  method echo-pipeline-context($/) { make '.take_context()'; }
  method echo-pipeline-function-context($/) { make '.echo_function_context( ' ~ $<pipeline-function-spec>.made ~ ' )'; }

  ## Echo messages
  method echo-command($/) { make 'echo( ' ~ $<echo-message-spec>.made ~ ' )'; }

  ## Setup code
  method setup-code-command($/) {
    make 'SETUPCODE' => q:to/SETUPEND/
    # This first two package load/import commands should be "enough."
    # The others imports are for tests and experiments
    from LatentSemanticAnalyzer import *
    import snowballstemmer
    from LatentSemanticAnalyzer.LatentSemanticAnalyzer import *
    from LatentSemanticAnalyzer.DocumentTermMatrixConstruction import *
    from LatentSemanticAnalyzer.DataLoaders import *
    SETUPEND
  }
}
