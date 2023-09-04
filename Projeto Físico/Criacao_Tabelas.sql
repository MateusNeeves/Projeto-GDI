-----------------------
--CRIACAO DAS TABELAS--
-----------------------

-- CRIA TABELA CONTA
    CREATE TABLE CONTA(
    USERNAME VARCHAR(15),
    SALDO NUMBER(7, 2),
    LOC_PAIS VARCHAR(20),
    LOC_ESTADO VARCHAR(20),
    LOC_CIDADE VARCHAR(20),
    EM_USO NUMBER(1),
    USERNAME_REDE VARCHAR(15),
    CONSTRAINT PK_CONTA PRIMARY KEY (USERNAME),
    CONSTRAINT FK_CONTA_REDE UNIQUE (USERNAME_REDE),
    CONSTRAINT BOOLEAN CHECK (EM_USO IN (0, 1))
);

-- CRIA TABELA AMIGO
CREATE TABLE AMIGO(
    USERNAME1 VARCHAR(15),
    USERNAME2 VARCHAR(15),
    DATA_AMIZADE DATE,
    CONSTRAINT PK_AMIGO PRIMARY KEY (USERNAME1, USERNAME2),
    CONSTRAINT FK_CONTA_AMIGO1 FOREIGN KEY (USERNAME1) REFERENCES CONTA,
    CONSTRAINT FK_CONTA_AMIGO2 FOREIGN KEY (USERNAME2) REFERENCES CONTA
);

-- CRIA TABELA USUARIO
CREATE TABLE USUARIO(
    CODIGO VARCHAR(5),
    CONSTRAINT PK_USUARIO PRIMARY KEY (CODIGO)
);

-- CRIA TABELA TEM_ACESSO
CREATE TABLE TEM_ACESSO(
    USERNAME VARCHAR(15),
    CODIGO VARCHAR(5),
    CONSTRAINT PK_ACESSO PRIMARY KEY (USERNAME, CODIGO),
    CONSTRAINT FK_USUARIO_ACESSO FOREIGN KEY (CODIGO) REFERENCES USUARIO,
    CONSTRAINT FK_CONTA_ACESSO FOREIGN KEY (USERNAME) REFERENCES CONTA
);

-- CRIA TABELA EMPRESA
CREATE TABLE EMPRESA(
    CNPJ VARCHAR(14),
    NOME VARCHAR(20),
    CONSTRAINT PK_EMPRESA PRIMARY KEY (CNPJ)
);


-- CRIA TABELA APLICATIVO
CREATE TABLE APLICATIVO(
    CODIGO VARCHAR(5),
    NOME VARCHAR(20),
    PRECO_ATUAL NUMBER(5,2),
    DATA_LANCAMENTO DATE,
    CNPJ_DESENVOLVEDOR VARCHAR(14),
    CNPJ_DISTRIBUIDOR VARCHAR(14),
    CONSTRAINT PK_APLICATIVO PRIMARY KEY (CODIGO),
    CONSTRAINT FK_APLICATIVO_DESENVOLVEDOR FOREIGN KEY (CNPJ_DESENVOLVEDOR) REFERENCES EMPRESA,
    CONSTRAINT FK_APLICATIVO_DISTRIBUIDOR FOREIGN KEY (CNPJ_DISTRIBUIDOR) REFERENCES EMPRESA
);

-- CRIA TABELA CATEGORIA
CREATE TABLE CATEGORIA(
    CODIGO VARCHAR(5),
    CATEG VARCHAR(20),
    CONSTRAINT PK_CATEGORIA PRIMARY KEY (CODIGO, CATEG),
    CONSTRAINT FK_APLICATIVO_CATEGORIA FOREIGN KEY (CODIGO) REFERENCES APLICATIVO
);

-- CRIA TABELA JOGO
CREATE TABLE JOGO(
    CODIGO VARCHAR(5),
    CONSTRAINT PK_JOGO PRIMARY KEY (CODIGO),
    CONSTRAINT FK_APLICATIVO_JOGO FOREIGN KEY (CODIGO) REFERENCES APLICATIVO
);

-- CRIA TABELA SOFTWARE
CREATE TABLE SOFTWARE(
    CODIGO VARCHAR(5),
    CONSTRAINT PK_SOFTWARE PRIMARY KEY (CODIGO),
    CONSTRAINT FK_APLICATIVO_SOFTWARE FOREIGN KEY (CODIGO) REFERENCES APLICATIVO
);

-- CRIA TABELA EXPANSAO
CREATE TABLE EXPANSAO(
    CODIGO_JOGO VARCHAR(5),
	CODIGO_EXPANSAO VARCHAR(5),
    NOME VARCHAR(20),
    CONSTRAINT PK_EXPANSAO PRIMARY KEY (CODIGO_JOGO),
    CONSTRAINT FK_EXPANSAO_JOGO FOREIGN KEY (CODIGO_JOGO) REFERENCES JOGO
);

-- CRIA TABELA COMPRA
CREATE TABLE COMPRA(
    USERNAME VARCHAR(15),
    CODIGO VARCHAR(5),
    PRECO_COMPRA NUMBER(5,2),
    DATA_COMPRA DATE,
    CONSTRAINT PK_COMPRA PRIMARY KEY (USERNAME, CODIGO),
    CONSTRAINT FK_COMPRA_CONTA FOREIGN KEY (USERNAME) REFERENCES CONTA,
    CONSTRAINT FK_COMPRA_APLICATIVO FOREIGN KEY (CODIGO) REFERENCES APLICATIVO
);

-- CRIA TABELA HISTORICO_EXEC
CREATE TABLE HISTORICO_EXEC(
    CODIGO_USUARIO VARCHAR(5),
    USERNAME_LOGADO VARCHAR(15),
    CODIGO_APP VARCHAR(5),
    INICIO DATE,
    FIM DATE,
    CONSTRAINT PK_HISTORICO PRIMARY KEY (CODIGO_USUARIO, USERNAME_LOGADO, CODIGO_APP, INICIO),
    CONSTRAINT FK_HISTORICO_USUARIO FOREIGN KEY (CODIGO_USUARIO) REFERENCES USUARIO,
    CONSTRAINT FK_HISTORICO_LOGADO FOREIGN KEY (USERNAME_LOGADO) REFERENCES CONTA,
    CONSTRAINT FK_HISTORICO_APLICATIVO FOREIGN KEY (CODIGO_APP) REFERENCES APLICATIVO
);

-- CRIA TABELA CONQUISTA
CREATE TABLE CONQUISTA(
    CODIGO_CONQUISTA VARCHAR(5),
    NOME VARCHAR(20),
    DESCRICAO VARCHAR(100),
    RARIDADE VARCHAR(15),
    CODIGO_USUARIO VARCHAR(5),
    USERNAME_LOGADO VARCHAR(15),
    CODIGO_APP VARCHAR(5),
    INICIO DATE,
    CONSTRAINT PK_CONQUISTA PRIMARY KEY (CODIGO_CONQUISTA),
    CONSTRAINT FK_CONQUISTA_HISTORICO FOREIGN KEY (CODIGO_USUARIO, USERNAME_LOGADO, CODIGO_APP, INICIO) REFERENCES HISTORICO_EXEC
);
