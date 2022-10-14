-- Antes de inserir algum cliente, verifique se ele já se encontra cadastrado. Obs.: Digite o CPF apenas com números.
SELECT * 
FROM dbo.Clientes   -- O dbo é opcional neste caso.
WHERE CPF = '09577424150'

/*
Observações:
Esse dbo. é chamado de proprietario ou auner. Em empresas grandes existem auners especificos para cada sistema, pro isso é necessário utilizar.
Exemplo: ctb.transacoes; fin.transacoes.
Além disso, os selects não são cases sensegs, ou seja, pode escrever maiusculo ou minusculo, pois não leva em consideração essa diferença.
*/

-- Para inserir os registros nas linhas manualmente:
INSERT INTO dbo.Clientes
(id, indicador, nome, CPF, sexo, data_nascimento, CEP, num_casa, telefone, email, data_cadastro, login_cadastro)
VALUES
(51,6,'Carla Caroline Carvalho Silva','09577424150','F','02/06/1995','58433-483',22,'(83) 98689-2645','carlacarolinecs1@gmail.com',getdate(), 'Carla' )

INSERT INTO dbo.Pagamentos
(id, id_cliente, pago, mes_ano, valor, desconto, data_cadastro, login_cadastro)
VALUES
(19,	19,	1,	'Julho2022',	125,	0,	getdate(), 'Carla' )


/*
--Formato padrão deste BD:
51,6,'Carla Caroline Carvalho Silva','09577424150','F','02/06/1995','58433-483',22,'(83) 98689-2645','carlacarolinecs1@gmail.com','02/06/2022 09:09:000', 'Carla'
*/

----------------------------------------------------------------------------------------------------------------------------------------------
-- Mostra todas as linhas
SELECT * from Clientes
SELECT * from Pagamentos
/*
-- Deleta uma linha especifica
DELETE FROM Clientes
 WHERE id=51
-- Deleta todas as linhas da tabela
DELETE FROM dbo.Clientes
 WHERE id>0
*/

-- Observação: Inseri os dados utilizando VBA.

