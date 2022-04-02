=begin comment
#==============================================================================
#
#   LSAMon-R actions in Raku Perl 6
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
use DSL::Shared::Actions::English::R::PipelineCommand;

class DSL::English::LatentSemanticAnalysisWorkflows::Actions::R::LSAMon
        is DSL::Shared::Actions::English::R::PipelineCommand {

  # Separator
  method separator() { " %>%\n" }

  # Top
  method TOP($/) { make $/.values[0].made; }

  # workflow-command-list
  method workflow-commands-list($/) { make $/.values>>.made.join(" %>%\n"); }

  # workflow-command
  method workflow-command($/) { make $/.values[0].made; }

  # General
  method variable-names-list($/) { make 'c(' ~ $<variable-name>>>.made.join(', ') ~ ')'; }
  method quoted-variable-names-list($/) { make 'c(' ~ $<quoted-variable-name>>>.made.join(', ') ~ ')'; }
  method mixed-quoted-variable-names-list($/) { make 'c(' ~ $<mixed-quoted-variable-name>>>.made.join(', ') ~ ')'; }
  method quoted-keyword-variable-names-list($/) { make 'c(' ~ $<quoted-keyword-variable-name>>>.made.join(', ') ~ ')'; }
  method mixed-quoted-keyword-variable-names-list($/) { make 'c(' ~ $<mixed-quoted-keyword-variable-name>>>.made.join(', ') ~ ')'; }

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
  method create-simple($/) { make 'LSAMonUnit()'; }
  method create-by-dataset($/) { make 'LSAMonUnit(' ~ $<location-specification> ~ ')'; }

  # Make document-term matrix command
  method make-doc-term-matrix-command($/) {
    if $<doc-term-matrix-parameters-spec> {
      make 'LSAMonMakeDocumentTermMatrix( ' ~ $<doc-term-matrix-parameters-spec>.made ~ ')';
    } else {
      make 'LSAMonMakeDocumentTermMatrix()';
    }
  }

  method doc-term-matrix-parameters-spec($/) { make $/.values[0].made; }
  method doc-term-matrix-parameters-list($/) { make $<doc-term-matrix-parameter>>>.made.join(', '); }
  method doc-term-matrix-parameter($/) { make $/.values[0].made; }

  method doc-term-matrix-stemming-rules($/) { make $/.values[0].made; }
  method stemming-rules-spec($/) { make 'stemWordsQ = ' ~ $/.values[0].made; }
  method no-stemming-rules-spec($/) { make 'stemWordsQ = FALSE'; }
  method stemming-spec-simple($/) {  make 'stemWordsQ = TRUE, stemRules = NULL'; }

  method doc-term-matrix-stop-words($/) { make $/.values[0].made; }
  method stop-words-spec($/) { make 'stopWords = ' ~ $/.values[0].made; }
  method no-stop-words-spec($/) { make 'stopWords = FALSE'; }
  method stop-words-simple-spec($/) { make 'stopWords = NULL'; }

  # Data transformation commands
  method data-transformation-command($/) { make 'LSMonFailure("Not implemented yet.")'; }

  # Data statistics commands
  method data-statistics-command($/) { make $/.values[0].made; }
  method summarize-data($/) { make 'LSAMonEchoDocumentTermMatrixStatistics()'; }
  method docs-term-matrix-statistics($/) { make 'LSAMonEchoDocumentTermMatrixStatistics(logBase = 10)'; }

  # Statistics command
  method statistics-command($/) { make 'LSAMonEchoDocumentTermMatrixStatistics(logBase=10)'; }

  # LSI command is programmed as a role.
  method lsi-apply-command($/) { make 'LSAMonApplyTermWeightFunctions(' ~ $/.values[0].made ~ ')'; }
  method lsi-apply-verb($/) { make $/.Str; }
  method lsi-funcs-simple-list($/) { make $<lsi-global-func>.made ~ ', ' ~ $<lsi-local-func>.made ~ ", " ~ $<lsi-normalizer-func>; }
  method lsi-funcs-list($/) { make $<lsi-func>>>.made.join(', '); }
  method lsi-func($/) { make $/.values[0].made; }
  method lsi-global-func($/) { make 'globalWeightFunction = ' ~  $/.values[0].made; }
  method lsi-global-func-idf($/) { make '"IDF"'; }
  method lsi-global-func-entropy($/) { make '"Entropy"'; }
  method lsi-global-func-sum($/) { make '"ColummStochastic"'; }
  method lsi-func-none($/) { make '"None"';}

  method lsi-local-func($/) { make 'localWeightFunction = ' ~  $/.values[0].made; }
  method lsi-local-func-frequency($/) { make '"None"'; }
  method lsi-local-func-binary($/) { make '"Binary"'; }
  method lsi-local-func-log($/) { make '"Log"'; }

  method lsi-normalizer-func($/) { make 'normalizerFunction = ' ~  $/.values[0].made; }
  method lsi-normalizer-func-sum($/) { make '"Sum"'; }
  method lsi-normalizer-func-max($/) { make '"Max"'; }
  method lsi-normalizer-func-cosine($/) { make '"Cosine"'; }

  # Topics extraction
  method topics-extraction-command($/) {
    if $<topics-parameters-spec> {
      make 'LSAMonExtractTopics( numberOfTopics = ' ~ $<topics-spec>.made ~ ", " ~ $<topics-parameters-spec>.made ~ ")";
    } else {
      make 'LSAMonExtractTopics( mumberOfTopics = ' ~ $<topics-spec>.made ~ ")";
    }
  }

  method topics-spec($/) { make $<number-value>.made; }

  method topics-parameters-spec($/) { make $<topics-parameters-list>.made; }
  method topics-parameters-list($/) { make $<topics-parameter>>>.made.join(', '); }
  method topics-parameter($/) { make $/.values[0].made; }


  method topics-max-iterations($/) { make ' maxSteps = ' ~ $<number-value>.made; }

  method topics-initialization($/) { make ' numberOfInitializingDocuments =' ~ $<number-value>.made; }

  method min-number-of-documents-per-term($/) { make 'minNumberOfDocumentsPerTerm = ' ~ $<number-value>.made; }

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
      make 'LSAMonEchoTopicsTable(' ~ $<topics-table-parameters-spec>.made ~ ')';
    } else {
      make 'LSAMonEchoTopicsTable()';
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
      make 'LSAMonEchoStatisticalThesaurus( words = ' ~ $<thesaurus-words-spec>.made ~ ')';
    } else {
      make 'LSAMonEchoStatisticalThesaurus()';
    }
  }

  # What are the term NN's command
  method what-are-the-term-nns($/) { make 'LSAMonEchoStatisticalThesaurus( words = ' ~ $<thesaurus-words-spec>.made ~ ')'; }

  method thesaurus-words-spec($/) { make $/.values[0].made; }
  method thesaurus-words-list($/) {
    my @words = $/.values[0].made.substr(2,*-1).subst(:g, '"', '').split(', ');
    make 'c(' ~ map( { '"' ~ $_ ~ '"' }, @words ).join(', ') ~ ')';
  }

  # Representation commands
  method represent-query-command($/) { make $/.values[0].made; }
  method represent-query-by-topics($/) { make 'LSAMonRepresentByTopics( query = ' ~ $<query-spec>.made ~ ')'; }
  method represent-query-by-terms($/) { make 'LSAMonRepresentByTerms( query = ' ~ $<query-spec>.made ~ ')'; }
  method query-spec($/) { make $/.values[0].made; }
  method query-words-list($/) { make '"' ~ $<variable-name>>>.made.join(' ') ~ '"'; }
  method query-variable($/) { make $/.Str; }
  method query-text($/) { make $/.Str; }

  # Pipeline command overwrites
  ## Object
  method assign-pipeline-object-to($/) { make '(function(x) { assign( x = "' ~ $/.values[0].made ~ '", value = x, envir = .GlobalEnv ); x })'; }

  ## Value
  method assign-pipeline-value-to($/) { make '(function(x) { assign( x = "' ~ $/.values[0].made ~ '", value = LSAMonTakeValue(x), envir = .GlobalEnv ); x })'; }
  method take-pipeline-value($/) { make 'LSAMonTakeValue()'; }
  method echo-pipeline-value($/) { make 'LSAMonEchoValue()'; }
  method echo-pipeline-funciton-value($/) { make 'LSAMonEchoFunctionValue( ' ~ $<pipeline-function-spec>.made ~ ' )'; }

  ## Context
  method take-pipeline-context($/) { make 'LSAMonTakeContext()'; }
  method echo-pipeline-context($/) { make 'LSAMonEchoContext'; }
  method echo-pipeline-function-context($/) { make 'LSAMonEchoFunctionContext( ' ~ $<pipeline-function-spec>.made ~ ' )'; }

  ## Echo messages
  method echo-command($/) { make 'LSAMonEcho( ' ~ $<echo-message-spec>.made ~ ' )'; }

  ## Setup code
  method setup-code-command($/) {
    make 'SETUPCODE' => q:to/SETUPEND/
      #devtools::install_github(repo = "antononcube/R-packages", subdir = "NonNegativeMatrixFactorization")
      #devtools::install_github(repo = "antononcube/R-packages", subdir = "LSAMon-R")
      library(magrittr)
      library(irlba)
      library(NonNegativeMatrixFactorization)
      library(LSAMon)
      SETUPEND
  }
}
