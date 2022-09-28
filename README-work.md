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

The command above should print out R code for the R package `SMRMon-R`, [AAp1].

### Natural languages

```perl6
say $_.key, "\n", $_.value, "\n"  for ($_ => ToLatentSemanticAnalysisWorkflowCode($command, $_ ) for <Bulgarian English Russian>);
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

