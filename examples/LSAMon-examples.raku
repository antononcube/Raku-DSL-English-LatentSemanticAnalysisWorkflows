use lib './lib';
use lib '.';
use DSL::English::LatentSemanticAnalysisWorkflows;

# Shortcuts
#-----------------------------------------------------------
my $pCOMMAND = DSL::English::LatentSemanticAnalysisWorkflows::Grammar;

sub lsa-parse( Str:D $command, Str:D :$rule = 'TOP' ) {
        $pCOMMAND.parse($command, :$rule);
}

sub lsa-interpret( Str:D $command,
                   Str:D:$rule = 'TOP',
                   :$actions = DSL::English::LatentSemanticAnalysisWorkflows::Actions::WL::LSAMon.new) {
        $pCOMMAND.parse( $command, :$rule, :$actions ).made;
}

#----------------------------------------------------------

#
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

my $commands = "
DSL TARGET Python-LSAMon;
use aTexts;
make document term matrix with automatic stop words and without stemming rules;
echo data summary;
echo context function Keys;
apply lsi functions global weight function idf, local term weight function none, normalizer function cosine;
extract 12 topics using method singular value decomposition and max steps 12;
show topics table with 12 columns and 10 terms;
show thesaurus table for sing, left, home;
";

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


say "\n", '=' x 60;
say '-' x 3, 'WL-LSAMon:';
say '=' x 60;

#say lsa-parse( $commands, rule => 'workflow-commands-list' );
say lsa-interpret(
        $commands,
        rule => 'workflow-commands-list',
        actions => DSL::English::LatentSemanticAnalysisWorkflows::Actions::R::LSAMon.new);
#say ToLatentSemanticAnalysisWorkflowCode($commands, 'WL-LSAMon');

say '=' x 60;

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


