-- Cria o Banco de dados

create database DbBiblioteca;

#Referencia os proximos comandos para o banco de dados 'DbBiblioteca'
use DbBiblioteca;

-- Cria a tabela TbCategoriaLeitor

create table DbBiblioteca.TbCategoriaLeitor(
	CdCategoriaLeitor bigint primary key,
	Nome varchar(50) not  null,
	NuDias int not null default(0)
);
 
#Cria a tabela 'TbLeitor'

create table DbBiblioteca.TbLeitor(
	CdLeitor bigint primary key,
	Nome varchar(100) not null,
	Email varchar(50) not null,   
	Documento varchar(20) not null unique,
	Telefone varchar(20) not null,
	Cidade varchar(50) not null,
	Estado varchar(20) not null,
	Endereco varchar(100) not null,
	DtNascimento date not null,
	CdCategoriaLeitor bigint,
	foreign key(CdCategoriaLeitor) references DbBiblioteca.TbCategoriaLeitor(CdCategoriaLeitor)
);

#Cria a tabela 'TbCategoriaObra'

create table DbBiblioteca.TbCategoriaObra(
	CdCategoriaObra bigint primary key,
	Nome varchar(100)
);

#Cria a tabela 'TbObra'

create table DbBiblioteca.TbObra(
	CdObra bigint primary key,
	Titulo varchar(100) not null,
	CdIsbn bigint not null unique,
	Autor varchar(100) not null,	
	Keywords varchar(100),
	DtPublicacao date not null,
	NuEdicao int,
	NuPaginas bigint,
	NmEditora varchar(100),
	CdCategoriaObra bigint,
	foreign key(CdCategoriaObra) references DbBiblioteca.TbCategoriaObra(CdCategoriaObra)
);

#Cria a tabela 'TbCopia'

create table DbBiblioteca.TbCopia(
	CdCopia bigint primary key,
	Situacao varchar(100),
	Descritivo varchar(100),
	CdObra bigint,
	foreign key(CdObra) references TbObra(CdObra)
);

#Cria a tabela 'TbFuncionario'

create table DbBiblioteca.TbFuncionario(
	CdFuncionario bigint primary key,
	Nome varchar(100) not null,
	Email varchar(50) not null,
	Documento varchar(20) not null unique,
	Telefone varchar(15) not null,
	Cidade varchar(50) not null,
	Estado varchar(20) not null,
	Endereco varchar(100) not null,
	DtNascimento date not null
);

#Cria a tabela 'TbReserva'

create table DbBiblioteca.TbReserva(
	CdReserva bigint primary key,
	DtReserva timestamp not null,
	DtPrevista timestamp not null,
	Situacao varchar(50) not null,
	CdFuncionario bigint,
	CdLeitor bigint,
	CdObra bigint,
	foreign key(CdFuncionario) references TbFuncionario(CdFuncionario),
	foreign key(CdLeitor) references TbLeitor(CdLeitor),
	foreign key(CdObra) references TbObra(CdObra)
);

#Cria a tabela 'TbEmprestimo'

create table DbBiblioteca.TbEmprestimo(
	CdEmprestimo bigint primary key,
	DtEmprestimo timestamp not null,
	DtPrevistaDevolucao date not null,
	DtDevolucao date not null,
	Situacao varchar(25) not null,
	Multa decimal(12,4) not null default(0),
	CdFuncionario bigint,
	CdLeitor bigint,
	CdCopia bigint,
	foreign key(CdFuncionario) references TbFuncionario(CdFuncionario),
	foreign key(CdLeitor) references TbLeitor(CdLeitor),
	foreign key(CdCopia) references TbCopia(CdCopia)
);