use dataviva_raw;

-- Filtro e seleção da tabela Aluno

create table IES_2013_ALUNO_STEP1 
select CO_IES, CO_CATEGORIA_ADMINISTRATIVA, CO_ORGANIZACAO_ACADEMICA, CO_CURSO, 
CO_ALUNO, CO_GRAU_ACADEMICO, CO_MODALIDADE_ENSINO, IN_CONCLUINTE, IN_INGRESSO_TOTAL as IN_INGRESSO, 
DT_INGRESSO_CURSO, IN_SEXO_ALUNO, NU_IDADE_ALUNO, CO_COR_RACA_ALUNO, CO_UF_NASCIMENTO,
CO_MUNICIPIO_NASCIMENTO, CO_TURNO_ALUNO
from IES_2013_ALUNO
where IN_MATRICULA=1 and CO_NIVEL_ACADEMICO=1;

-- Seleção da tabela Curso
create table IES_2013_CURSO_STEP1 
select CO_MUNICIPIO_CURSO as CO_MUNICIPIO, CO_CURSO, CO_OCDE, CO_LOCAL_OFERTA as CO_LOCAL_OFERTA_IES
from IES_2013_CURSO;

-- Criando a tabela STEP2:
create table IES_2013_ALUNO_STEP2 select * from IES_2013_ALUNO_STEP1;

alter table IES_2013_ALUNO_STEP2 add (CO_MUNICIPIO varchar(8), CO_OCDE varchar(20), CO_LOCAL_OFERTA_IES varchar(30));

update IES_2013_ALUNO_STEP2 left join IES_2013_CURSO_STEP1 
on IES_2013_ALUNO_STEP2.CO_CURSO = IES_2013_CURSO_STEP1.CO_CURSO
set IES_2013_ALUNO_STEP2.CO_MUNICIPIO = IES_2013_CURSO_STEP1.CO_MUNICIPIO;

update IES_2013_ALUNO_STEP2 left join IES_2013_CURSO_STEP1 
on IES_2013_ALUNO_STEP2.CO_CURSO = IES_2013_CURSO_STEP1.CO_CURSO
set IES_2013_ALUNO_STEP2.CO_OCDE = IES_2013_CURSO_STEP1.CO_OCDE;

update IES_2013_ALUNO_STEP2 left join IES_2013_CURSO_STEP1 
on IES_2013_ALUNO_STEP2.CO_CURSO = IES_2013_CURSO_STEP1.CO_CURSO
set IES_2013_ALUNO_STEP2.CO_LOCAL_OFERTA_IES = IES_2013_CURSO_STEP1.CO_LOCAL_OFERTA_IES;

-- --------------------------------------------------------------------------------
-- Recodificações - Banco ALUNO

# Categoria Administrativa

update IES_2013_ALUNO_STEP2 set CO_CATEGORIA_ADMINISTRATIVA = 
if(CO_CATEGORIA_ADMINISTRATIVA = '       7', '       6', CO_CATEGORIA_ADMINISTRATIVA)


# Grau Acadêmico

update IES_2013_ALUNO_STEP2 set CO_GRAU_ACADEMICO = 
if(CO_GRAU_ACADEMICO = '        ', '-1', CO_GRAU_ACADEMICO);


# Ano e mes de ingresso

alter table IES_2013_ALUNO_STEP2 add (ANO_INGRESSO varchar(4), MES_INGRESSO varchar(8)) ;

select * from IES_2013_ALUNO_STEP2;


update IES_2013_ALUNO_STEP2 set MES_INGRESSO = 
if(substring(DT_INGRESSO_CURSO,2,1)='/' and substring(DT_INGRESSO_CURSO,4,1)='/',substring(DT_INGRESSO_CURSO,3,1), 
if(substring(DT_INGRESSO_CURSO,2,1)='/' and substring(DT_INGRESSO_CURSO,5,1)='/',substring(DT_INGRESSO_CURSO,3,2),
if(substring(DT_INGRESSO_CURSO,3,1)='/' and substring(DT_INGRESSO_CURSO,5,1)='/',substring(DT_INGRESSO_CURSO,4,1),
if(substring(DT_INGRESSO_CURSO,3,1)='/' and substring(DT_INGRESSO_CURSO,6,1)='/',substring(DT_INGRESSO_CURSO,4,2),0))));

update IES_2013_ALUNO_STEP2 set ANO_INGRESSO = 
if(substring(DT_INGRESSO_CURSO,2,1)='/' and substring(DT_INGRESSO_CURSO,4,1)='/',substring(DT_INGRESSO_CURSO,5,4), 
if(substring(DT_INGRESSO_CURSO,2,1)='/' and substring(DT_INGRESSO_CURSO,5,1)='/',substring(DT_INGRESSO_CURSO,6,4),
if(substring(DT_INGRESSO_CURSO,3,1)='/' and substring(DT_INGRESSO_CURSO,5,1)='/',substring(DT_INGRESSO_CURSO,6,4),
if(substring(DT_INGRESSO_CURSO,3,1)='/' and substring(DT_INGRESSO_CURSO,6,1)='/',substring(DT_INGRESSO_CURSO,7,4),0))));

-- Cor do Aluno

update IES_2013_ALUNO_STEP2 set CO_COR_RACA_ALUNO= if(CO_COR_RACA_ALUNO = '       0' or CO_COR_RACA_ALUNO = '       6', '-1', CO_COR_RACA_ALUNO);

-- UF nascimento

update IES_2013_ALUNO_STEP2 set CO_UF_NASCIMENTO = if(CO_UF_NASCIMENTO = '        ', '-1', CO_UF_NASCIMENTO);


-- Município nascimento
select CO_MUNICIPIO_NASCIMENTO, count(*) from IES_2013_ALUNO_STEP2 group by CO_MUNICIPIO_NASCIMENTO;

update IES_2013_ALUNO_STEP2 
set CO_MUNICIPIO_NASCIMENTO = if(CO_MUNICIPIO_NASCIMENTO = '        ', '-1', CO_MUNICIPIO_NASCIMENTO);


-- Turno do Aluno

select CO_TURNO_ALUNO, count(*) from IES_2013_ALUNO_STEP2 group by CO_TURNO_ALUNO;

update IES_2013_ALUNO_STEP2 set CO_TURNO_ALUNO = if(CO_TURNO_ALUNO = '        ', '-1', CO_TURNO_ALUNO);

-- Codigo do Municipio IES

select CO_MUNICIPIO, count(*) from IES_2013_ALUNO_STEP2 group by CO_MUNICIPIO;

update IES_2013_ALUNO_STEP2 set CO_MUNICIPIO = if(CO_MUNICIPIO = '        ', '-1', CO_MUNICIPIO);

-- Codigo OCDE

select CO_OCDE, count(*) from IES_2013_ALUNO_STEP1 group by CO_OCDE;
update IES_2013_ALUNO_STEP2 set CO_OCDE = if(CO_OCDE = '            ', '-1', CO_OCDE);

-- Codigo local de oferta

select CO_LOCAL_OFERTA_IES, count(*) from IES_2013_ALUNO_STEP2 group by CO_LOCAL_OFERTA_IES;

update IES_2013_ALUNO_STEP2 set CO_LOCAL_OFERTA_IES = if(CO_LOCAL_OFERTA_IES = '        ', '-1', CO_LOCAL_OFERTA_IES);


-- Organizacao Academica

select CO_ORGANIZACAO_ACADEMICA, count(*) from IES_2013_ALUNO_STEP2 group by CO_ORGANIZACAO_ACADEMICA;

update IES_2013_ALUNO_STEP2 set CO_ORGANIZACAO_ACADEMICA = if(CO_ORGANIZACAO_ACADEMICA = '       5', '       4', CO_ORGANIZACAO_ACADEMICA);


-- Criando a tabela final:
drop table if exists IES_2013_ALUNO_STEP3;
create table IES_2013_ALUNO_STEP3 select * from IES_2013_ALUNO_STEP2;

select * from IES_2013_ALUNO_STEP3;


select CO_IES, count(*) from IES_2013_ALUNO_STEP3 group by CO_IES;
select CO_CATEGORIA_ADMINISTRATIVA, count(*) from IES_2013_ALUNO_STEP3 group by CO_CATEGORIA_ADMINISTRATIVA;
select CO_ORGANIZACAO_ACADEMICA, count(*) from IES_2013_ALUNO_STEP3 group by CO_ORGANIZACAO_ACADEMICA;
select CO_CURSO, count(*) from IES_2013_ALUNO_STEP3 group by CO_CURSO;
select CO_ALUNO, count(*) from IES_2013_ALUNO_STEP3 group by CO_ALUNO;
select CO_GRAU_ACADEMICO, count(*) from IES_2013_ALUNO_STEP3 group by CO_GRAU_ACADEMICO;
select CO_MODALIDADE_ENSINO, count(*) from IES_2013_ALUNO_STEP3 group by CO_MODALIDADE_ENSINO;
select IN_CONCLUINTE, count(*) from IES_2013_ALUNO_STEP3 group by IN_CONCLUINTE;
select IN_INGRESSO, count(*) from IES_2013_ALUNO_STEP3 group by IN_INGRESSO;
select IN_SEXO_ALUNO, count(*) from IES_2013_ALUNO_STEP3 group by IN_SEXO_ALUNO;
select NU_IDADE_ALUNO, count(*) from IES_2013_ALUNO_STEP3 group by NU_IDADE_ALUNO;
select CO_COR_RACA_ALUNO, count(*) from IES_2013_ALUNO_STEP3 group by CO_COR_RACA_ALUNO;
select CO_UF_NASCIMENTO, count(*) from IES_2013_ALUNO_STEP3 group by CO_UF_NASCIMENTO;
select CO_MUNICIPIO_NASCIMENTO, count(*) from IES_2013_ALUNO_STEP3 group by CO_MUNICIPIO_NASCIMENTO;
select CO_TURNO_ALUNO, count(*) from IES_2013_ALUNO_STEP3 group by CO_TURNO_ALUNO;
select CO_MUNICIPIO, count(*) from IES_2013_ALUNO_STEP3 group by CO_MUNICIPIO;
select CO_OCDE, count(*) from IES_2013_ALUNO_STEP3 group by CO_OCDE;
select CO_LOCAL_OFERTA_IES, count(*) from IES_2013_ALUNO_STEP3 group by CO_LOCAL_OFERTA_IES;
select ANO_INGRESSO, count(*) from IES_2013_ALUNO_STEP3 group by ANO_INGRESSO;
select MES_INGRESSO, count(*) from IES_2013_ALUNO_STEP3 group by MES_INGRESSO;

-- ---------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------
-- Tabela DOCENTES

create table IES_2013_DOCENTE_STEP1 
select CO_IES, CO_CATEGORIA_ADMINISTRATIVA, CO_ORGANIZACAO_ACADEMICA, CO_DOCENTE,
CO_SITUACAO_DOCENTE, CO_ESCOLARIDADE_DOCENTE, CO_REGIME_TRABALHO, IN_SEXO_DOCENTE, 
NU_IDADE_DOCENTE, CO_COR_RACA_DOCENTE, CO_UF_NASCIMENTO, CO_MUNICIPIO_NASCIMENTO, IN_ATU_PESQUISA,
IN_ATU_POS_PRESENCIAL
from IES_2013_DOCENTE;


create table IES_2013_IES_STEP1 
select CO_IES, CO_MANTENEDORA, CO_MUNICIPIO_IES, CO_UF_IES, QT_TEC_TOTAL, IN_REFERENTE, VL_RECEITA_PROPRIA,
VL_TRANSFERENCIA, VL_OUTRA_RECEITA, VL_DES_PESSOAL_REM_DOCENTE, VL_DES_PESSOAL_REM_TECNICO,
VL_DES_PESSOAL_ENCARGO, VL_DES_CUSTEIO, VL_DES_INVESTIMENTO, VL_DES_PESQUISA, VL_DES_OUTRAS
from IES_2013_IES;

create table IES_2013_DOCENTE_STEP2 select * from IES_2013_DOCENTE_STEP1;

alter table IES_2013_DOCENTE_STEP2 add (
CO_MANTENEDORA varchar(8), 
CO_MUNICIPIO_IES varchar(8), 
CO_UF varchar(8), 
QT_TEC_TOTAL varchar(8), 
IN_REFERENTE varchar(8), 
VL_RECEITA_PROPRIA varchar(14),
VL_TRANSFERENCIA varchar(14),
VL_OUTRA_RECEITA varchar(14), 
VL_DES_PESSOAL_REM_DOCENTE varchar(14), 
VL_DES_PESSOAL_REM_TECNICO varchar(14),
VL_DES_PESSOAL_ENCARGO varchar(14), 
VL_DES_CUSTEIO varchar(14), 
VL_DES_INVESTIMENTO varchar(14), 
VL_DES_PESQUISA varchar(14), 
VL_DES_OUTRAS varchar(14));

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.CO_MANTENEDORA = IES_2013_IES_STEP1.CO_MANTENEDORA;

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.CO_MUNICIPIO_IES = IES_2013_IES_STEP1.CO_MUNICIPIO_IES;

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.CO_UF = IES_2013_IES_STEP1.CO_UF_IES;

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.QT_TEC_TOTAL = IES_2013_IES_STEP1.QT_TEC_TOTAL;

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.IN_REFERENTE = IES_2013_IES_STEP1.IN_REFERENTE;

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.VL_RECEITA_PROPRIA = IES_2013_IES_STEP1.VL_RECEITA_PROPRIA;

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.VL_TRANSFERENCIA = IES_2013_IES_STEP1.VL_TRANSFERENCIA;

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.VL_OUTRA_RECEITA = IES_2013_IES_STEP1.VL_OUTRA_RECEITA;

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.VL_DES_PESSOAL_REM_DOCENTE = IES_2013_IES_STEP1.VL_DES_PESSOAL_REM_DOCENTE;

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.VL_DES_PESSOAL_REM_TECNICO = IES_2013_IES_STEP1.VL_DES_PESSOAL_REM_TECNICO;

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.VL_DES_PESSOAL_ENCARGO = IES_2013_IES_STEP1.VL_DES_PESSOAL_ENCARGO;

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.VL_DES_CUSTEIO = IES_2013_IES_STEP1.VL_DES_CUSTEIO;

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.VL_DES_INVESTIMENTO = IES_2013_IES_STEP1.VL_DES_INVESTIMENTO;

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.VL_DES_PESQUISA = IES_2013_IES_STEP1.VL_DES_PESQUISA;

update IES_2013_DOCENTE_STEP2 left join IES_2013_IES_STEP1 
on IES_2013_DOCENTE_STEP2.CO_IES = IES_2013_IES_STEP1.CO_IES
set IES_2013_DOCENTE_STEP2.VL_DES_OUTRAS = IES_2013_IES_STEP1.VL_DES_OUTRAS;

select * from IES_2013_DOCENTE_STEP2;


select * from IES_2013_IES_STEP1 where CO_IES='5052';

-- ---------------------------------------------------------------------------------------------

-- Recodificações

select * from IES_2013_DOCENTE_STEP2;

select CO_IES, count(*) from IES_2013_DOCENTE_STEP2 group by CO_IES;

-- Categoria Administrativa
update IES_2013_DOCENTE_STEP2 set CO_CATEGORIA_ADMINISTRATIVA = 
if(CO_CATEGORIA_ADMINISTRATIVA = '7', '6', CO_CATEGORIA_ADMINISTRATIVA);

select CO_CATEGORIA_ADMINISTRATIVA, count(*) from IES_2013_DOCENTE_STEP2 group by CO_CATEGORIA_ADMINISTRATIVA;

-- Organização Acadêmica
update IES_2013_DOCENTE_STEP2 set CO_ORGANIZACAO_ACADEMICA = 
if(CO_ORGANIZACAO_ACADEMICA = '5', '4', CO_ORGANIZACAO_ACADEMICA);

select CO_ORGANIZACAO_ACADEMICA, count(*) from IES_2013_DOCENTE_STEP2 group by CO_ORGANIZACAO_ACADEMICA;

select CO_DOCENTE, count(*) from IES_2013_DOCENTE_STEP2 group by CO_DOCENTE;
select CO_SITUACAO_DOCENTE, count(*) from IES_2013_DOCENTE_STEP2 group by CO_SITUACAO_DOCENTE;
select CO_ESCOLARIDADE_DOCENTE, count(*) from IES_2013_DOCENTE_STEP2 group by CO_ESCOLARIDADE_DOCENTE;


-- Regime de trabalho
update IES_2013_DOCENTE_STEP2 set CO_REGIME_TRABALHO = 
if(CO_REGIME_TRABALHO = '        ', '-1', CO_REGIME_TRABALHO);

select CO_REGIME_TRABALHO, count(*) from IES_2013_DOCENTE_STEP2 group by CO_REGIME_TRABALHO;


select IN_SEXO_DOCENTE, count(*) from IES_2013_DOCENTE_STEP2 group by IN_SEXO_DOCENTE;
select NU_IDADE_DOCENTE, count(*) from IES_2013_DOCENTE_STEP2 group by NU_IDADE_DOCENTE;

-- COR-RACA
update IES_2013_DOCENTE_STEP2 set CO_COR_RACA_DOCENTE = 
if(CO_COR_RACA_DOCENTE = '0' OR CO_COR_RACA_DOCENTE='6', '-1', CO_COR_RACA_DOCENTE);

select CO_COR_RACA_DOCENTE, count(*) from IES_2013_DOCENTE_STEP2 group by CO_COR_RACA_DOCENTE;

-- UF NASCIMENTO
update IES_2013_DOCENTE_STEP2 set CO_UF_NASCIMENTO = 
if(CO_UF_NASCIMENTO = '        ', '-1', CO_UF_NASCIMENTO);

select CO_UF_NASCIMENTO, count(*) from IES_2013_DOCENTE_STEP2 group by CO_UF_NASCIMENTO;

-- MUNICIPIO NASCIMENTO
update IES_2013_DOCENTE_STEP2 set CO_MUNICIPIO_NASCIMENTO = 
if(CO_MUNICIPIO_NASCIMENTO = '        ', '-1', CO_MUNICIPIO_NASCIMENTO);

select CO_MUNICIPIO_NASCIMENTO, count(*) from IES_2013_DOCENTE_STEP2 group by CO_MUNICIPIO_NASCIMENTO;

-- ATUA EM PESQUISA
update IES_2013_DOCENTE_STEP2 set IN_ATU_PESQUISA = 
if(IN_ATU_PESQUISA = '        ', '-1', IN_ATU_PESQUISA);

select IN_ATU_PESQUISA, count(*) from IES_2013_DOCENTE_STEP2 group by IN_ATU_PESQUISA;

-- ATUA POS PRESENCIAL
update IES_2013_DOCENTE_STEP2 set IN_ATU_POS_PRESENCIAL = 
if(IN_ATU_POS_PRESENCIAL = '        ', '-1', IN_ATU_POS_PRESENCIAL);

select IN_ATU_POS_PRESENCIAL, count(*) from IES_2013_DOCENTE_STEP2 group by IN_ATU_POS_PRESENCIAL;


select CO_MANTENEDORA, count(*) from IES_2013_DOCENTE_STEP2 group by CO_MANTENEDORA;
select CO_MUNICIPIO_IES, count(*) from IES_2013_DOCENTE_STEP2 group by CO_MUNICIPIO_IES;
select CO_UF, count(*) from IES_2013_DOCENTE_STEP2 group by CO_UF;
select QT_TEC_TOTAL, count(*) from IES_2013_DOCENTE_STEP2 group by QT_TEC_TOTAL;
select IN_REFERENTE, count(*) from IES_2013_DOCENTE_STEP2 group by IN_REFERENTE;

select * from IES_2013_DOCENTE_STEP2;


-- Criando tabela final
drop table if exists IES_2013_DOCENTE_STEP3;
create table IES_2013_DOCENTE_STEP3 select * from IES_2013_DOCENTE_STEP2;



-- Verificacao

select CO_IES, count(*) from IES_2013_DOCENTE_STEP3 group by CO_IES;
select CO_CATEGORIA_ADMINISTRATIVA, count(*) from IES_2013_DOCENTE_STEP3 group by CO_CATEGORIA_ADMINISTRATIVA;
select CO_ORGANIZACAO_ACADEMICA, count(*) from IES_2013_DOCENTE_STEP3 group by CO_ORGANIZACAO_ACADEMICA;
select CO_DOCENTE, count(*) from IES_2013_DOCENTE_STEP3 group by CO_DOCENTE;
select CO_SITUACAO_DOCENTE, count(*) from IES_2013_DOCENTE_STEP3 group by CO_SITUACAO_DOCENTE;
select CO_ESCOLARIDADE_DOCENTE, count(*) from IES_2013_DOCENTE_STEP3 group by CO_ESCOLARIDADE_DOCENTE;
select CO_REGIME_TRABALHO, count(*) from IES_2013_DOCENTE_STEP3 group by CO_REGIME_TRABALHO;
select IN_SEXO_DOCENTE, count(*) from IES_2013_DOCENTE_STEP3 group by IN_SEXO_DOCENTE;
select NU_IDADE_DOCENTE, count(*) from IES_2013_DOCENTE_STEP3 group by NU_IDADE_DOCENTE;
select CO_COR_RACA_DOCENTE, count(*) from IES_2013_DOCENTE_STEP3 group by CO_COR_RACA_DOCENTE;
select CO_UF_NASCIMENTO, count(*) from IES_2013_DOCENTE_STEP3 group by CO_UF_NASCIMENTO;
select CO_MUNICIPIO_NASCIMENTO, count(*) from IES_2013_DOCENTE_STEP3 group by CO_MUNICIPIO_NASCIMENTO;
select CO_MUNICIPIO_NASCIMENTO, count(*) from IES_2013_DOCENTE_STEP3 group by CO_MUNICIPIO_NASCIMENTO;
select IN_ATU_PESQUISA, count(*) from IES_2013_DOCENTE_STEP3 group by IN_ATU_PESQUISA;
select IN_ATU_POS_PRESENCIAL, count(*) from IES_2013_DOCENTE_STEP3 group by IN_ATU_POS_PRESENCIAL;
select CO_MANTENEDORA, count(*) from IES_2013_DOCENTE_STEP3 group by CO_MANTENEDORA;
select CO_MUNICIPIO_IES, count(*) from IES_2013_DOCENTE_STEP3 group by CO_MUNICIPIO_IES;
select CO_UF, count(*) from IES_2013_DOCENTE_STEP3 group by CO_UF;
select QT_TEC_TOTAL, count(*) from IES_2013_DOCENTE_STEP3 group by QT_TEC_TOTAL;
select IN_REFERENTE, count(*) from IES_2013_DOCENTE_STEP3 group by IN_REFERENTE;


