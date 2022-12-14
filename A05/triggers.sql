CREATE DATABASE TESTE_TRIGGERS
GO
USE TESTE_TRIGGERS

CREATE TABLE PRODUTO(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NOME VARCHAR(60),
    QT_ESTOQUE INT DEFAULT 0
)

CREATE TABLE VENDAS(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    QUANTIDADE INT,
    ID_PROD INT FOREIGN KEY(ID_PROD) REFERENCES PRODUTO(ID)
)

INSERT VENDAS VALUES (10,1)

INSERT PRODUTO VALUES
('ARROZ', 12),
('CARNE', 52),
('FRANGO', 99),
('MACARRAO', 67),
('AMORA', 81),
('SAL', 60),
('ACUCAR', 122),
('FEIJAO', 11)


CREATE OR ALTER TRIGGER ESTOQUE_UPDATE ON VENDAS
AFTER INSERT 
AS BEGIN
    DECLARE @ID INT
    DECLARE @QUANT INT
    SELECT @ID = ID_PROD, @QUANT = QUANTIDADE FROM INSERTED
    UPDATE PRODUTO SET QT_ESTOQUE = QT_ESTOQUE - @QUANT
    FROM PRODUTO WHERE ID = @ID
END

SELECT *FROM PRODUTO
