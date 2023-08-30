--1) Mostre o nome e a função dos mecânicos.
CREATE VIEW funcao_mecanicos (nome, funcao) AS
SELECT nome,
    funcao
FROM mecanico;
SELECT *
FROM funcao_mecanicos;
--2) Mostre o modelo e a marca dos veículos dos clientes.
CREATE VIEW modelo_marca_veiculos (modele, marca) AS
SELECT modelo,
    marca
FROM veiculo;
--3) Mostre o nome dos mecânicos, o nome dos clientes, o modelo dos veículos e a data e hora dos consertos realizados.
CREATE VIEW relatorio_detalhado_consertos (
    nome_mecanico,
    nome_cliente,
    modelo,
    data_conserto,
    hora
) AS
SELECT mecanico.nome,
    cliente.nome,
    veiculo.modelo,
    conserto.data,
    conserto.hora
FROM conserto
    JOIN mecanico USING (codm)
    JOIN veiculo USING (codv)
    JOIN cliente using (codc);
--4) Mostre o ano dos veículos e a média de quilometragem para cada ano.
CREATE VIEW media_km_ano (ano_veiculo, media_ano) AS
SELECT ano,
    AVG(quilometragem)
FROM veiculo
GROUP BY ano;
--5) Mostre o nome dos mecânicos e o total de consertos feitos por um mecânico em cada dia.
CREATE VIEW conserto_por_mecanico_por_dia (nome_mecanico, total_consertos, dia) AS
SELECT mecanico.nome,
    count(*),
    conserto.data
FROM conserto
    JOIN mecanico USING (codm)
GROUP BY mecanico.nome,
    conserto.data;
--6) Mostre o nome dos setores e o total de consertos feitos em um setor em cada dia.
CREATE VIEW conserto_por_setor(nome_setor) AS
SELECT setor.nome,
    count(*)
FROM conserto
    JOIN mecanico USING (codm)
    JOIN setor USING (cods)
GROUP BY setor.nome;
--7) Mostre o nome das funções e o número de mecânicos que têm uma destas funções.
CREATE VIEW mecanico_por_funcao(funcao, quantidade) AS
SELECT funcao,
    COUNT(*)
FROM mecanico
GROUP BY funcao;
--8) Mostre o nome dos mecânicos e suas funções e, para os mecânicos que estejam alocados a um setor, 
--informe também o número e nome do setor.
CREATE VIEW funcoes_setores_mecanicos(nome_mecanico, funcao, num_setor, nome_setor) AS
SELECT mecanico.nome,
    mecanico.funcao,
    setor.cods,
    setor.nome
FROM mecanico
    LEFT JOIN setor ON mecanico.cods = setor.cods;
--9) Mostre o nome das funções dos mecânicos e a quantidade de consertos feitos agrupado por cada função.
CREATE VIEW consertos_por_funcao_mecanico(funcao, num_consertos) AS
SELECT mecanico.funcao,
    COUNT(*)
FROM conserto
    JOIN mecanico USING (codm)
GROUP BY mecanico.funcao;