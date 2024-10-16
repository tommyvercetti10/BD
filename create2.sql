DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Roupa;
DROP TABLE IF EXISTS Compra;
DROP TABLE IF EXISTS HistoricoCompras;
DROP TABLE IF EXISTS Encomenda;
DROP TABLE IF EXISTS Avaliacao;
DROP TABLE IF EXISTS Promocao;
DROP TABLE IF EXISTS Pagamento;
DROP TABLE IF EXISTS Cancelamento;
DROP TABLE IF EXISTS Envio;
DROP TABLE IF EXISTS Transportadora;
DROP TABLE IF EXISTS EstadoDeEnvio;
DROP TABLE IF EXISTS Fornecedor;
DROP TABLE IF EXISTS Armazem;
DROP TABLE IF EXISTS Stock;
CREATE TABLE Cliente( 
nif numeric(9, 0) NOT NULL, 
nomeCompleto text NOT NULL, 
email text NOT NULL, 
dataNascimento date NOT NULL, 
nacionalidade text, 
genero varchar(1), 
morada text NOT NULL, 
telefone numeric(12,0) NOT NULL,
PRIMARY KEY (nif)
);
CREATE TABLE Roupa( 
idRoupa integer NOT NULL, 
categoria text NOT NULL, 
genero varchar(1) NOT NULL, 
breveDescricao text NOT NULL,
tamanho varchar(5) NOT NULL, 
cor text NOT NULL, 
composicaoEUso text NOT NULL, 
precoOriginal real NOT NULL,
PRIMARY KEY (idRoupa, tamanho)
);
CREATE TABLE Compra(
idCompra integer NOT NULL,
montante real NOT NULL,
PRIMARY KEY (idCompra)
);
CREATE TABLE HistoricoCompras(
cliente numeric(9, 0),
idRoupa integer,
tamanho varchar(5),
quantidade integer,
idCompra integer,
PRIMARY KEY (idRoupa, tamanho, idCompra),
FOREIGN KEY (cliente) references Cliente(nif),
FOREIGN KEY (idCompra) references Compra(idCompra),
FOREIGN KEY (idRoupa, tamanho) references Roupa(idRoupa, tamanho)
);
CREATE TABLE Encomenda(
idEncomenda integer,
pagamento integer,
PRIMARY KEY (idEncomenda),
FOREIGN KEY (pagamento) references Pagamento(idFatura)
);
CREATE TABLE Avaliacao(
idAvaliacao integer,
cliente numeric(9,0),
idRoupa integer,
tamanho varchar(5),
classificacao numeric(1,0) check (classificacao between 0 and 5),
comentario text NOT NULL,
dataAvaliacao date NOT NULL,
PRIMARY KEY (idAvaliacao),
FOREIGN KEY (cliente) references Cliente(nif),
FOREIGN KEY (idRoupa, tamanho) references Roupa(idRoupa, tamanho)
);
CREATE TABLE Promocao(
idPromocao integer,
idRoupa integer,
tamanho varchar(5),
percentagem real NOT NULL,
precoFinal real,
dataInicio date,
dataFim date,
PRIMARY KEY (idPromocao),
FOREIGN KEY (idRoupa, tamanho) references Roupa(idRoupa, tamanho)
);
CREATE TABLE Pagamento(
idFatura integer,
metodo text NOT NULL,
montante real NOT NULL,
dataPagamento date NOT NULL,
idCompra integer,
PRIMARY KEY (idFatura),
FOREIGN KEY (idCompra) references Compra(idCompra)
);
CREATE TABLE Cancelamento(
idProcesso integer NOT NULL,
motivo text NOT NULL,
dataInicio date NOT NULL,
dataFim date NOT NULL,
resultadoFinal varchar(10) NOT NULL,
idEncomenda integer,
PRIMARY KEY (idProcesso),
FOREIGN KEY (idEncomenda) references Encomenda(idEncomenda)
);
CREATE TABLE Envio(
idEnvio integer NOT NULL,
moradaDeEnvio text NOT NULL,
dataDeEntrega date NOT NULL,
numEncomenda integer,
PRIMARY KEY (idEnvio),
FOREIGN KEY (numEncomenda) references Encomenda(idEncomenda)
);
CREATE TABLE Transportadora(
idTransportadora integer NOT NULL,
nome text NOT NULL,
email text NOT NULL,
telefone numeric(12,0) NOT NULL,
endereco text,
paisDeOrigem text,
PRIMARY KEY (idTransportadora)
);
CREATE TABLE EstadoDeEnvio(
idEnvio integer NOT NULL,
idTransportadora integer NOT NULL,
descricao text NOT NULL,
data date NOT NULL,
local text NOT NULL,
PRIMARY KEY (idEnvio),
FOREIGN KEY (idEnvio) references Envio(idEnvio),
FOREIGN KEY (idTransportadora) references Transportadora(idTransportadora)
);
CREATE TABLE Fornecedor(
idFornecedor integer NOT NULL,
nome text NOT NULL,
email text NOT NULL,
telefone numeric(12,0) NOT NULL,
endereco text,
paisDeOrigem text,
PRIMARY KEY (idFornecedor)
);
CREATE TABLE Armazem(
idArmazem integer NOT NULL,
local text NOT NULL,
PRIMARY KEY (idArmazem)
);
CREATE TABLE Stock(
idRoupa integer NOT NULL,
tamanho varchar(5) NOT NULL,
idArmazem integer NOT NULL,
idFornecedor integer NOT NULL,
quantidade integer NOT NULL,
PRIMARY KEY (idFornecedor, idRoupa, tamanho, idArmazem),
FOREIGN KEY (idFornecedor) references Fornecedor(idFornecedor),
FOREIGN KEY (idRoupa, tamanho) references Roupa(idRoupa, tamanho),
FOREIGN KEY (idArmazem) references Armazem(idArmazem)
);

