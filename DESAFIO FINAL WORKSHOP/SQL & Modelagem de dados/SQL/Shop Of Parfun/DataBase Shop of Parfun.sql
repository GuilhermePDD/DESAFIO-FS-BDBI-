CREATE DATABASE IF NOT EXISTS LojaPerfumes;
USE LojaPerfumes;

CREATE TABLE Cliente (
    ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Completo VARCHAR(100) NOT NULL,
    Email_Pessoal VARCHAR(100) UNIQUE NOT NULL,
    Telefone_Fixo VARCHAR(20),
    Telefone_Celular VARCHAR(20),
    Endereço_Residencial VARCHAR(200),
    Data_Nasc DATE,
    Preferência_Aroma VARCHAR(50)
);

INSERT INTO Cliente (Nome_Completo, Email_Pessoal, Telefone_Fixo, Telefone_Celular, Endereço_Residencial, Data_Nasc, Preferência_Aroma) VALUES
('João Silva', 'joao.silva@email.com', '1134567890', '11987654321', 'Rua das Flores, 123, SP', '1990-05-15', 'Amadeirado'),
('Maria Oliveira', 'maria.oli@email.com', NULL, '11912345678', 'Av. Central, 456, RJ', '1985-08-22', 'Floral'),
('Pedro Santos', 'pedro.santos@email.com', '2123456789', '21965432100', 'Rua do Sol, 789, MG', '1995-03-10', 'Cítrico');

CREATE TABLE Perfume (
    ID_Perfume INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Perfume VARCHAR(100) NOT NULL,
    Marca_Principal VARCHAR(50) NOT NULL,
    Volume_ml INT NOT NULL,
    Preço_Venda DECIMAL(10,2) NOT NULL,
    Tipo_Fragrância VARCHAR(50),
    Ano_Lançamento INT,
    País_Origem VARCHAR(50)
);

INSERT INTO Perfume (Nome_Perfume, Marca_Principal, Volume_ml, Preço_Venda, Tipo_Fragrância, Ano_Lançamento, País_Origem) VALUES
('Creed Aventus', 'Creed', 100, 1200.00, 'Eau de Parfum', 2010, 'França'),
('Chanel No. 5', 'Chanel', 50, 800.00, 'Eau de Parfum', 1921, 'França'),
('Tom Ford Oud Wood', 'Tom Ford', 75, 1500.00, 'Eau de Parfum', 2007, 'EUA');

CREATE TABLE Pedido (
    ID_Pedido INT PRIMARY KEY AUTO_INCREMENT,
    ID_Cliente INT NOT NULL,
    Data_Compra DATE NOT NULL,
    Valor_Final DECIMAL(10,2) NOT NULL,
    Status_Entrega VARCHAR(20) NOT NULL DEFAULT 'Pendente',
    Método_Pagamento VARCHAR(50) NOT NULL,
    Código_Rastreio VARCHAR(50),
    Data_Envio DATE,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

INSERT INTO Pedido (ID_Cliente, Data_Compra, Valor_Final, Status_Entrega, Método_Pagamento, Código_Rastreio, Data_Envio) VALUES
(1, '2025-03-02', 1200.00, 'Pendente', 'Cartão', NULL, NULL),
(2, '2025-03-01', 800.00, 'Enviado', 'Pix', 'BR123456789', '2025-03-02'),
(3, '2025-02-28', 2700.00, 'Entregue', 'Boleto', 'BR987654321', '2025-03-01');

CREATE TABLE Fornecedor (
    ID_Fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Empresa VARCHAR(100) NOT NULL,
    País_Sede VARCHAR(50) NOT NULL,
    Contato_Email VARCHAR(100) UNIQUE,
    Telefone_Internacional VARCHAR(20),
    CNPJ_ou_Identificador VARCHAR(50) UNIQUE,
    Data_Contrato DATE
);

INSERT INTO Fornecedor (Nome_Empresa, País_Sede, Contato_Email, Telefone_Internacional, CNPJ_ou_Identificador, Data_Contrato) VALUES
('Perfumes Importados LTDA', 'Brasil', 'contato@perfumesbr.com', '+5511987654321', '12.345.678/0001-99', '2023-01-15'),
('Fragrance Global', 'França', 'global@fragrance.fr', '+33123456789', 'FR123456789', '2022-06-10'),
('Scent Supply Inc.', 'EUA', 'supply@scentusa.com', '+12025550123', 'US987654321', '2024-02-01');

CREATE TABLE Estoque (
    ID_Estoque INT PRIMARY KEY AUTO_INCREMENT,
    ID_Perfume INT NOT NULL,
    Quantidade_Disponível INT NOT NULL DEFAULT 0,
    Data_Ultima_Atualização DATE NOT NULL,
    Local_Armazenagem VARCHAR(50),
    Lote_Produção VARCHAR(50),
    Prazo_Validade DATE,
    FOREIGN KEY (ID_Perfume) REFERENCES Perfume(ID_Perfume)
);

INSERT INTO Estoque (ID_Perfume, Quantidade_Disponível, Data_Ultima_Atualização, Local_Armazenagem, Lote_Produção, Prazo_Validade) VALUES
(1, 50, '2025-03-01', 'Depósito SP', 'LOTE001', '2026-03-01'),
(2, 30, '2025-02-20', 'Depósito RJ', 'LOTE002', '2025-12-31'),
(3, 20, '2025-03-02', 'Depósito MG', 'LOTE003', '2027-01-15');

CREATE TABLE Funcionário (
    ID_Funcionário INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Funcionário VARCHAR(100) NOT NULL,
    Cargo VARCHAR(50) NOT NULL,
    Salário DECIMAL(10,2) NOT NULL,
    Data_Admissão DATE NOT NULL,
    Telefone_Contato VARCHAR(20)
);

INSERT INTO Funcionário (Nome_Funcionário, Cargo, Salário, Data_Admissão, Telefone_Contato) VALUES
('Ana Costa', 'Gerente', 5000.00, '2020-03-01', '11955554444'),
('Carlos Almeida', 'Estoquista', 2500.00, '2021-07-15', '11966663333'),
('Beatriz Lima', 'Vendedora', 3000.00, '2023-09-10', '11977772222');

CREATE TABLE Transportadora (
    ID_Transportadora INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Transportadora VARCHAR(100) NOT NULL,
    Email_Contato VARCHAR(100) UNIQUE,
    Prazo_Entrega_Dias INT NOT NULL,
    Custo_Frete DECIMAL(10,2) NOT NULL
);

INSERT INTO Transportadora (Nome_Transportadora, Email_Contato, Prazo_Entrega_Dias, Custo_Frete) VALUES
('Correios', 'contato@correios.com.br', 5, 25.00),
('DHL Express', 'dhl@dhl.com', 3, 80.00),
('FedEx Brasil', 'fedex@fedex.com.br', 4, 50.00);

CREATE TABLE Campanha_Marketing (
    ID_Campanha INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Campanha VARCHAR(100) NOT NULL,
    Data_Inicio DATE NOT NULL,
    Data_Fim DATE NOT NULL,
    Desconto_Percentual DECIMAL(5,2) NOT NULL,
    Perfume_Foco INT,
    FOREIGN KEY (Perfume_Foco) REFERENCES Perfume(ID_Perfume)
);

INSERT INTO Campanha_Marketing (Nome_Campanha, Data_Inicio, Data_Fim, Desconto_Percentual, Perfume_Foco) VALUES
('Promoção de Março', '2025-03-01', '2025-03-31', 15.00, 1),
('Liquidação Chanel', '2025-02-15', '2025-03-15', 20.00, 2),
('Oud Week', '2025-03-05', '2025-03-12', 10.00, 3);

CREATE TABLE Item_Pedido (
    ID_Item INT PRIMARY KEY AUTO_INCREMENT,
    ID_Pedido INT NOT NULL,
    ID_Perfume INT NOT NULL,
    Quantidade INT NOT NULL,
    Preço_Unitário DECIMAL(10,2) NOT NULL,
    Desconto_Aplicado DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
    FOREIGN KEY (ID_Perfume) REFERENCES Perfume(ID_Perfume)
);

INSERT INTO Item_Pedido (ID_Pedido, ID_Perfume, Quantidade, Preço_Unitário, Desconto_Aplicado) VALUES
(1, 1, 1, 1200.00, 0.00),
(2, 2, 1, 800.00, 0.00),
(3, 1, 2, 1200.00, 0.00),
(3, 3, 1, 1500.00, 300.00); -- Desconto aplicado

CREATE TABLE Fornecedor_Perfume (
    ID_Fornecedor INT NOT NULL,
    ID_Perfume INT NOT NULL,
    Data_Fornecimento DATE,
    PRIMARY KEY (ID_Fornecedor, ID_Perfume),
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor),
    FOREIGN KEY (ID_Perfume) REFERENCES Perfume(ID_Perfume)
);

INSERT INTO Fornecedor_Perfume (ID_Fornecedor, ID_Perfume, Data_Fornecimento) VALUES
(1, 1, '2025-02-01'),
(2, 2, '2025-01-15'),
(3, 3, '2025-02-20');

CREATE TABLE Transportadora_Fornecedor (
    ID_Transportadora INT NOT NULL,
    ID_Fornecedor INT NOT NULL,
    Contrato_ID VARCHAR(50),
    Custo_Transporte DECIMAL(10,2),
    PRIMARY KEY (ID_Transportadora, ID_Fornecedor),
    FOREIGN KEY (ID_Transportadora) REFERENCES Transportadora(ID_Transportadora),
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor)
);

INSERT INTO Transportadora_Fornecedor (ID_Transportadora, ID_Fornecedor, Contrato_ID, Custo_Transporte) VALUES
(1, 1, 'CTR001', 25.00),
(2, 2, 'CTR002', 80.00),
(3, 3, 'CTR003', 50.00);

CREATE TABLE Fornecedor_Pedido (
    ID_Fornecedor INT NOT NULL,
    ID_Pedido INT NOT NULL,
    Data_Envio_Fornecedor DATE,
    PRIMARY KEY (ID_Fornecedor, ID_Pedido),
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor(ID_Fornecedor),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido)
);

INSERT INTO Fornecedor_Pedido (ID_Fornecedor, ID_Pedido, Data_Envio_Fornecedor) VALUES
(1, 1, NULL), -- Ainda não enviado
(2, 2, '2025-03-02'),
(3, 3, '2025-03-01');

CREATE TABLE Cliente_Campanha (
    ID_Cliente INT NOT NULL,
    ID_Campanha INT NOT NULL,
    Data_Inscrição DATE,
    Cupom_Gerado VARCHAR(20),
    PRIMARY KEY (ID_Cliente, ID_Campanha),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
    FOREIGN KEY (ID_Campanha) REFERENCES Campanha_Marketing(ID_Campanha)
);

INSERT INTO Cliente_Campanha (ID_Cliente, ID_Campanha, Data_Inscrição, Cupom_Gerado) VALUES
(1, 1, '2025-03-01', 'MAR15OFF'),
(2, 2, '2025-02-15', 'CHANEL20'),
(3, 3, '2025-03-05', 'OUD10');

CREATE TABLE Funcionário_Estoque (
    ID_Funcionário INT NOT NULL,
    ID_Estoque INT NOT NULL,
    Data_Atualização DATE,
    PRIMARY KEY (ID_Funcionário, ID_Estoque),
    FOREIGN KEY (ID_Funcionário) REFERENCES Funcionário(ID_Funcionário),
    FOREIGN KEY (ID_Estoque) REFERENCES Estoque(ID_Estoque)
);

INSERT INTO Funcionário_Estoque (ID_Funcionário, ID_Estoque, Data_Atualização) VALUES
(2, 1, '2025-03-01'),
(2, 2, '2025-02-20'),
(3, 3, '2025-03-02');

CREATE INDEX idx_pedido_cliente ON Pedido(ID_Cliente);
CREATE INDEX idx_estoque_perfume ON Estoque(ID_Perfume);
CREATE INDEX idx_item_pedido_pedido ON Item_Pedido(ID_Pedido);
CREATE INDEX idx_item_pedido_perfume ON Item_Pedido(ID_Perfume);

USE LojaPerfumes;

#Mostra quantos clientes preferem cada tipo de aroma. Insight: Se "Floral" domina, a loja pode priorizar fragrâncias florais.
SELECT Preferência_Aroma, COUNT(*) AS Total_Clientes
FROM Cliente
GROUP BY Preferência_Aroma;

#Média de preço por tipo de fragrância ajuda a identificar quais tipos são mais caros. Insight: Eau de Parfum pode ser o foco por ter maior valor agregado.
SELECT Tipo_Fragrância, AVG(Preço_Venda) AS Preço_Médio
FROM Perfume
GROUP BY Tipo_Fragrância;

#Total vendido por status revela quanto está pendente vs. entregue. Insight: Se "Pendente" for alto, pode indicar atrasos na entrega.
SELECT Status_Entrega, SUM(Valor_Final) AS Total_Vendido
FROM Pedido
GROUP BY Status_Entrega;

#Contagem por país mostra a diversificação de fornecedores. Insight: Dependência de um país pode ser risco logístico.
SELECT País_Sede, COUNT(*) AS Total_Fornecedores
FROM Fornecedor
GROUP BY País_Sede;

#Quantidade por local ajuda a planejar redistribuição. Insight: Depósitos com pouco estoque precisam de reposição.
SELECT Local_Armazenagem, SUM(Quantidade_Disponível) AS Total_Estoque
FROM Estoque
GROUP BY Local_Armazenagem;

#Salário médio por cargo reflete custo da equipe. Insight: Gerentes custam mais, mas estoquistas podem ser subvalorizados.
SELECT Cargo, AVG(Salário) AS Salário_Médio
FROM Funcionário
GROUP BY Cargo;

#Custo médio por prazo ajuda a escolher transporte. Insight: Prazos curtos são mais caros, mas podem melhorar satisfação.
SELECT Prazo_Entrega_Dias, AVG(Custo_Frete) AS Custo_Médio_Frete
FROM Transportadora
GROUP BY Prazo_Entrega_Dias;

#Maior desconto por mês identifica períodos promocionais. Insight: Março tem campanhas agressivas.
SELECT MONTH(Data_Inicio) AS Mês_Inicio, MAX(Desconto_Percentual) AS Maior_Desconto
FROM Campanha_Marketing
GROUP BY MONTH(Data_Inicio);

#Total vendido por perfume mostra best-sellers. Insight: Creed Aventus pode ser o mais popular.
SELECT ID_Perfume, SUM(Quantidade) AS Total_Vendido
FROM Item_Pedido
GROUP BY ID_Perfume;

#Custo total por transportadora revela parcerias caras. Insight: DHL pode ser custo elevado vs. Correios.

SELECT ID_Fornecedor, MAX(Data_Fornecimento) AS Último_Fornecimento
FROM Fornecedor_Perfume
GROUP BY ID_Fornecedor;

#Último fornecimento indica atividade dos fornecedores. Insight: Fornecedores inativos há muito tempo podem ser substituídos.
SELECT ID_Transportadora, SUM(Custo_Transporte) AS Total_Custo
FROM Transportadora_Fornecedor
GROUP BY ID_Transportadora;

#Total de pedidos por fornecedor mostra dependência. Insight: Um fornecedor dominante pode ser gargalo.
SELECT ID_Fornecedor, COUNT(ID_Pedido) AS Total_Pedidos
FROM Fornecedor_Pedido
GROUP BY ID_Fornecedor;

#Clientes por campanha mede engajamento. Insight: Campanhas com poucos clientes podem ser ineficazes.
SELECT ID_Campanha, COUNT(ID_Cliente) AS Total_Clientes
FROM Cliente_Campanha
GROUP BY ID_Campanha;

#Última atualização por funcionário mostra atividade. Insight: Estoquista mais ativo pode precisar de apoio.
SELECT ID_Funcionário, MAX(Data_Atualização) AS Última_Atualização
FROM Funcionário_Estoque
GROUP BY ID_Funcionário;

#Informação: Lista pedidos com nome do cliente e valor real após descontos.
#Insight: Pedro Santos gastou mais (R$ 2700), mas com desconto aplicado, indicando eficácia de promoções.
#Comportamento: Só mostra pedidos com itens (devido ao INNER JOIN), excluindo pedidos sem itens (se houver).
SELECT p.ID_Pedido, c.Nome_Completo, p.Data_Compra, SUM(ip.Quantidade * ip.Preço_Unitário - ip.Desconto_Aplicado) AS Valor_Real
FROM Pedido p
INNER JOIN Cliente c ON p.ID_Cliente = c.ID_Cliente
INNER JOIN Item_Pedido ip ON p.ID_Pedido = ip.ID_Pedido
GROUP BY p.ID_Pedido, c.Nome_Completo, p.Data_Compra;

#Informação: Mostra perfumes, quantidade em estoque e campanhas associadas, mesmo que não tenham estoque ou campanha.
#Insight: Perfumes sem campanha (ex.: se houver estoque mas sem Perfume_Foco) podem ser oportunidades promocionais.
#Comportamento: LEFT JOIN garante que todos os perfumes apareçam, útil para análise completa de estoque.
SELECT pr.Nome_Perfume, e.Quantidade_Disponível, cm.Nome_Campanha, cm.Desconto_Percentual
FROM Perfume pr
LEFT JOIN Estoque e ON pr.ID_Perfume = e.ID_Perfume
LEFT JOIN Campanha_Marketing cm ON pr.ID_Perfume = cm.Perfume_Foco;
