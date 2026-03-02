-- Criação do banco
CREATE DATABASE oficina;

-- Conectar no banco antes de rodar o restante
-- \c oficina;

---------------------------------------------------
-- TABELA FABRICANTE
---------------------------------------------------
CREATE TABLE Fabricante (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    responsavel VARCHAR(100)
);

---------------------------------------------------
-- TABELA MODELO
-- Fabricante 1:N Modelo
---------------------------------------------------
CREATE TABLE Modelo (
    codigo_modelo SERIAL PRIMARY KEY,
    tipo VARCHAR(100) NOT NULL,
    peso NUMERIC(10,2),
    hora_teste INTEGER,
    
    fabricante_id INTEGER NOT NULL,
    CONSTRAINT fk_modelo_fabricante
        FOREIGN KEY (fabricante_id)
        REFERENCES Fabricante(codigo)
        ON DELETE RESTRICT
);

---------------------------------------------------
-- TABELA OFICINA
---------------------------------------------------
CREATE TABLE Oficina (
    codigo SERIAL PRIMARY KEY,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    responsavel VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100)
);

---------------------------------------------------
-- RELACIONAMENTO: Oficina acolhe Modelo (N:N)
---------------------------------------------------
CREATE TABLE Oficina_Modelo (
    oficina_id INTEGER,
    modelo_id INTEGER,
    
    PRIMARY KEY (oficina_id, modelo_id),
    
    CONSTRAINT fk_oficina_modelo_oficina
        FOREIGN KEY (oficina_id)
        REFERENCES Oficina(codigo)
        ON DELETE CASCADE,
        
    CONSTRAINT fk_oficina_modelo_modelo
        FOREIGN KEY (modelo_id)
        REFERENCES Modelo(codigo_modelo)
        ON DELETE CASCADE
);

---------------------------------------------------
-- TABELA MAQUINA
-- Maquina N:1 Modelo
---------------------------------------------------
CREATE TABLE Maquina (
    numero_registro SERIAL PRIMARY KEY,
    ano_fabricacao INTEGER,
    horas_uso INTEGER,
    
    modelo_id INTEGER NOT NULL,
    CONSTRAINT fk_maquina_modelo
        FOREIGN KEY (modelo_id)
        REFERENCES Modelo(codigo_modelo)
        ON DELETE RESTRICT
);

---------------------------------------------------
-- TABELA TECNICO
---------------------------------------------------
CREATE TABLE Tecnico (
    codigo_funcional SERIAL PRIMARY KEY,
    endereco VARCHAR(200),
    telefone VARCHAR(20),
    salario NUMERIC(10,2),
    qualificacao VARCHAR(100),
    
    oficina_id INTEGER NOT NULL,
    CONSTRAINT fk_tecnico_oficina
        FOREIGN KEY (oficina_id)
        REFERENCES Oficina(codigo)
        ON DELETE CASCADE
);

---------------------------------------------------
-- RELACIONAMENTO: Tecnico perito Modelo (N:N)
---------------------------------------------------
CREATE TABLE Tecnico_Modelo (
    tecnico_id INTEGER,
    modelo_id INTEGER,
    
    PRIMARY KEY (tecnico_id, modelo_id),
    
    CONSTRAINT fk_tecnico_modelo_tecnico
        FOREIGN KEY (tecnico_id)
        REFERENCES Tecnico(codigo_funcional)
        ON DELETE CASCADE,
        
    CONSTRAINT fk_tecnico_modelo_modelo
        FOREIGN KEY (modelo_id)
        REFERENCES Modelo(codigo_modelo)
        ON DELETE CASCADE
);

---------------------------------------------------
-- TABELA TESTE
-- Oficina 1:N Teste (controla)
---------------------------------------------------
CREATE TABLE Teste (
    codigo SERIAL PRIMARY KEY,
    pontuacao NUMERIC(5,2),
    resultado VARCHAR(100),
    recomendacoes TEXT,
    
    oficina_id INTEGER NOT NULL,
    tecnico_id INTEGER NOT NULL,
    
    CONSTRAINT fk_teste_oficina
        FOREIGN KEY (oficina_id)
        REFERENCES Oficina(codigo)
        ON DELETE CASCADE,
        
    CONSTRAINT fk_teste_tecnico
        FOREIGN KEY (tecnico_id)
        REFERENCES Tecnico(codigo_funcional)
        ON DELETE CASCADE
);