use ecommerce_refinado;
SHOW TABLES;
desc CLIENTE;

Insert INTO CLIENTE (Nome, Sobrenome, Endereco, Cidade, UF)
    Values ("Lucas", "Silva", "Rua nove", "São João", "SP"),
		   ("Ana", 'Miranda', "Rua Robalo", "Cobra Cega", "MG"),
			("Ametista", "Fálvio", "Rua João Campos", "Acapulco", "MG"),
			("Joelma", 'Mônaco', "Rua Iquique", "Marajoara Perdido", "GO");
   
    SELECT * from CLIENTE;
   
Insert INTO FORNECEDOR (Razao_social, Nome_fantasia, CNPJ,Endereco, Cidade, UF, Avaliacao)
    Values  ("João Gabriel Multimarcas", "JG Celulares", "12331465" , "Rua dos Engenheiros", "Cabra Brava", "RJ", 4),
			("Aparecido Colchões SA", "Colchões do Cido", "1298785" , "Rua dos Pilotos", "Vaca Atolada", "RJ", 3),
            ("Noel Importados PPE", "Noel Presentes", "65485665" , "Rua dos Duendes", "Pomar de Souza", "AC", 2.5);
 
 SELECT * from FORNECEDOR;
 
Insert INTO TERCEIRO (Razao_social, Nome_fantasia, CNPJ,Endereco, Cidade, UF, Avaliacao)
    Values  ("Paulo Madeira", "Serralheria do Paulão", "145865" , "Rua dos Eucaliptos", "Avião da Serra", "ES", 2),
			("Almira equipamentos domésticos SA", "Colchões do Cido", "1298785" , "Rua Alva", "Maui", "PR", 4),
            ("Maiko Chein Lou Importados", "Eletrônicos Lou", "6856845" , "Rua dos Irajás", "Engenheiro Soares", "ES", 3.5);
            
Insert INTO PRODUTO (Nome, Descricao, Valor, Avaliacao)
    Values  ("Bumerangue v129" , "Bumerangue Australiano importado com design anatômico", 125, 5),
			("Raquete XOZIKA" , "Raquete elétrica para combate ao aedes em vôo, acompanha juliete", 40, 2.4),
            ("Carrinho Marquinhos" , "Réplica do renomado carro falante da PIXAR", 52, 1.5);            

SELECT * from PRODUTO;

Insert INTO FORNECE (idProduto, idFornecedor, Quantidade)
    Values  (1,2,5),
			(2,1,3),
            (3,1,1); 
            
   SELECT * from FORNECE;    
   
Insert INTO AQUISICAO_TERCEIRO (idProduto, idTerceiro, Quantidade)
    Values  (1,2,4),
			(2,1,2),
            (3,3,1); 
            
	SELECT * from AQUISICAO_TERCEIRO;  
    
Insert INTO ESTOQUE (Capacidade_m3, Usado, Endereco, Quantidade_produto)
    Values  (50000, 20000, "GALPÃO SP 44", 125889);

SELECT * from ESTOQUE;  

Insert INTO EM_ESTOQUE ( idEstoque, idProduto, Quantidade)
    Values  (1, 1, 5),
			(1, 2, 44),
            (1, 3, 125);
            
SELECT * from EM_ESTOQUE;
            
Insert INTO ENTREGA (Frete, Cod_rastreio)
    Values  (10, "AJSOIDAOI032132"),
			(15, "ADIJK3904U3"),
            (18, "A50938400332309");

SELECT * from ENTREGA;

Insert INTO PEDIDO (idCliente, idProduto, Quantidade, Valor, idENTREGA, Frete )
    Values  (1, 1, 5, 150, 1, 10),
			(2, 2, 2, 200, 2, 15),
            (3, 1, 1, 150, 3, 25);
            
SELECT * from PEDIDO;

Insert INTO CARRINHO (idPedido ,idCliente, Valor)
    Values  (1,2,155),
			(2,4,200),
            (1,5,300);
            
SELECT * from CARRINHO;


Insert INTO PAGAMENTO (idPedido , CPF_CNPJ, idCliente, Valor)
    Values  (1, 146445658, 2, 155),
			(2, 67897896, 4, 200),
            (1, 87985648974, 5, 300);
            
SELECT * from PAGAMENTO;

Insert INTO PIX (Codigo_PIX, idPagamento, idPedido , idCliente, Valor, CPF_CNPJ)
    Values  ("dawedawd869", 2, 2, 5,510,464894),
			("rq3wr3q4asd", 6, 4, 2, 551,4984458),
            ("ad6541w89wd", 8, 5, 3, 150,169589418);
            
SELECT * from PIX;



