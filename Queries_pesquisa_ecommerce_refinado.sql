show databases;
use ecommerce_refinado;
show tables;
select * from CLIENTE where UF = "SP";
select Nome_fantasia, Cidade, Avaliacao from TERCEIRO where UF = "ES";
select concat(Nome, '', Sobrenome) as Nome_completo from CLIENTE;
select Nome, idProduto, Avaliacao, Valor from Produto having (Valor) > 50 order by Nome;
Select * FROM TERCEIRO AS T cross Join FORNECEDOR AS F ON T.idTerceiro = F.idFornecedor; 