-- Antes de inserir algum cliente, verifique se ele j? se encontra cadastrado. Obs.: Digite o CPF apenas com n?meros.
SELECT * 
FROM dbo.Clientes   -- O dbo ? opcional neste caso.
WHERE CPF = '09577424150'

-- O passo acima n?o ? mais necess?rio, pois coloquei o CPF como unico.

/*
Observa??es:
Esse dbo. ? chamado de proprietario ou auner. Em empresas grandes existem auners especificos para cada sistema, pro isso ? necess?rio utilizar.
Exemplo: ctb.transacoes; fin.transacoes.
Al?m disso, os selects n?o s?o cases sensegs, ou seja, pode escrever maiusculo ou minusculo, pois n?o leva em considera??o essa diferen?a.
*/

-- Para inserir os registros nas linhas manualmente:
INSERT INTO dbo.Clientes
(id, indicador, nome, CPF, sexo, data_nascimento, CEP, num_casa, telefone, email, data_cadastro, login_cadastro)
VALUES
(51,6,'Carla Galv?o de Carvalho','11111111111','F','00/00/0000','58433-483',12,'(99) 99999-9999','carlagalvaodc@gmail.com',getdate(), 'Carla' )

INSERT INTO dbo.Pagamentos
(id, id_cliente, pago, mes_ano, valor, desconto, data_cadastro, login_cadastro)
VALUES
(19,	19,	1,	'Julho2022',	125,	0,	getdate(), 'Carla' )


/*
--Formato padr?o deste BD:
51,6,'Carla Galv?o de Carvalho','11111111111','F','00/00/0000','58433-483',12,'(99) 99999-9999','carlagalvaodc@gmail.com','02/06/2022 09:09:000', 'Carla'
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

-- Observa??o: Inseri os dados utilizando VBA.

