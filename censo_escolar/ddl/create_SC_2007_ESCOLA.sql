use dataviva_raw;

create table SC_2007_ESCOLA_BLOCO( dados varchar(2000) not null);

load data local infile 'H:/Censo Escolar/Dados/2007/DADOS/TS_ESCOLA.txt'
into table SC_2007_ESCOLA_BLOCO
character set 'latin1'
fields terminated by '\t'
lines terminated by '\n';

create table SC_2007_ESCOLA select 
substring(dados,1,4) as ANO_CENSO,
substring(dados,5,8) as PK_COD_ENTIDADE,
substring(dados,13,100) as NO_ENTIDADE,
substring(dados,113,5) as COD_ORGAO_REGIONAL_INEP,
substring(dados,118,15) as DESC_SITUACAO_FUNCIONAMENTO,
substring(dados,133,2) as FK_COD_ESTADO,
substring(dados,135,2) as SIGLA,
substring(dados,137,7) as FK_COD_MUNICIPIO,
substring(dados,144,1) as ID_DEPENDENCIA_ADM,
substring(dados,145,1) as ID_LOCALIZACAO,
substring(dados,146,1) as DESC_CATEGORIA_ESCOLA_PRIVADA,
substring(dados,147,1) as ID_CONVENIADA_PP,
substring(dados,148,1) as ID_MANT_ESCOLA_PRIVADA_EMP,
substring(dados,149,1) as ID_MANT_ESCOLA_PRIVADA_ONG,
substring(dados,150,1) as ID_MANT_ESCOLA_PRIVADA_SIND,
substring(dados,151,1) as ID_MANT_ESCOLA_PRIVADA_APAE,
substring(dados,152,1) as ID_DOCUMENTO_REGULAMENTACAO,
substring(dados,153,1) as ID_LOCAL_FUNC_PREDIO_ESCOLAR,
substring(dados,154,1) as ID_LOCAL_FUNC_SALAS_EMPRESA,
substring(dados,155,1) as ID_ESCOLA_COMP_PREDIO,
substring(dados,156,1) as ID_LOCAL_FUNC_PRISIONAL,
substring(dados,157,1) as ID_LOCAL_FUNC_TEMPLO_IGREJA,
substring(dados,158,1) as ID_LOCAL_FUNC_CASA_PROFESSOR,
substring(dados,159,1) as ID_LOCAL_FUNC_GALPAO,
substring(dados,160,1) as ID_LOCAL_FUNC_OUTROS,
substring(dados,161,1) as ID_LOCAL_FUNC_SALAS_OUTRA_ESC,
substring(dados,162,1) as ID_AGUA_FILTRADA,
substring(dados,163,1) as ID_AGUA_REDE_PUBLICA,
substring(dados,164,1) as ID_AGUA_POCO_ARTESIANO,
substring(dados,165,1) as ID_AGUA_CACIMBA,
substring(dados,166,1) as ID_AGUA_FONTE_RIO,
substring(dados,167,1) as ID_AGUA_INEXISTENTE,
substring(dados,168,1) as ID_ENERGIA_REDE_PUBLICA,
substring(dados,169,1) as ID_ENERGIA_GERADOR,
substring(dados,170,1) as ID_ENERGIA_OUTROS,
substring(dados,171,1) as ID_ENERGIA_INEXISTENTE,
substring(dados,172,1) as ID_ESGOTO_REDE_PUBLICA,
substring(dados,173,1) as ID_ESGOTO_FOSSA,
substring(dados,174,1) as ID_ESGOTO_INEXISTENTE,
substring(dados,175,1) as ID_LIXO_COLETA_PERIODICA,
substring(dados,176,1) as ID_LIXO_QUEIMA,
substring(dados,177,1) as ID_LIXO_JOGA_OUTRA_AREA,
substring(dados,178,1) as ID_LIXO_RECICLA,
substring(dados,179,1) as ID_LIXO_ENTERRA,
substring(dados,180,1) as ID_LIXO_OUTROS,
substring(dados,181,1) as ID_SALA_DIRETORIA,
substring(dados,182,1) as ID_SALA_PROFESSOR,
substring(dados,183,1) as ID_LABORATORIO_INFORMATICA,
substring(dados,184,1) as ID_LABORATORIO_CIENCIAS,
substring(dados,185,1) as ID_SALA_ATENDIMENTO_ESPECIAL,
substring(dados,186,1) as ID_QUADRA_ESPORTES,
substring(dados,187,1) as ID_COZINHA,
substring(dados,188,1) as ID_BIBLIOTECA,
substring(dados,189,1) as ID_PARQUE_INFANTIL,
substring(dados,190,1) as ID_SANITARIO_FORA_PREDIO,
substring(dados,191,1) as ID_SANITARIO_DENTRO_PREDIO,
substring(dados,192,1) as ID_SANITARIO_PNE,
substring(dados,193,1) as ID_DEPENDENCIAS_PNE,
substring(dados,194,1) as ID_DEPENDENCIAS_OUTRAS,
substring(dados,195,4) as NUM_SALAS_EXISTENTES,
substring(dados,199,4) as NUM_SALAS_UTILIZADAS,
substring(dados,203,1) as ID_EQUIP_TV,
substring(dados,204,1) as ID_EQUIP_VIDEOCASSETE,
substring(dados,205,1) as ID_EQUIP_DVD,
substring(dados,206,1) as ID_EQUIP_PARABOLICA,
substring(dados,207,1) as ID_EQUIP_COPIADORA,
substring(dados,208,1) as ID_EQUIP_RETRO,
substring(dados,209,1) as ID_EQUIP_IMPRESSORA,
substring(dados,210,1) as ID_EQUIP_IMPRESSORA_BRAILE,
substring(dados,211,1) as ID_COMPUTADORES,
substring(dados,212,4) as NUM_COMPUTADORES,
substring(dados,216,4) as NUM_COMP_ADMINISTRATIVOS,
substring(dados,220,4) as NUM_COMP_ALUNOS,
substring(dados,224,1) as ID_INTERNET,
substring(dados,225,4) as NUM_FUNCIONARIOS,
substring(dados,229,4) as NUM_LIVROS_DEV_2SERIE,
substring(dados,233,4) as NUM_LIVROS_DEV_3SERIE,
substring(dados,237,4) as NUM_LIVROS_DEV_4SERIE,
substring(dados,241,4) as NUM_LIVROS_DEV_5SERIE,
substring(dados,245,4) as NUM_LIVROS_DEV_6SERIE,
substring(dados,249,4) as NUM_LIVROS_DEV_7SERIE,
substring(dados,253,4) as NUM_LIVROS_DEV_8SERIE,
substring(dados,257,4) as NUM_LIVROS_REU_2SERIE,
substring(dados,261,4) as NUM_LIVROS_REU_3SERIE,
substring(dados,265,4) as NUM_LIVROS_REU_4SERIE,
substring(dados,269,4) as NUM_LIVROS_REU_5SERIE,
substring(dados,273,4) as NUM_LIVROS_REU_6SERIE,
substring(dados,277,4) as NUM_LIVROS_REU_7SERIE,
substring(dados,281,4) as NUM_LIVROS_REU_8SERIE,
substring(dados,285,1) as ID_ALIMENTACAO,
substring(dados,286,1) as ID_MOD_ENS_REGULAR,
substring(dados,287,1) as ID_REG_INFANTIL_CRECHE,
substring(dados,288,1) as ID_REG_INFANTIL_PREESCOLA,
substring(dados,289,1) as ID_REG_FUND_8_ANOS,
substring(dados,290,1) as ID_REG_FUND_9_ANOS,
substring(dados,291,1) as ID_REG_MEDIO_MEDIO,
substring(dados,292,1) as ID_REG_MEDIO_INTEGRADO,
substring(dados,293,1) as ID_REG_MEDIO_NORMAL,
substring(dados,294,1) as ID_REG_MEDIO_PROF,
substring(dados,295,1) as ID_MOD_ENS_ESP,
substring(dados,296,1) as ID_ESP_INFANTIL_CRECHE,
substring(dados,297,1) as ID_ESP_INFANTIL_PREESCOLA,
substring(dados,298,1) as ID_ESP_FUND_8_ANOS,
substring(dados,299,1) as ID_ESP_FUND_9_ANOS,
substring(dados,300,1) as ID_ESP_MEDIO_MEDIO,
substring(dados,301,1) as ID_ESP_MEDIO_INTEGRADO,
substring(dados,302,1) as ID_ESP_MEDIO_NORMAL,
substring(dados,303,1) as ID_ESP_PROFISSIONAL,
substring(dados,304,1) as ID_ESP_EJA_FUNDAMENTAL,
substring(dados,305,1) as ID_ESP_EJA_MEDIO,
substring(dados,306,1) as ID_MOD_EJA,
substring(dados,307,1) as ID_EJA_FUNDAMENTAL,
substring(dados,308,1) as ID_EJA_MEDIO,
substring(dados,309,1) as ID_LOCALIZACAO_DIFERENCIADA,
substring(dados,310,1) as ID_MATERIAL_ESP_ETNICO,
substring(dados,311,1) as ID_EDUCACAO_INDIGENA,
substring(dados,312,1) as ID_LINGUA_INDIGENA,
substring(dados,313,4) as FK_COD_LINGUA_INDIGENA,
substring(dados,317,1) as ID_LINGUA_PORTUGUESA,
substring(dados,318,4) as NUM_ALUNOS_ATEND_ESCOLA,
substring(dados,322,4) as NUM_ALUNOS_ATEND_OUTRA_ESCOLA,
substring(dados,326,4) as NUM_ALUNOS_ED_COMP_ESCOLA,
substring(dados,330,4) as NUM_ALUNOS_ED_COMP_OUTRA,
substring(dados,334,1) as ID_EJA_ORGANIZACAO_SEM,
substring(dados,335,1) as ID_EJA_ORGANIZACAO_ANUAL,
substring(dados,336,4) as NUM_ALUNOS_EJA_1A4_NOVOS_1SEM,
substring(dados,340,4) as NUM_ALUNOS_EJA_5A8_NOVOS_1SEM,
substring(dados,344,4) as NUM_ALUNOS_EJA_MED_NOVOS_1SEM,
substring(dados,348,4) as NUM_ALUNOS_EJA_1A4_APROV_1SEM,
substring(dados,352,4) as NUM_ALUNOS_EJA_5A8_APROV_1SEM,
substring(dados,356,4) as NUM_ALUNOS_EJA_MED_APROV_1SEM,
substring(dados,360,4) as NUM_ALUNOS_EJA_1A4_NOVOS_2SEM,
substring(dados,364,4) as NUM_ALUNOS_EJA_5A8_NOVOS_2SEM,
substring(dados,368,4) as NUM_ALUNOS_EJA_MED_NOVOS_2SEM,
substring(dados,372,4) as NUM_ALUNOS_EJA_1A4_APROV_2SEM,
substring(dados,376,4) as NUM_ALUNOS_EJA_5A8_APROV_2SEM,
substring(dados,380,4) as NUM_ALUNOS_EJA_MED_APROV_2SEM
from SC_2007_ESCOLA_BLOCO;

