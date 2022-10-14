/*Banco de dados criado para realizar um incentivo de indica��o em uma academia nova. 
	- Ideia de incentivo para obter clientes e mant�-los.
	- Onde o cliente pode: n�o ser indicado, mais indicar ou ser indicado e indicar ou n�o ser indicado e n�o indicar.
	- Al�m disso o indicador recebe 5% de desconto quando indica alguem que efetuou o pagamento no m�s anterior, ou seja, 
	  ele s� receber� o desconto se o indicado tiver efetuado o pagamento no m�s anterior. 
	- N�o h� limites para a quantidade de indicados.
	- Lembrando que n�o pode indicar quem j� se encontra cadastrado.
*/


/* Criando um banco de dados:
	- Coloque o cursor sobre o nome Banco de dados;
	- Aperte o bot�o direito do mouse;
	- Clique na op��o: Novo Banco de Dados...
	- Nomeie o banco de dados: SQL_DB_3
	- Clique em ok.

   Criando tabelas:
   Podemos criar tabelas de 2 formas, atrav�s de c�digo ou seguindo o seguinte passo a passo:
	- Clique no + que se encontra no lado direito do nome do banco de dados: SQL_DB_2
	- Coloque o cursor sobre o nome Tabelas;
	- Aperte o bot�o direito do mouse;
	- Clique na op��o: Novo 
	- E depois em Tabela...
	- Ap�s isso preencha os campos(colunas).
*/

-- Criando tabelas atrav�s do c�digo:
CREATE TABLE Clientes
(
id int PRIMARY KEY NOT NULL, 
indicador int, 
nome varchar(200) NOT NULL,
CPF varchar(11) NOT NULL, -- Exemplo: "15428560606" 
sexo varchar(1), -- "M" Masculino ou "F" Feminino
data_nascimento date,
CEP varchar(10) NOT NULL,   -- Exemplo: "58433-483"
num_casa int NOT NULL,
telefone varchar(15),		-- Exemplo: "(83) 98689-2645"
email varchar(200),
data_cadastro datetime NOT NULL,
login_cadastro varchar(15) NOT NULL
UNIQUE(CPF) -- Restri��o, CPF �nico para impedir que o mesmo cliente se cadastre novamente.
);

CREATE TABLE Pagamentos
(
id int PRIMARY KEY NOT NULL, 
id_cliente int NOT NULL,
pago bit NOT NULL,  --Exemplo: 1- True e 0- False
mes_ano varchar(15) NOT NULL, -- Exemplo: Junho2022
valor float(6) NOT NULL,
desconto float(6) NOT NULL,
data_cadastro datetime NOT NULL,
login_cadastro varchar(15) NOT NULL
);

--Informando ao SQL quais colunas s�o chaves estrangeiras
ALTER TABLE Pagamentos
ADD CONSTRAINT FK_cliente
FOREIGN KEY(id_cliente)
REFERENCES Clientes(id)

-- Para deletar a especifica��o de chave estrangeira.
ALTER TABLE Pagamentos DROP CONSTRAINT FK_cliente;

-- Deletando tabelas
DROP TABLE Clientes
DROP TABLE Pagamentos
