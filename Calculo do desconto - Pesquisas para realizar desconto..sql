-- Para Pesquisar a quantidade de indica��es:
--Individual
select * from Clientes where indicador = 1

-- Geral
select indicador, count(1) quant_indicados
from Clientes 
group by  indicador

-- Verificar os pagamentos realizados pelos indicados do cliente 1 no m�s de Julho, para que ele possa obter o desconto referente a eles no m�s de agosto. 
-- Mostra tanto os que pagaram como os que n�o pagaram
select c.id, c.indicador, c.nome, c.CPF, p. pago --, p.valor
from Clientes c, Pagamentos p 
where c.id = p.id_cliente 
     and c.indicador = 1 
	 and p.mes_ano = 'Julho2022'

-- Utilizando o inner join
select c.id, c.indicador, c.nome, c.CPF, p.pago 
from Clientes c
     inner join Pagamentos p on c.id = p.id_cliente
Where c.indicador = 1 
	 and p.mes_ano = 'Julho2022'

-- Pesquisar a quantidade de indicados que pagaram, por indicador(geral):
select  c.indicador, count(p.pago) n
from Clientes c, Pagamentos p
where  c.id = p.id_cliente    
        and c.indicador<>0   -- Todos os indicados at� esse m�s
		and p.pago= 1   -- Mostra apenas os que pagaram
		and p.mes_ano = 'Julho2022'
group by  c.indicador


-- Pesquisa o valor a ser pago pelo indicador, ap�s obter o desconto
select  c.indicador, count(p.pago) n, (0.05*count(p.pago)) desconto, (125*(0.05*count(p.pago))) valor_desconto, 125-(125*(0.05*count(p.pago))) valor
from Clientes c, Pagamentos p
where  c.id = p.id_cliente    
        and c.indicador<>0
		and p.pago= 1
		and p.mes_ano = 'Julho2022' -- M�s anterior
group by  c.indicador