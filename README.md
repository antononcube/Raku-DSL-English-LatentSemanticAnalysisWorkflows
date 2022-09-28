# Latent Semantic Analysis Workflows 

## In brief

This Raku (Perl 6) package has grammar classes and action classes for the parsing and
interpretation of natural Domain Specific Language (DSL) commands that specify
Latent Semantic Analysis (LSA) workflows.

The interpreters (actions) target different programming languages: R, Mathematica, Python, Raku.
Also, different natural languages.

The interpreters (actions) target different programming languages: R, Mathematica, Python, Raku.
Also, different natural languages.

The generated pipelines are for the software monads 
["LSAMon-R"](https://github.com/antononcube/R-packages/tree/master/LSAMon-R) 
and
["LSAMon-WL"](https://github.com/antononcube/MathematicaForPrediction/blob/master/MonadicProgramming/MonadicLatentSemanticAnalysis.m),
[AA1, AA2], and the object oriented Python implementation [AAp4].

--------------

## Installation

Zef ecosystem:

```shell
zef install DSL::English::LatentSemanticAnalysisWorkflows
```

GitHub:

```shell
zef install https://github.com/antononcube/Raku-DSL-English-LatentSemanticAnalysisWorkflows.git
```

------------

## Examples

### Programming languages

Here is a simple invocation:

```perl6
use DSL::English::LatentSemanticAnalysisWorkflows;

ToLatentSemanticAnalysisWorkflowCode("extract 12 topics using method NNMF and max steps 12", "R::LSAMon");
```
```
# LSAMonExtractTopics( numberOfTopics = 12, method = "NNMF",  maxSteps = 12)
``` 

Here is a more complicated pipeline specification used to generate the code
for recommender systems implemented in different languages:

```perl6
my $command = q:to/END/;
create from textHamlet;
make document term matrix with stemming FALSE and automatic stop words;
apply LSI functions global weight function IDF, local term weight function TermFrequency, normalizer function Cosine;
extract 12 topics using method NNMF and max steps 12 and 20 min number of documents per term;
show topics table with 12 terms;
show thesaurus table for king, castle, denmark
END

say $_.key, "\n", $_.value, "\n"  for ($_ => ToLatentSemanticAnalysisWorkflowCode($command, $_ ) for <R::LSAMon WL::LSAMon Python::LSAMon>);
```
```
# R::LSAMon
# LSAMonUnit(textHamlet) %>%
# LSAMonMakeDocumentTermMatrix( stemWordsQ = FALSE, stopWords = NULL) %>%
# LSAMonApplyTermWeightFunctions(globalWeightFunction = "IDF", localWeightFunction = "None", normalizerFunction = "Cosine") %>%
# LSAMonExtractTopics( numberOfTopics = 12, method = "NNMF",  maxSteps = 12, minNumberOfDocumentsPerTerm = 20) %>%
# LSAMonEchoTopicsTable(numberOfTerms = 12) %>%
# LSAMonEchoStatisticalThesaurus(words = c("king", "castle", "denmark"))
# 
# WL::LSAMon
# LSAMonUnit[textHamlet] \[DoubleLongRightArrow]
# LSAMonMakeDocumentTermMatrix[ "StemmingRules" -> False, "StopWords" -> Automatic] \[DoubleLongRightArrow]
# LSAMonApplyTermWeightFunctions["GlobalWeightFunction" -> "IDF", "LocalWeightFunction" -> "None", "NormalizerFunction" -> "Cosine"] \[DoubleLongRightArrow]
# LSAMonExtractTopics["NumberOfTopics" -> 12, Method -> "NNMF", "MaxSteps" -> 12, "MinNumberOfDocumentsPerTerm" -> 20] \[DoubleLongRightArrow]
# LSAMonEchoTopicsTable["NumberOfTerms" -> 12] \[DoubleLongRightArrow]
# LSAMonEchoStatisticalThesaurus["Words" -> {"king", "castle", "denmark"}]
# 
# Python::LSAMon
# LatentSemanticAnalyzer(textHamlet).make_document_term_matrix( stemming_rules = False, stop_words = None).apply_term_weight_functions(global_weight_func = "IDF", local_weight_func = "None", normalizer_func = "Cosine").extract_topics(number_of_topics = 12, method = "NNMF", max_steps = 12, min_number_of_documents_per_term = 20).echo_topics_table(numberOfTerms = 12).echo_statistical_thesaurus(["king", "castle", "denmark"])
```

### Natural languages

```perl6
say $_.key, "\n", $_.value, "\n"  for ($_ => ToLatentSemanticAnalysisWorkflowCode($command, $_ ) for <Bulgarian English Russian>);
```
```
# Bulgarian
# създай латентно семантичен анализатор с данните: textHamlet
# направи документ-термин матрицата с параметри: намиране нa стъблата на думите: false, спиращи думи: null
# приложи латентно семантично идексиращите (LSI) функции:глобално теглова функция: "IDF", локално теглова функция: "None", нормализираща функция: "Cosine"
# добий 12 теми с параметри: метод: Разлагане по Неотрицателни Матрични Фактори (NNMF), максимален брой стъпки: 12, минимален брой от документи за термин: 20
# покажи таблицата на темите чрез параметрите: numberOfTerms = 12
# покажи таблица със статистическия тълковен речник: за думите: ["king", "castle", "denmark"]
# 
# English
# create LSA object with the data: textHamlet
# make the document-term matrix with the parameters: use stemming rules: FALSE, use the stop words: NULL
# apply the latent semantic analysis (LSI) functions: global weight function : "IDF", local weight function : "None", normalizer function : "Cosine"
# extract 12 topics using the parameters: method : Non-Negative Matrix Factorization (NNMF), max number of steps : 12, min number of documents per term : 20
# show topics table using the parameters: numberOfTerms = 12
# show statistical thesaurus: for the words : ["king", "castle", "denmark"]
# 
# Russian
# создать латентный семантический анализатор с данных: textHamlet
# сделать матрицу документов-терминов с параметрами: найти основы слов: false, стоп-слова: null
# применять функции латентного семантического индексирования (LSI): глобальная весовая функция: "IDF", локальная весовая функция: "None", нормализующая функция: "Cosine"
# извлечь 12 тем с параметрами: метод: Разложение Неотрицательных Матричных Факторов (NNMF), максимальное число шагов: 12, минимальное количество документов в слово: 20
# показать таблицу темы по параметрам: numberOfTerms = 12
# показать таблицу со статистической интерпретацией слов: для слов: ["king", "castle", "denmark"]
```

------------

## Versions

The original version of this Raku package was developed/hosted at 
[ [AAp1](https://github.com/antononcube/ConversationalAgents/tree/master/Packages/Perl6/LatentSemanticAnalysisWorkflows) ].

A dedicated GitHub repository was made in order to make the installation with Raku's `zef` more direct. 
(As shown above.)
 
------------

## References

[AAp1] Anton Antonov,
[Latent Semantic Analysis Workflows Raku Package](https://github.com/antononcube/ConversationalAgents/tree/master/Packages/Perl6/LatentSemanticAnalysisWorkflows),
(2019),
[ConversationalAgents at GitHub](https://github.com/antononcube/ConversationalAgents).

[AAp2] Anton Antonov,
[Latent Semantic Analysis Monad in R](https://github.com/antononcube/R-packages/tree/master/LSAMon-R),
(2019),
[R-packages at GitHub](https://github.com/antononcube/R-packages).

[AAp3] Anton Antonov,
[Monadic Latent Semantic Analysis Mathematica package](https://github.com/antononcube/MathematicaForPrediction/blob/master/MonadicProgramming/MonadicLatentSemanticAnalysis.m),
(2017),
[MathematicaForPrediction at GitHub](https://github.com/antononcube/MathematicaForPrediction).

[AAp4] Anton Antonov,
[LatentSemanticAnalyzer Python package](https://github.com/antononcube/Python-packages/tree/main/LatentSemanticAnalyzer),
(2021),
[Python-packages at GitHub](https://github.com/antononcube/Python-packages).

