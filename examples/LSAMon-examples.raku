#use lib <. lib>;
use DSL::English::LatentSemanticAnalysisWorkflows;

# Shortcuts
#-----------------------------------------------------------
my $pCOMMAND = DSL::English::LatentSemanticAnalysisWorkflows::Grammar;

sub lsa-parse( Str:D $command, Str:D :$rule = 'TOP' ) {
        $pCOMMAND.parse($command, :$rule);
}

sub lsa-subparse( Str:D $command, Str:D :$rule = 'TOP' ) {
    $pCOMMAND.subparse($command, :$rule);
}

sub lsa-interpret( Str:D $command,
                   Str:D:$rule = 'workflow-commands-list',
                   :$actions = DSL::English::LatentSemanticAnalysisWorkflows::Actions::Python::LSAMon.new) {
        $pCOMMAND.parse( $command, :$rule, :$actions ).made;
}

#----------------------------------------------------------

#say lsa-subparse('show statistical thesaurus for the words: interested, likely, want using 12 synonyms per word');
#say lsa-subparse('12 number of synonyms per word', rule =>'thesaurus-number-of-synonyms');
#say lsa-subparse('12 synonyms per word', rule =>'thesaurus-number-of-synonyms');
#say lsa-subparse('show statistical thesaurus for the words: interested, likely, want using 12 synonyms per word', rule =>'show-thesaurus-command');


#say $pLSAMONCOMMAND.subparse('create document term matrix with stemming rules and with stop words', rule => 'make-doc-term-matrix-command' );

#
#say DSL::English::LatentSemanticAnalysisWorkflows::Grammar.parse('apply to item term matrix entries the functions cosine');
#
#say DSL::English::LatentSemanticAnalysisWorkflows::Grammar.parse('represent by terms cosine');
#
#say DSL::English::LatentSemanticAnalysisWorkflows::Grammar.subparse('represent by topics "cosine is good"');

# say "\n=======\n";
#
#
#
#say "\n=======\n";
##
#
# say to_LSAMon_WL('
# use lsa object lsaObj;
# represent by topics "cosine is good";
# ');
#
#say "\n=======\n";
#
# say to_LSAMon_WL('
# use lsa object lsaObj;
# represent by topics cosine similarity is good;
# echo pipeline value;
# ');

# say to_LSAMon_WL('
# use lsa object lsaObj;
# apply lsi functions idf, none, cosine;
# extract 12 topics;
# ');

#my $command = '
#cóng aText chuàngjiàn;
#make document term matrix with no stemming and automatic stop words;
#echo data summary;
#apply lsi functions global weight function idf, local term weight function none, normalizer function cosine;
#extract 12 topics using method NNMF and max steps 12;
#show topics table with 12 columns and 10 terms;
#show thesaurus table for sing, left, home;
#';

#my $commands = "
#include setup code;
#use aTexts;
#make document term matrix with automatic stop words and without stemming rules;
#echo data summary;
#echo context function Keys;
#apply lsi functions global weight function idf, local term weight function none, normalizer function cosine;
#extract 12 topics using method singular value decomposition and max steps 12;
#show topics table with 12 columns and 10 terms;
#show thesaurus table for sing, left, home;
#";

#`(
my @commands = (
'DSL MODULE LSAMon;
create from textHamlet;
make document term matrix with stemming FALSE and automatic stop words;
apply LSI functions global weight function IDF, local term weight function TermFrequency, normalizer function Cosine;
extract 12 topics using method NNMF and max steps 12 and 20 min number of documents per term;
show topics table with 12 terms;
show thesaurus table for king, castle, denmark;',
);
)

my @commands = (
"create from textual data `sample(aDocs,20)`;
create document term matrix with stemming;
show document term matrix statistics;
apply term weight functions IDF, None, Cosine;
extract 60 topics with the method NNMF;
echo topics table;
show statistical thesaurus for the words: interested, likely, want using 12 synonyms per word;
show pipeline value;
echo context;
assign object to lsaObj;
"
);

#my $commands = "
#use aJobDescriptions;
#make document-term matrix;
#show terms per document statistics;
#show terms per document histogram;
#show terms per document summary;
#show docs per word statistics;
#show docs per word histogram;
#show docs per word summary;
#
#";


#my @targets = <WL-SMRMon R-SMRMon Python-SMRMon Raku-SBR>;
#my @targets = <Bulgarian English Russian>;
my @targets = <Python-LSAMon R-LSAMon Raku-LSAMon>;

for @commands -> $c {
    say "\n", '=' x 20;
    say $c.trim;
    for @targets -> $t {
        say '-' x 20;
        say $t.trim;
        say '-' x 20;
        say ToLatentSemanticAnalysisWorkflowCode($c, $t, format => 'hash');
        #say lsa-interpret($c)
    }
}


#my $commandBulgarian = '
#създай от aText;
#направи документи-термини матрица без коренуване и с автоматични стоп думи;
#отрази обобщение на данните;
#приложи lsi функциите глобално теглова функция idf, локално теглова функция none, нормализатор функция косинус;
#извлечи 12 теми, използвайки метод NNMF и максимален брой стъпки 12;
#покажи таблица с теми с 12 колони и 10 термина;
#покажи таблицата на тезауруса за пеене, вляво, вкъщи;
#';
#
#say "\n=======\n";
#
#my $commandChinese = '
#從aText創建；
#製作沒有詞乾和自動停用詞的文檔術語矩陣；
#回顯數據摘要；
#應用lsi函數全局權重函數idf，局部項權重函數none，歸一化函數餘弦；
#使用方法NNMF和最多12個步驟提取12個主題；
#顯示包含12列和10個詞的主題表；
#顯示敘詞表以便在左邊唱歌
#';


