-- Arquivo: consultas_dql_shop_of_parfun.sql
-- Data: 02/03/2025 10:19:00
-- Descrição: Consultas DQL para o banco Shop of Parfun com agregações, agrupamentos e JOINs

USE LojaPerfumes;

--  Consultas com Agregação/Agrupamento
SELECT Preferência_Aroma, COUNT(*) AS Total_Clientes FROM Cliente GROUP BY Preferência_Aroma;
SELECT Tipo_Fragrância, AVG(Preço_Venda) AS Preço_Médio FROM Perfume GROUP BY Tipo_Fragrância;
SELECT Status_Entrega, SUM(Valor_Final) AS Total_Vendido FROM Pedido GROUP BY Status_Entrega;
SELECT País_Sede, COUNT(*) AS Total_Fornecedores FROM Fornecedor GROUP BY País_Sede;
SELECT Local_Armazenagem, SUM(Quantidade_Disponível) AS Total_Estoque FROM Estoque GROUP BY Local_Armazenagem;
SELECT Cargo, AVG(Salário) AS Salário_Médio FROM Funcionário GROUP BY Cargo;
SELECT Prazo_Entrega_Dias, AVG(Custo_Frete) AS Custo_Médio_Frete FROM Transportadora GROUP BY Prazo_Entrega_Dias;
SELECT MONTH(Data_Inicio) AS Mês_Inicio, MAX(Desconto_Percentual) AS Maior_Desconto FROM Campanha_Marketing GROUP BY MONTH(Data_Inicio);
SELECT ID_Perfume, SUM(Quantidade) AS Total_Vendido FROM Item_Pedido GROUP BY ID_Perfume;
SELECT ID_Fornecedor, MAX(Data_Fornecimento) AS Último_Fornecimento FROM Fornecedor_Perfume GROUP BY ID_Fornecedor;
SELECT ID_Transportadora, SUM(Custo_Transporte) AS Total_Custo FROM Transportadora_Fornecedor GROUP BY ID_Transportadora;
SELECT ID_Fornecedor, COUNT(ID_Pedido) AS Total_Pedidos FROM Fornecedor_Pedido GROUP BY ID_Fornecedor;
SELECT ID_Campanha, COUNT(ID_Cliente) AS Total_Clientes FROM Cliente_Campanha GROUP BY ID_Campanha;
SELECT ID_Funcionário, MAX(Data_Atualização) AS Última_Atualização FROM Funcionário_Estoque GROUP BY ID_Funcionário;

--  Operações com JOIN
SELECT p.ID_Pedido, c.Nome_Completo, p.Data_Compra, SUM(ip.Quantidade * ip.Preço_Unitário - ip.Desconto_Aplicado) AS Valor_Real
FROM Pedido p
INNER JOIN Cliente c ON p.ID_Cliente = c.ID_Cliente
INNER JOIN Item_Pedido ip ON p.ID_Pedido = ip.ID_Pedido
GROUP BY p.ID_Pedido, c.Nome_Completo, p.Data_Compra;

SELECT pr.Nome_Perfume, e.Quantidade_Disponível, cm.Nome_Campanha, cm.Desconto_Percentual
FROM Perfume pr
LEFT JOIN Estoque e ON pr.ID_Perfume = e.ID_Perfume
LEFT JOIN Campanha_Marketing cm ON pr.ID_Perfume = cm.Perfume_Foco;