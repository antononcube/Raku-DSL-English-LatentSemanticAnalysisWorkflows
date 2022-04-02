
use DSL::English::LatentSemanticAnalysisWorkflows::Grammar;
use DSL::Shared::Actions::English::PipelineCommand;
use DSL::Shared::Actions::English::Standard::PipelineCommand;

class DSL::English::LatentSemanticAnalysisWorkflows::Actions::English::Standard
        does DSL::Shared::Actions::English::Standard::PipelineCommand
        is DSL::Shared::Actions::English::PipelineCommand {

  # Separator
  method separator() { "\n" }

  # Top
  method TOP($/) { make $/.values[0].made; }

  # workflow-command-list
  method workflow-commands-list($/) { make $/.values>>.made.join(" %>%\n"); }

  # workflow-command
  method workflow-command($/) { make $/.values[0].made; }

  # General
  method variable-names-list($/) { make '(' ~ $<variable-name>>>.made.join(', ') ~ ')'; }
  method quoted-variable-names-list($/) { make '(' ~ $<quoted-variable-name>>>.made.join(', ') ~ ')'; }
  method mixed-quoted-variable-names-list($/) { make '(' ~ $<mixed-quoted-variable-name>>>.made.join(', ') ~ ')'; }
  method quoted-keyword-variable-names-list($/) { make '(' ~ $<quoted-keyword-variable-name>>>.made.join(', ') ~ ')'; }
  method mixed-quoted-keyword-variable-names-list($/) { make '(' ~ $<mixed-quoted-keyword-variable-name>>>.made.join(', ') ~ ')'; }

  # Trivial
  method trivial-parameter($/) { make $/.values[0].made; }
  method trivial-parameter-none($/) { make 'NA'; }
  method trivial-parameter-empty($/) { make 'c()'; }
  method trivial-parameter-automatic($/) { make 'NULL'; }
  method trivial-parameter-false($/) { make 'FALSE'; }
  method trivial-parameter-true($/) { make 'TRUE'; }


  # Data load commands
  method data-load-command($/) { make $/.values[0].made; }
  method load-data($/) { make 'LSAMonSetData(' ~ $/.values[0].made ~ ')'; }
  method data-location-spec($/) { make $<dataset-name>.made; }
  method use-lsa-object($/) { make $<location-specification>.made; }

  # Create command
  method create-command($/) { make $/.values[0].made; }
  method create-simple($/) { make 'create LSA object'; }
  method create-by-dataset($/) { make 'create LSA object with the data: ' ~ $<location-specification>; }

  # Make document-term matrix command
  method make-doc-term-matrix-command($/) {
    if $<doc-term-matrix-parameters-spec> {
      make 'make the document-term matrix with the parameters: ' ~ $<doc-term-matrix-parameters-spec>.made;
    } else {
      make 'make the document-term matrix';
    }
  }

  method doc-term-matrix-parameters-spec($/) { make $/.values[0].made; }
  method doc-term-matrix-parameters-list($/) { make $<doc-term-matrix-parameter>>>.made.join(', '); }
  method doc-term-matrix-parameter($/) { make $/.values[0].made; }

  method doc-term-matrix-stemming-rules($/) { make $/.values[0].made; }
  method stemming-rules-spec($/) { make 'use stemming rules: ' ~ $/.values[0].made; }
  method no-stemming-rules-spec($/) { make 'do not use stemming rules'; }
  method stemming-spec-simple($/) {  make 'use automatica stemming rules'; }

  method doc-term-matrix-stop-words($/) { make $/.values[0].made; }
  method stop-words-spec($/) { make 'use the stop words: ' ~ $/.values[0].made; }
  method no-stop-words-spec($/) { make 'do not use stop words'; }
  method stop-words-simple-spec($/) { make 'use automatic stop words'; }

  # Data transformation commands
  method data-transformation-command($/) { make 'transform data'; }

  # Data statistics commands
  method data-statistics-command($/) { make $/.values[0].made; }
  method summarize-data($/) { make 'show data summary'; }
  method docs-term-matrix-statistics($/) { make 'show document-term matrix statistics'; }

  # Statistics command
  method statistics-command($/) { make 'show statistics'; }

  # LSI command is programmed as a role.
  method lsi-apply-command($/) { make 'apply the latent semantic analysis (LSI) functions: ' ~ $/.values[0].made; }
  method lsi-apply-verb($/) { make $/.Str; }
  method lsi-funcs-simple-list($/) { make $<lsi-global-func>.made ~ ', ' ~ $<lsi-local-func>.made ~ ", " ~ $<lsi-normalizer-func>; }
  method lsi-funcs-list($/) { make $<lsi-func>>>.made.join(', '); }
  method lsi-func($/) { make $/.values[0].made; }
  method lsi-global-func($/) { make 'global weight function : ' ~  $/.values[0].made; }
  method lsi-global-func-idf($/) { make '"IDF"'; }
  method lsi-global-func-entropy($/) { make '"Entropy"'; }
  method lsi-global-func-sum($/) { make '"ColummStochastic"'; }
  method lsi-func-none($/) { make '"None"';}

  method lsi-local-func($/) { make 'local weight function : ' ~  $/.values[0].made; }
  method lsi-local-func-frequency($/) { make '"None"'; }
  method lsi-local-func-binary($/) { make '"Binary"'; }
  method lsi-local-func-log($/) { make '"Log"'; }

  method lsi-normalizer-func($/) { make 'normalizer function : ' ~  $/.values[0].made; }
  method lsi-normalizer-func-sum($/) { make '"Sum"'; }
  method lsi-normalizer-func-max($/) { make '"Max"'; }
  method lsi-normalizer-func-cosine($/) { make '"Cosine"'; }

  # Topics extraction
  method topics-extraction-command($/) {
    if $<topics-parameters-spec> {
      make 'extract ' ~ $<topics-spec>.made ~ ' topics using the parameters: ' ~ $<topics-parameters-spec>.made;
    } else {
      make 'extract ' ~ $<topics-spec>.made ~ ' topics';
    }
  }

  method topics-spec($/) { make $<number-value>.made; }

  method topics-parameters-spec($/) { make $<topics-parameters-list>.made; }
  method topics-parameters-list($/) { make $<topics-parameter>>>.made.join(', '); }
  method topics-parameter($/) { make $/.values[0].made; }


  method topics-max-iterations($/) { make 'max number of steps : ' ~ $<number-value>.made; }

  method topics-initialization($/) { make 'number of initializing documents : ' ~ $<number-value>.made; }

  method min-number-of-documents-per-term($/) { make 'min number of documents per term : ' ~ $<number-value>.made; }

  method topics-method($/) { make $/.values[0].made; }
  method topics-method-name($/) { make 'method : ' ~ $/.values[0].made; }
  method topics-method-SVD($/){ make 'Singular Value Decomposition (SVD)'; }
  method topics-method-PCA($/){ make 'Principal Component Analysis (PCA)'; }
  method topics-method-NNMF($/){ make 'Non-Negative Matrix Factorization (NNMF)'; }
  method topics-method-ICA($/){ make 'Independent Component Analysis (ICA)'; }

  # Show topics command
  method show-topics-command($/) { make $/.values[0].made;  }

  # Show topic table command
  method show-topics-table-command($/) {
    if $<topics-table-parameters-spec> {
      make 'show topics table using the parameters: ' ~ $<topics-table-parameters-spec>.made ~ ')';
    } else {
      make 'show topics table';
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
      make 'show statistical thesaurus for the words : ' ~ $<thesaurus-words-spec>.made;
    } else {
      make 'show statistical thesaurus';
    }
  }

  # What are the term NN's command
  method what-are-the-term-nns($/) { make 'show statistical thesaurus for the words : ' ~ $<thesaurus-words-spec>.made; }

  method thesaurus-words-spec($/) { make $/.values[0].made; }
  method thesaurus-words-list($/) {
    my @words = $/.values[0].made.substr(2,*-1).subst(:g, '"', '').split(', ');
    make 'c(' ~ map( { '"' ~ $_ ~ '"' }, @words ).join(', ') ~ ')';
  }

  # Representation commands
  method represent-query-command($/) { make $/.values[0].made; }
  method represent-query-by-topics($/) { make 'represent by topics the query : ' ~ $<query-spec>.made; }
  method represent-query-by-terms($/) { make 'represent by terms the query : ' ~ $<query-spec>.made; }
  method query-spec($/) { make $/.values[0].made; }
  method query-words-list($/) { make '"' ~ $<variable-name>>>.made.join(' ') ~ '"'; }
  method query-variable($/) { make $/.Str; }
  method query-text($/) { make $/.Str; }

  ## Setup code
  method setup-code-command($/) {
    make 'SETUPCODE' => ''
  }
}
