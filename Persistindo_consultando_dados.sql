-- Persistindo dados e fazendo Query

-- Inserindo dados na tabela `Cliente`
INSERT INTO `Cliente` (`Nome`, `Endereço`, `Telefone`, `E-mail`, `CPF/CNPJ`, `Data Nascimento`)
VALUES
    ('Maria Silva', 'Rua A, 123', '1122334455', 'maria@email.com', '12345678901', '1990-05-15'),
    ('João Santos', 'Avenida B, 456', '9988776655', 'joao@email.com', '98765432101', '1985-11-30');

-- Inserindo dados na tabela `Veiculo`
INSERT INTO `Veiculo` (`Placa`, `Cor`, `Modelo`, `Montadora`, `Tipo Combustível`, `Cliente_idCliente`)
VALUES
    ('ABC1234', 'Prata', 'Sedan', 'Volkswagen', 'Flex', 1),
    ('XYZ5678', 'Preto', 'SUV', 'Ford', 'Gasolina', 2);

-- Inserindo dados na tabela `Mecanico`
INSERT INTO `Mecanico` (`CPF Mecanico`, `Nome`, `Endereço`, `Especialidade`)
VALUES
    ('11122233344', 'Carlos Pereira', 'Rua X, 789', 'Carro'),
    ('55566677788', 'Ana Oliveira', 'Avenida Y, 101', 'Moto');

-- Inserindo dados na tabela `Ordem_de_Serviço`
INSERT INTO `Ordem_de_Serviço` (`Data emissão`, `Status`, `Data conclusão`)
VALUES
    ('2023-08-15', 'Aguardando confirmação', '2023-08-31'),
    ('2023-08-14', 'Em andamento', '2023-08-22');

-- Inserindo dados na tabela `Serviço`
INSERT INTO `Serviço` (`Tipo de serviço`, `Valor do serviço`, `Ordem de Serviço_idOrdem de Serviço`)
VALUES
    ('Conserto', 150.00, 1),
    ('Revisão Periódica', 80.00, 2);

-- Inserindo dados na tabela `Peça`
INSERT INTO `Peça` (`Descrição`, `Valor`, `Ordem de Serviço_idOrdem de Serviço`)
VALUES
    ('Filtro de óleo', 15.00, 1),
    ('Pastilhas de freio', 30.00, 1);

-- Inserindo dados na tabela `Equipe_Mecanico`
INSERT INTO `Equipe_Mecanico` (`Mecanico_idMecanico`, `Veiculo_idVeiculo`, `Serviço_idServiço`)
VALUES
    (1, 1, 1),
    (2, 2, 2);

-- QUERY de teste.
-- Recuperar todos os clientes:
SELECT * FROM `Cliente`;

-- Recuperar informações de veículos com seus proprietários:
SELECT
    V.`Placa`,
    V.`Modelo`,
    V.`Montadora`,
    V.`Cor`,
    C.`Nome` AS `Proprietário`
FROM
    `Veiculo` V
INNER JOIN
    `Cliente` C ON V.`Cliente_idCliente` = C.`idCliente`;

-- Recuperar todos os mecânicos e suas especialidades:

SELECT `Nome`, `Especialidade` FROM `Mecanico`;

-- Recuperar ordens de serviço concluídas:

SELECT * FROM `Ordem_de_Serviço` WHERE `Status` = 'Em andamento';

-- Recuperar serviços realizados em uma ordem de serviço específica:

SELECT
    S.`Tipo de serviço`,
    S.`Valor do serviço`,
    O.`Data emissão`
FROM
    `Serviço` S
INNER JOIN
    `Ordem_de_Serviço` O ON S.`Ordem de Serviço_idOrdem de Serviço` = O.`idOrdem de Serviço`
WHERE
    O.`Status` = 'Em andamento';

-- Recuperar todas as peças utilizadas em uma ordem de serviço específica:
SELECT
    P.`Descrição`,
    P.`Valor`
FROM
    `Peça` P
INNER JOIN
    `Ordem_de_Serviço` O ON P.`Ordem de Serviço_idOrdem de Serviço` = O.`idOrdem de Serviço`
WHERE
    O.`Status` = 'Concluído';



