DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente( 
nif numeric(9, 0) PRIMARY KEY, 
nomeCompleto text NOT NULL, 
email text NOT NULL, 
dataNascimento date NOT NULL, 
nacionalidade text, 
genero varchar(1), 
morada text NOT NULL, 
telefone numeric(12,0) NOT NULL 
);
DROP TABLE IF EXISTS Roupa;
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
DROP TABLE IF EXISTS Compra;
CREATE TABLE Compra(
idCompra integer NOT NULL PRIMARY KEY,
montante real NOT NULL
);
DROP TABLE IF EXISTS HistoricoCompras;
CREATE TABLE HistoricoCompras(
cliente numeric(9, 0) references Cliente(nif),
roupa integer,
tamanho varchar(5),
quantidade integer,
idCompra integer,
PRIMARY KEY (roupa, tamanho, idCompra),
FOREIGN KEY (idCompra) references Compra(idCompra),
FOREIGN KEY (roupa, tamanho) references Roupa(idRoupa, tamanho)
);
DROP TABLE IF EXISTS Encomenda;
CREATE TABLE Encomenda(
numEncomenda integer PRIMARY KEY,
pagamento integer references Pagamento(fatura)
);
DROP TABLE IF EXISTS Avaliacao;
CREATE TABLE Avaliacao(
idAvaliacao integer PRIMARY KEY,
cliente numeric(9,0) references Cliente(nif),
idRoupa integer,
tamanho varchar(5),
classificacao numeric(1,0) check (classificacao between 0 and 5),
comentario text NOT NULL,
dataAvaliacao date NOT NULL,
FOREIGN KEY (idRoupa, tamanho) references Roupa(idRoupa, tamanho)
);
DROP TABLE IF EXISTS Promocao;
CREATE TABLE Promocao(
idPromocao integer PRIMARY KEY,
roupa integer,
tamanho varchar(5),
percentagem real NOT NULL,
precoFinal real,
dataInicio date,
dataFim date,
FOREIGN KEY (roupa, tamanho) references Roupa(idRoupa, tamanho)
);
DROP TABLE IF EXISTS Pagamento;
CREATE TABLE Pagamento(
fatura integer PRIMARY KEY,
metodo text NOT NULL,
montante real NOT NULL,
dataPagamento date NOT NULL,
compra integer references Compra(idCompra)
);
DROP TABLE IF EXISTS Cancelamento;
CREATE TABLE Cancelamento(
numProcesso integer NOT NULL PRIMARY KEY,
motivo text NOT NULL,
dataInicio date NOT NULL,
dataFim date NOT NULL,
resultadoFinal varchar(10) NOT NULL,
encomenda integer references Encomenda(numEncomenda)
);
DROP TABLE IF EXISTS Envio;
CREATE TABLE Envio(
idEnvio integer NOT NULL PRIMARY KEY,
moradaDeEnvio text NOT NULL,
dataDeEntrega date NOT NULL,
numEncomenda integer references Encomenda(numEncomenda)
);
DROP TABLE IF EXISTS Transportadora;
CREATE TABLE Transportadora(
idTransportadora integer NOT NULL PRIMARY KEY,
nome text NOT NULL,
email text NOT NULL,
telefone numeric(12,0) NOT NULL,
endereco text,
paisDeOrigem text
);
DROP TABLE IF EXISTS EstadoDeEnvio;
CREATE TABLE EstadoDeEnvio(
envio integer NOT NULL,
transportadora integer NOT NULL,
descricao text NOT NULL,
data date NOT NULL,
local text NOT NULL,
PRIMARY KEY (envio),
FOREIGN KEY (envio) references Envio(idEnvio),
FOREIGN KEY (transportadora) references Transportadora(idTransportadora)
);
DROP TABLE IF EXISTS Fornecedor;
CREATE TABLE Fornecedor(
idFornecedor integer NOT NULL PRIMARY KEY,
nome text NOT NULL,
email text NOT NULL,
telefone numeric(12,0) NOT NULL,
endereco text,
paisDeOrigem text
);
DROP TABLE IF EXISTS Armazem;
CREATE TABLE Armazem(
idArmazem integer NOT NULL PRIMARY KEY,
local text NOT NULL
);
DROP TABLE IF EXISTS Stock;
CREATE TABLE Stock(
roupa integer NOT NULL,
tamanho varchar(5) NOT NULL,
armazem integer NOT NULL,
fornecedor integer NOT NULL,
quantidade integer NOT NULL,
PRIMARY KEY (fornecedor, roupa, tamanho, armazem),
FOREIGN KEY (fornecedor) references Fornecedor(idFornecedor),
FOREIGN KEY (roupa, tamanho) references Roupa(idRoupa, tamanho),
FOREIGN KEY (armazem) references Armazem(idArmazem)
);

