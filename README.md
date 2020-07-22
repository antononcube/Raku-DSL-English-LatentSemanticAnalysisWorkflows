# Latent Semantic Analysis Workflows 

## In brief

This Raku Perl 6 package has grammar classes and action classes for the parsing and
interpretation of spoken commands that specify Latent Semantic Analysis (LSA) workflows.

It is envisioned that the interpreters (actions) are going to target different
programming languages: R, Mathematica, Python, etc.

The generated pipelines are for the software monads 
[`LSAMon-R`](https://github.com/antononcube/R-packages/tree/master/LSAMon-R) 
and
[`LSAMon-WL`](https://github.com/antononcube/MathematicaForPrediction/blob/master/MonadicProgramming/MonadicLatentSemanticAnalysis.m),
\[AA1, AA2\].

## Installation

**1.** Install Raku (Perl 6) : https://raku.org/downloads . 

**2.** Make sure you have Zef Module Installer. 
 
   - Type in `zef` in the command line.
   - You can install the Zef Module Installer from : https://github.com/ugexe/zef .

**3.** Open a command line program. (E.g. Terminal on Mac OS X.)

**4.** Run the commands:

```
zef install https://github.com/antononcube/Raku-DSL-Shared.git
zef install https://github.com/antononcube/Raku-DSL-English-LatentSemanticAnalysisWorkflows.git
```

## Examples

Open a Raku IDE or type `raku` in the command line program. Try this Raku code:

```raku
use DSL::English::LatentSemanticAnalysisWorkflows;

say ToLatentSemanticAnalysisWorkflowCode("extract 12 topics using method NNMF and max steps 12", "R-LSAMon");
# LSAMonExtractTopics( numberOfTopics = 12, method = "NNMF",  maxSteps = 12)
``` 
    
Here is a more complicated pipeline specification:

```raku
say ToLatentSemanticAnalysisWorkflowCode(
  "create from textHamlet;
   make document term matrix with stemming FALSE and automatic stop words;
   apply LSI functions global weight function IDF, local term weight function TermFrequency, normalizer function Cosine;
   extract 12 topics using method NNMF and max steps 12 and 20 min number of documents per term;
   show topics table with 12 terms;
   show thesaurus table for king, castle, denmark;", "R-LSAMon")
```

The command above should print out R code for the R package `LSAMon-R`, \[AA1\]:

```r
LSAMonUnit(textHamlet) %>%
LSAMonMakeDocumentTermMatrix( stemWordsQ = FALSE, stopWords = NULL) %>%
LSAMonApplyTermWeightFunctions(globalWeightFunction = "IDF", localWeightFunction = "None", normalizerFunction = "Cosine") %>%
LSAMonExtractTopics( numberOfTopics = 12, method = "NNMF",  maxSteps = 12, minNumberOfDocumentsPerTerm = 20) %>%
LSAMonEchoTopicsTable(numberOfTerms = 12) %>%
LSAMonEchoStatisticalThesaurus( words = c("king", "castle", "denmark"))
```   

## Versions

The original version of this Raku package was developed/hosted at 
\[ [AA3](https://github.com/antononcube/ConversationalAgents/tree/master/Packages/Perl6/LatentSemanticAnalysisWorkflows) \].

A dedicated GitHub repository was made in order to make the installation with Raku's `zef` more direct. 
(As shown above.)
 

## References

\[AA1\] Anton Antonov,
[Latent Semantic Analysis Monad in R](https://github.com/antononcube/R-packages/tree/master/LSAMon-R),
(2019),
[R-packages at GitHub](https://github.com/antononcube/R-packages).

\[AA2\] Anton Antonov,
[Monadic Latent Semantic Analysis Mathematica package](https://github.com/antononcube/MathematicaForPrediction/blob/master/MonadicProgramming/MonadicLatentSemanticAnalysis.m),
(2017),
[MathematicaForPrediction at GitHub](https://github.com/antononcube/MathematicaForPrediction).

\[AA3\] Anton Antonov, 
[Latent Semantic Analysis Workflows Raku Package](https://github.com/antononcube/ConversationalAgents/tree/master/Packages/Perl6/LatentSemanticAnalysisWorkflows), 
(2019),
[ConversationalAgents at GitHub](https://github.com/antononcube/ConversationalAgents).