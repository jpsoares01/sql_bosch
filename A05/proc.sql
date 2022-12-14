CREATE OR ALTER PROC MAIS_QUE @CPF VARCHAR(11)
AS BEGIN
    DECLARE @GASTOS FLOAT
 
    SELECT @GASTOS = SUM(INF.PREÇO*INF.QUANTIDADE) FROM [NOTAS FISCAIS]NF
    JOIN [ITENS NOTAS FISCAIS]INF ON INF.NUMERO = NF.NUMERO
    WHERE NF.CPF = @CPF;

    SELECT NF.CPF, CL.NOME, SUM(INF.QUANTIDADE*INF.PREÇO) AS [VALOR TOTAL] FROM [NOTAS FISCAIS]NF
    JOIN [TABELA DE CLIENTES]CL ON CL.CPF = NF.CPF 
    JOIN [ITENS NOTAS FISCAIS]INF ON INF.NUMERO = NF.NUMERO
    GROUP BY NF.CPF, CL.NOME
    HAVING SUM(INF.QUANTIDADE*INF.PREÇO) > @GASTOS    
END

EXEC MAIS_QUE '7771579779'

