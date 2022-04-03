
use DSL::English::LatentSemanticAnalysisWorkflows::Grammar;
use DSL::Shared::Actions::Bulgarian::PipelineCommand;
use DSL::Shared::Actions::Bulgarian::Standard::PipelineCommand;

class DSL::English::LatentSemanticAnalysisWorkflows::Actions::Bulgarian::Standard
        does DSL::Shared::Actions::Bulgarian::Standard::PipelineCommand
        is DSL::Shared::Actions::Bulgarian::PipelineCommand {

  # Separator
  method separator() { "\n" }

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
  method load-data($/) { make 'присвои данните: ' ~ $/.values[0].made ~ ')'; }
  method data-location-spec($/) { make $<dataset-name>.made; }
  method use-lsa-object($/) { make $<location-specification>.made; }

  # Create command
  method create-command($/) { make $/.values[0].made; }
  method create-simple($/) { make 'създай латентно семантичен анализатор'; }
  method create-by-dataset($/) { make 'създай латентно семантичен анализатор с данните: ' ~ $<location-specification> }

  # Make document-term matrix command
  method make-doc-term-matrix-command($/) {
    if $<doc-term-matrix-parameters-spec> {
      make 'направи документ-термин матрицата с параметри: ' ~ $<doc-term-matrix-parameters-spec>.made;
    } else {
      make 'направи документ-термин матрицата';
    }
  }

  method doc-term-matrix-parameters-spec($/) { make $/.values[0].made; }
  method doc-term-matrix-parameters-list($/) { make $<doc-term-matrix-parameter>>>.made.join(', '); }
  method doc-term-matrix-parameter($/) { make $/.values[0].made; }

  method doc-term-matrix-stemming-rules($/) { make $/.values[0].made; }
  method stemming-rules-spec($/) { make 'намиране нa стъблата на думите: ' ~ $/.values[0].made; }
  method no-stemming-rules-spec($/) { make 'без намиране на стъблата на думите'; }
  method stemming-spec-simple($/) {  make 'автоматично намиране нa стъблата на думите'; }

  method doc-term-matrix-stop-words($/) { make $/.values[0].made; }
  method stop-words-spec($/) { make 'спиращи думи: ' ~ $/.values[0].made; }
  method no-stop-words-spec($/) { make 'без спиращи думи' }
  method stop-words-simple-spec($/) { make 'автоматични спиращи думи'; }

  # Data transformation commands
  method data-transformation-command($/) { make 'трансформирай данните с: ' ~ $/.Str; }

  # Data statistics commands
  method data-statistics-command($/) { make $/.values[0].made; }
  method summarize-data($/) { make 'покажи обобщение на данните'; }
  method docs-term-matrix-statistics($/) { make 'покажи статистики на документната матрица';}

  # Statistics command
  method statistics-command($/) { make 'покажи статистиките'; }

  # LSI command is programmed as a role.
  method lsi-apply-command($/) { make 'приложи латентно семантично идексиращите (LSI) функции:' ~ $/.values[0].made }
  method lsi-apply-verb($/) { make $/.Str; }
  method lsi-funcs-simple-list($/) { make $<lsi-global-func>.made ~ ', ' ~ $<lsi-local-func>.made ~ ", " ~ $<lsi-normalizer-func>; }
  method lsi-funcs-list($/) { make $<lsi-func>>>.made.join(', '); }
  method lsi-func($/) { make $/.values[0].made; }
  method lsi-global-func($/) { make 'глобално теглова функция: ' ~  $/.values[0].made; }
  method lsi-global-func-idf($/) { make '"IDF"'; }
  method lsi-global-func-entropy($/) { make '"Entropy"'; }
  method lsi-global-func-sum($/) { make '"ColummStochastic"'; }
  method lsi-func-none($/) { make '"None"';}

  method lsi-local-func($/) { make 'локално теглова функция: ' ~  $/.values[0].made; }
  method lsi-local-func-frequency($/) { make '"None"'; }
  method lsi-local-func-binary($/) { make '"Binary"'; }
  method lsi-local-func-log($/) { make '"Log"'; }

  method lsi-normalizer-func($/) { make 'нормализираща функция: ' ~  $/.values[0].made; }
  method lsi-normalizer-func-sum($/) { make '"Sum"'; }
  method lsi-normalizer-func-max($/) { make '"Max"'; }
  method lsi-normalizer-func-cosine($/) { make '"Cosine"'; }

  # Topics extraction
  method topics-extraction-command($/) {
    if $<topics-parameters-spec> {
      make 'добий ' ~ $<topics-spec>.made ~ ' теми с параметри: ' ~ $<topics-parameters-spec>.made;
    } else {
      make 'добий ' ~ $<topics-spec>.made ~ ' теми';
    }
  }

  method topics-spec($/) { make $<number-value>.made; }

  method topics-parameters-spec($/) { make $<topics-parameters-list>.made; }
  method topics-parameters-list($/) { make $<topics-parameter>>>.made.join(', '); }
  method topics-parameter($/) { make $/.values[0].made; }


  method topics-max-iterations($/) { make 'максимален брой стъпки: ' ~ $<number-value>.made; }

  method topics-initialization($/) { make 'брой на инициализиращи документи: ' ~ $<number-value>.made; }

  method min-number-of-documents-per-term($/) { make 'минимален брой от документи за термин: ' ~ $<number-value>.made; }

  method topics-method($/) { make $/.values[0].made; }
  method topics-method-name($/) { make 'метод: ' ~ $/.values[0].made; }
  method topics-method-SVD($/){ make 'Разлагане по Сингулярни Стойности (SVD)'; }
  method topics-method-PCA($/){ make 'Анализ на Главните Компоненти (PCA)'; }
  method topics-method-NNMF($/){ make 'Разлагане по Неотрицателни Матрични Фактори (NNMF)'; }
  method topics-method-ICA($/){ make 'Анализ на Независими Компоненти (ICA)'; }

  # Show topics command
  method show-topics-command($/) { make $/.values[0].made;  }

  # Show topic table command
  method show-topics-table-command($/) {
    if $<topics-table-parameters-spec> {
      make 'покажи таблицата на темите чрез параметрите: ' ~ $<topics-table-parameters-spec>.made;
    } else {
      make 'покажи таблицата на темите';
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
      make 'покажи таблица със статистическо тълкуване на думите: ' ~ $<thesaurus-words-spec>.made ~ ')';
    } else {
      make 'покажи таблица със статистическия тълковен речник';
    }
  }

  # What are the term NN's command
  method what-are-the-term-nns($/) { make 'покажи таблица със статистическо тълкуване на думите: ' ~ $<thesaurus-words-spec>.made ~ ')'; }

  method thesaurus-words-spec($/) { make $/.values[0].made; }
  method thesaurus-words-list($/) {
    my @words = $/.values[0].made.substr(1,*-1).subst(:g, '"', '').split(', ');
    make '[' ~ map( { '"' ~ $_ ~ '"' }, @words ).join(', ') ~ ']';
  }

  # Representation commands
  method represent-query-command($/) { make $/.values[0].made; }
  method represent-query-by-topics($/) { make 'представи чрез теми: ' ~ $<query-spec>.made ~ ')'; }
  method represent-query-by-terms($/) { make 'представи чрез термини: ' ~ $<query-spec>.made ~ ')'; }
  method query-spec($/) { make $/.values[0].made; }
  method query-words-list($/) { make '"' ~ $<variable-name>>>.made.join(' ') ~ '"'; }
  method query-variable($/) { make $/.Str; }
  method query-text($/) { make $/.Str; }

  ## Setup code
  method setup-code-command($/) {
    make 'SETUPCODE' => '';
  }
}
