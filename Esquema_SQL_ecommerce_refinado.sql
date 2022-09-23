-- criação banco de dados e-commerce refinado
-- DROP database ecommerce_refinado;

create database IF NOT EXISTS ecommerce_refinado;
use ecommerce_refinado;



-- Cria cliente
CREATE TABLE IF NOT EXISTS CLIENTE (
  idCliente INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(128) NOT NULL,
  Sobrenome VARCHAR(128) NOT NULL,
  CEP INT,
  Cidade varchar(64),
  UF varchar(2),
  Endereco VARCHAR(64) NOT NULL,
  Bairro VARCHAR(45),
  Numero_endereco varchar(10),
  Complemento VARCHAR(45),
  CNPJ INT NULL,
  CPF INT NULL,
  Data_nascimento DATE,
  PRIMARY KEY (idCliente, Nome, Sobrenome),
  constraint CLIENTE_UNIQUE unique (CPF, CNPJ)
);

ALTER table CLIENTE auto_increment =1;

-- Cria fornecedor
CREATE TABLE IF NOT EXISTS FORNECEDOR (
  idFornecedor INT NOT NULL AUTO_INCREMENT,
  Razao_social VARCHAR(45) NOT NULL,
  Nome_fantasia VARCHAR(64) NOT NULL,
  CNPJ INT NOT NULL,
  CEP INT,
  Cidade varchar(64),
  UF varchar(2),
  Endereco VARCHAR(64) NOT NULL,
  Bairro VARCHAR(45),
  Numero_endereco varchar(10),
  Complemento VARCHAR(45),
  Avaliacao FLOAT(5) NOT NULL default 0,
  PRIMARY KEY (idFornecedor),
  constraint FORNECEDOR_UNIQUE unique (Razao_social, CNPJ)
  );

CREATE TABLE IF NOT EXISTS PRODUTO (
  idProduto INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(128) NOT NULL,
  Classficacao ENUM("Padrão", "+3 anos", "+ 6 anos", "+9 anos", "+14 anos", "+16 anos", "+18 anos") NOT NULL DEFAULT 'Padrao',
  Categoria ENUM("Automotivo", "Casa e Jardim", "Roupas Masculinas", "Roupas Femininas", "Roupas Infantis", "Escolar", "Cozinha e Alimentos", "Eletrônicos") NOT NULL DEFAULT 'Eletrônicos',
  Descricao VARCHAR(120) NOT NULL,
  Valor VARCHAR(20) NOT NULL,
  Avaliacao FLOAT(5) NOT NULL DEFAULT 0,
  Peso FLOAT NULL,
  Tamanho VARCHAR(45) NULL,
  PRIMARY KEY (idProduto)
);
ALTER table PRODUTO auto_increment =1;

-- Cria fornece
CREATE TABLE IF NOT EXISTS FORNECE (
  idProduto INT NOT NULL,
  idFornecedor INT NOT NULL,
  Quantidade INT NOT NULL,
  PRIMARY KEY (idProduto, idFornecedor),
  
  CONSTRAINT fk_FORNECE_idProduto
    FOREIGN KEY (idProduto)
    REFERENCES PRODUTO (idProduto),
CONSTRAINT fk_FORNECE_idFornecedor
    FOREIGN KEY (idFornecedor)
    REFERENCES FORNECEDOR (idFornecedor)
);

-- Cria terceiro
CREATE TABLE IF NOT EXISTS TERCEIRO (
  idTerceiro INT NOT NULL AUTO_INCREMENT,
  Razao_social VARCHAR(128) NOT NULL,
  Nome_fantasia VARCHAR(64) NOT NULL,
  CEP INT,
  Cidade varchar(64),
  UF varchar(2),
  Endereco VARCHAR(64) NOT NULL,
  Bairro VARCHAR(45),
  Numero_endereco varchar(10),
  Complemento VARCHAR(45),
  CNPJ INT,
  CPF INT,
  Avaliacao FLOAT(5) NOT NULL DEFAULT 0,
  PRIMARY KEY (idTerceiro),
  constraint TERCEIRO_UNIQUE unique (CNPJ,CPF)
 );

ALTER table TERCEIRO auto_increment =1;

-- cria aquisicao terceiro
CREATE TABLE IF NOT EXISTS AQUISICAO_TERCEIRO (
  idProduto INT NOT NULL,
  idTerceiro INT NOT NULL,
  Quantidade INT NOT NULL,
  PRIMARY KEY (idProduto, idTerceiro),
  CONSTRAINT fk_AQUISICAO_TERCEIROS_idProduto
    FOREIGN KEY (idProduto)
    REFERENCES PRODUTO (idProduto),
  CONSTRAINT fk_AQUISICAO_TERCEIROS_idTerceiro
    FOREIGN KEY (idTerceiro)
    REFERENCES TERCEIRO (idTerceiro)
);

-- Cria estoque

CREATE TABLE IF NOT EXISTS ESTOQUE (
  idEstoque INT NOT NULL AUTO_INCREMENT ,
  Capacidade_m3 INT NOT NULL,
  Usado INT NOT NULL,
  Endereco VARCHAR(128) NOT NULL default "Galpão SP 44",
  CEP VARCHAR(45) NULL,
  Quantidade_produto VARCHAR(45) NOT NULL,
  PRIMARY KEY (idEstoque)
  );

ALTER table ESTOQUE auto_increment =1;

-- Cria em estoque
CREATE TABLE IF NOT EXISTS EM_ESTOQUE (
  idProduto INT NOT NULL,
  Quantidade INT NOT NULL,
  idEstoque INT NOT NULL,
  PRIMARY KEY (idProduto, idEstoque),
  CONSTRAINT fk_EM_ESTOQUE_idProduto
    FOREIGN KEY (idProduto)
    REFERENCES PRODUTO (idProduto),
  CONSTRAINT fk_EM_ESTOQUE_idEstoque
    FOREIGN KEY (idEstoque)
    REFERENCES ESTOQUE (idEstoque)
   );

-- Cria Entrega

CREATE TABLE IF NOT EXISTS ENTREGA (
  idENTREGA INT NOT NULL auto_increment,
  Status ENUM("Separação", "Aguardando postagem", "Postado", "Em trânsito", "Entregue", "Retornado", "Devolvido") NOT NULL DEFAULT 'Em trânsito',
  Frete FLOAT NOT NULL,
  Tipo ENUM("SEDEX", "PAC", "Terceirizada", "FEDEX", "PARTICULAR") NOT NULL DEFAULT 'SEDEX',
  Data_estimada DATE,
  Cod_rastreio VARCHAR(60) NOT NULL,
  Distancia INT,
  PRIMARY KEY (idENTREGA, Frete)
);
ALTER table ENTREGA auto_increment =1;

-- Cria pedido
CREATE TABLE IF NOT EXISTS PEDIDO (
  idPedido INT NOT NULL,
  Status_pedido ENUM("Andamento", "Enviado", "Processando", "Entregue") NOT NULL default "Processando",
  idCliente INT NOT NULL,
  idProduto INT NOT NULL,
  Quantidade INT NOT NULL DEFAULT 1,
  Valor FLOAT NOT NULL,
  idENTREGA INT NOT NULL,
  Frete FLOAT NOT NULL,
  PRIMARY KEY (idPedido, Valor, idCliente, idProduto, idENTREGA, Frete),
  CONSTRAINT fk_PEDIDO_idProduto
    FOREIGN KEY (idProduto)
    REFERENCES PRODUTO (idProduto),
  CONSTRAINT fk_PEDIDO_idEntrega_Frete
    FOREIGN KEY (idENTREGA, Frete)
    REFERENCES ENTREGA (idENTREGA, Frete),
CONSTRAINT fk_PEDIDO_idEntrega_CLIENTE
    FOREIGN KEY (idCliente)
    REFERENCES CLIENTE (idCliente)
);

ALTER table PEDIDO auto_increment =1;

-- Cria carrinho
CREATE TABLE IF NOT EXISTS CARRINHO (
  idPedido INT NOT NULL,
  idCliente INT NOT NULL,
  Valor FLOAT NOT NULL,
  PRIMARY KEY (idPedido, idCliente, Valor),
  CONSTRAINT fk_CARRINHO_PEDIDO_id
    FOREIGN KEY (idPedido , Valor, idCliente)
    REFERENCES PEDIDO (idPedido, Valor, idCliente),
  CONSTRAINT fk_CARRINHO_CLIENTE
    FOREIGN KEY (idCliente)
    REFERENCES CLIENTE (idCliente)  
);
   

-- Cria pagamento
CREATE TABLE IF NOT EXISTS PAGAMENTO (
  idPagamento INT NOT NULL auto_increment,
  TIPO ENUM("PIX", "BOLETO", "CARTAO") NOT NULL default "BOLETO",
  Status_pagamento ENUM("Aguardando pagamento", "Transação concluída", "Em atraso", "Cancelado") NOT NULL,
  CPF_CNPJ INT NOT NULL,
  idPedido INT NOT NULL,
  idCliente INT NOT NULL,
  Valor FLOAT NOT NULL,
  PRIMARY KEY (Status_pagamento, idPagamento, idPedido, idCliente, Valor, CPF_CNPJ),
  CONSTRAINT fk_PAGAMENTO_CARRINHO
    FOREIGN KEY (idPedido, idCliente, Valor)
    REFERENCES CARRINHO (idPedido ,idCliente , Valor)

);
ALTER table PAGAMENTO auto_increment =1;

-- Cria PIX

CREATE TABLE IF NOT EXISTS PIX (
  Codigo_PIX VARCHAR(128) NOT NULL,
  Status_pagamento ENUM("Aguardando pagamento", "Transação concluída", "Em atraso", "Cancelado") NOT NULL,
  idPagamento INT NOT NULL,
  idPedido INT NOT NULL,
  idCliente INT NOT NULL,
  Valor FLOAT NOT NULL,
  CPF_CNPJ INT NOT NULL,
  PRIMARY KEY (Status_pagamento, idPagamento, idPedido, idCliente, Valor, CPF_CNPJ),
  CONSTRAINT fk_PIX_PAGAMENTO
    FOREIGN KEY (Status_pagamento, idPagamento, idPedido, idCliente, Valor, CPF_CNPJ)
    REFERENCES PAGAMENTO (Status_pagamento, idPagamento , idPedido, idCliente, Valor, CPF_CNPJ)
);

-- Cria Boleto 
CREATE TABLE IF NOT EXISTS BOLETO (
  Vencimento DATE NOT NULL,
  Codigo_boleto INT NOT NULL,
  Status_pagamento ENUM("Aguardando pagamento", "Transação concluída", "Em atraso", "Cancelado") NOT NULL,
  idPagamento INT NOT NULL,
  idPedido INT NOT NULL,
  idCliente INT NOT NULL,
  Valor FLOAT NOT NULL,
  CPF_CNPJ INT NOT NULL,
  PRIMARY KEY (Status_pagamento, idPagamento, idPedido, idCliente, Valor, CPF_CNPJ),
  CONSTRAINT fk_BOLETO_PAGAMENTO
    FOREIGN KEY (Status_pagamento , idPagamento , idPedido , idCliente , Valor , CPF_CNPJ)
    REFERENCES PAGAMENTO (Status_pagamento , idPagamento , idPedido,idCliente , Valor , CPF_CNPJ)
  
);

-- Cria Cartão

CREATE TABLE IF NOT EXISTS PAGAMENTO_CARTAO (
  Tipo ENUM("Credito", "Debito") NOT NULL,
  Validade DATE NOT NULL,
  Numero VARCHAR(16) NOT NULL,
  Status_pagamento ENUM("Aguardando pagamento", "Transação concluída", "Em atraso", "Cancelado") NOT NULL,
  idPagamento INT NOT NULL,
  idPedido INT NOT NULL,
  idCliente INT NOT NULL,
  Valor FLOAT NOT NULL,
  CPF_CNPJ INT NOT NULL,
  PRIMARY KEY (Numero, Status_pagamento, idPagamento, idPedido, idCliente, Valor, CPF_CNPJ),
  CONSTRAINT fk_PAGAMENTO_CARTAO_PAGAMENTO
    FOREIGN KEY (Status_pagamento , idPagamento , idPedido , idCliente , Valor , CPF_CNPJ)
    REFERENCES PAGAMENTO (Status_pagamento, idPagamento , idPedido , idCliente, Valor , CPF_CNPJ)
);
