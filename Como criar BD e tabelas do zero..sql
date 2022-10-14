/*Banco de dados criado para realizar um incentivo de indicação em uma academia nova. 
	- Ideia de incentivo para obter clientes e mantê-los.
	- Onde o cliente pode: não ser indicado, mais indicar ou ser indicado e indicar ou não ser indicado e não indicar.
	- Além disso o indicador recebe 5% de desconto quando indica alguem que efetuou o pagamento no mês anterior, ou seja, 
	  ele só receberá o desconto se o indicado tiver efetuado o pagamento no mês anterior. 
	- Não há limites para a quantidade de indicados.
	- Lembrando que não pode indicar quem já se encontra cadastrado.
*/


/* Criando um banco de dados:
	- Coloque o cursor sobre o nome Banco de dados;
	- Aperte o botão direito do mouse;
	- Clique na opção: Novo Banco de Dados...
	- Nomeie o banco de dados: SQL_DB_3
	- Clique em ok.

   Criando tabelas:
   Podemos criar tabelas de 2 formas, através de código ou seguindo o seguinte passo a passo:
	- Clique no + que se encontra no lado direito do nome do banco de dados: SQL_DB_2
	- Coloque o cursor sobre o nome Tabelas;
	- Aperte o botão direito do mouse;
	- Clique na opção: Novo 
	- E depois em Tabela...
	- Após isso preencha os campos(colunas).
*/

-- Criando tabelas através do código:
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
UNIQUE(CPF) -- Restrição, CPF único para impedir que o mesmo cliente se cadastre novamente.
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

--Informando ao SQL quais colunas são chaves estrangeiras
ALTER TABLE Pagamentos
ADD CONSTRAINT FK_cliente
FOREIGN KEY(id_cliente)
REFERENCES Clientes(id)

-- Para deletar a especificação de chave estrangeira.
ALTER TABLE Pagamentos DROP CONSTRAINT FK_cliente;

-- Deletando tabelas
DROP TABLE Clientes
DROP TABLE Pagamentos
