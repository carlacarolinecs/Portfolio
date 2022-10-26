/*
Objetivo: Descobrir
				- O lucro recebido no mês 
				- Valor perdido com o desconto 
				- Valor ganho com os indicados
*/

-- Valor perdido com o desconto por mês (1)
SELECT  p.mes_ano, COUNT(1)*125 Receita_Bruta, SUM(p.valor) Receita_liquida, (COUNT(1)*125)-SUM(p.valor) Despesa
FROM Clientes c
	inner join Pagamentos p on c.id = p.id_cliente
GROUP BY p.mes_ano

-- Valor ganho com os novos indicados no mês de Julho (2)
SELECT  p.mes_ano, COUNT(1)*125 Receita_Bruta, SUM(p.valor) Receita_liquida, (COUNT(1)*125)-SUM(p.valor) Despesa 
FROM Clientes c
	inner join Pagamentos p on c.id = p.id_cliente
WHERE c.indicador > 0 -- Alguem que foi indicado
	 and p.valor=125 -- As pessoas que foram indicadas, mas que indicaram muda esse valor, por 
	 and month(c.data_cadastro) = 7 -- um cliente que foi indicado e não indicou ninguem vai ser contado de novo, por isso será necessário utilizar data_cadastro.
	 --DATEPART(month, c.data_cadastro) = 7 ou month(c.data_cadastro) = 7 é a mesma coisa
GROUP BY p.mes_ano

-- Valor ganho com os novos indicados por mês (3): Tem que pegar a primeira vez que ele aparece na tabela pagamentos
SELECT  DATEPART(month, c.data_cadastro) Mês, COUNT(1)*125 Receita_Bruta, SUM(p.valor) Receita_liquida, (COUNT(1)*125)-SUM(p.valor) Despesa
FROM Clientes c
	inner join Pagamentos p on c.id = p.id_cliente
WHERE c.indicador > 0 -- Alguem que foi indicado
	  and p.valor=125 -- As pessoas que foram indicadas, mas que indicaram muda esse valor
	  and DATEPART(year, c.data_cadastro) = '2022'
GROUP BY  DATEPART(month, c.data_cadastro)


/*Lucro
Receita_liquida(3) - Despesa(1)
-- Receita_liquida(3): O que eles arrecadaram com o incentivo, ou seja, com os indicados.
-- Despesa(1): O que eles deixaram de arrecadar com os indicadores.

Foi calculado:
	- Lucro mensal no ano de 2022 
	- Lucro mensal -- Geral
	- Lucro no ano de 2022 --individual
	- Lucro anual -- Geral
	- Lucro acumulado ( Soma dos lucros)
*/

-- Lucro mensal no ano de 2022 
Select d.mes_ano ,r.Receita_liquida - d.Despesa as Lucro_mensal_2022
FROM (
	SELECT  DATEPART(month, c.data_cadastro) Mês, COUNT(1)*125 Receita_Bruta, SUM(p.valor) Receita_liquida, (COUNT(1)*125)-SUM(p.valor) Despesa
	FROM Clientes c
		inner join Pagamentos p on c.id = p.id_cliente
	WHERE c.indicador > 0 -- Alguem que foi indicado
		and p.valor=125 -- As pessoas que foram indicadas, mas que indicaram muda esse valor 
		and DATEPART(year, c.data_cadastro) = '2022'
	GROUP BY  DATEPART(month, c.data_cadastro)
	 ) r,
	 (
	SELECT  p.mes_ano, COUNT(1)*125 Receita_Bruta, SUM(p.valor) Receita_liquida, (COUNT(1)*125)-SUM(p.valor) Despesa
	FROM Clientes c
		inner join Pagamentos p on c.id = p.id_cliente
	WHERE YEAR(p.data_cadastro) = '2022'
	GROUP BY p.mes_ano
	) d

-- Lucro mensal
-- Se eu colocar um lucro mensal tirando DATEPART(year, c.data_cadastro) = '2022' e YEAR(p.data_cadastro) = '2022' do where, poderá calcular errado, pois no primeiro somará todos com 7, independente do ano e este será subtraido do segundo que é julho de 2022. Por isso utilizei DATEPART(year, c.data_cadastro) no group by para contornar isso.
Select r.Ano, r.Mês ,r.Receita_liquida - d.Despesa as Lucro_mensal
FROM (
	SELECT  DATEPART(year, c.data_cadastro) Ano, DATEPART(month, c.data_cadastro) Mês, COUNT(1)*125 Receita_Bruta, SUM(p.valor) Receita_liquida, (COUNT(1)*125)-SUM(p.valor) Despesa
	FROM Clientes c
		inner join Pagamentos p on c.id = p.id_cliente
	WHERE c.indicador > 0 -- Alguem que foi indicado
		and p.valor=125 -- As pessoas que foram indicadas, mas que indicaram muda esse valor 
	GROUP BY  DATEPART(year, c.data_cadastro), DATEPART(month, c.data_cadastro)
	 ) r,
	 (
	SELECT  p.mes_ano, COUNT(1)*125 Receita_Bruta, SUM(p.valor) Receita_liquida, (COUNT(1)*125)-SUM(p.valor) Despesa
	FROM Clientes c
		inner join Pagamentos p on c.id = p.id_cliente
	GROUP BY p.mes_ano
	) d

-- Lucro no ano de 2022 --individual
Select SUM(r.Receita_liquida) - SUM(d.Despesa) as Lucro_2022
FROM (
	SELECT  DATEPART(month, c.data_cadastro) Mês, COUNT(1)*125 Receita_Bruta, SUM(p.valor) Receita_liquida, (COUNT(1)*125)-SUM(p.valor) Despesa
	FROM Clientes c
		inner join Pagamentos p on c.id = p.id_cliente
	WHERE c.indicador > 0 -- Alguem que foi indicado
		and p.valor=125 -- As pessoas que foram indicadas, mas que indicaram muda esse valor 
		and DATEPART(year, c.data_cadastro) = '2022'
	GROUP BY  DATEPART(month, c.data_cadastro)
	 ) r,
	 (
	SELECT  p.mes_ano, COUNT(1)*125 Receita_Bruta, SUM(p.valor) Receita_liquida, (COUNT(1)*125)-SUM(p.valor) Despesa
	FROM Clientes c
		inner join Pagamentos p on c.id = p.id_cliente
	WHERE YEAR(p.data_cadastro) = '2022'
	GROUP BY p.mes_ano
	) d

-- Lucro anual -- Geral
Select d.Ano, r.Receita_liquida, d.Despesa, r.Receita_liquida - d.Despesa as Lucro_anual
FROM (
	SELECT  DATEPART(year, c.data_cadastro) Mês, COUNT(1)*125 Receita_Bruta, SUM(p.valor) Receita_liquida, (COUNT(1)*125)-SUM(p.valor) Despesa
	FROM Clientes c
		inner join Pagamentos p on c.id = p.id_cliente
	WHERE c.indicador > 0 -- Alguem que foi indicado
		and p.valor=125 -- As pessoas que foram indicadas, mas que indicaram muda esse valor 
	GROUP BY  DATEPART(year, c.data_cadastro)
	 ) r,
	 (
	SELECT YEAR(p.data_cadastro) Ano, COUNT(1)*125 Receita_Bruta, SUM(p.valor) Receita_liquida, (COUNT(1)*125)-SUM(p.valor) Despesa
	FROM Clientes c
		inner join Pagamentos p on c.id = p.id_cliente
	GROUP BY YEAR(p.data_cadastro)
	) d

-- Lucro acumulado ( Soma dos lucros)
Select SUM(r.Receita_liquida) Total_RecLiq, SUM(d.Despesa) Total_Desp, SUM(r.Receita_liquida) - SUM(d.Despesa) as Lucro_acumulado
FROM (
	SELECT  DATEPART(month, c.data_cadastro) Mês, COUNT(1)*125 Receita_Bruta, SUM(p.valor) Receita_liquida, (COUNT(1)*125)-SUM(p.valor) Despesa
	FROM Clientes c
		inner join Pagamentos p on c.id = p.id_cliente
	WHERE c.indicador > 0 -- Alguem que foi indicado
		and p.valor=125 -- As pessoas que foram indicadas, mas que indicaram muda esse valor 
	GROUP BY  DATEPART(month, c.data_cadastro)
	 ) r,
	 (
	SELECT  p.mes_ano, COUNT(1)*125 Receita_Bruta, SUM(p.valor) Receita_liquida, (COUNT(1)*125)-SUM(p.valor) Despesa
	FROM Clientes c
		inner join Pagamentos p on c.id = p.id_cliente
	GROUP BY p.mes_ano
	) d



