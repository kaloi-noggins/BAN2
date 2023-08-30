--1) Recupere o CPF e o nome dos mecânicos que trabalham nos setores número 1 e 2
--(faça a consulta utilizado a cláusula IN).
SELECT cpf,
    nome
FROM mecanico
WHERE cods IN (1, 2);
--2) Recupere o CPF e o nome dos mecânicos que trabalham nos setores 'Funilaria' e 'Pintura'
--(faça a consulta utilizando sub-consultas aninhadas).
SELECT cpf,
    nome
FROM mecanico
WHERE cods IN (
        SELECT cods
        FROM setor
        WHERE nome IN ('Funilaria', 'Pintura')
    );
--3) Recupere o CPF e nome dos mecânicos que atenderam no dia 13/06/2014 (faça a consulta usando INNER JOIN).
SELECT cpf,
    nome
FROM conserto
    INNER JOIN mecanico ON conserto.codm = mecanico.codm
WHERE conserto.data = '06/13/2014';
--4) Recupere o nome do mecânico, o nome do cliente e a hora do conserto para os consertos realizados no dia 12/06/2014
--(faça a consulta usando INNER JOIN).
SELECT mecanico.nome AS nome_mecanico,
    cliente.nome AS nome_cliente,
    hora
FROM conserto
    INNER JOIN mecanico ON conserto.codm = mecanico.codm
    INNER JOIN veiculo ON conserto.codv = veiculo.codc
    INNER JOIN cliente ON veiculo.codc = cliente.codc
WHERE conserto.data = '06/12/2014';
--5) Recupere o nome e a função de todos os mecânicos, e o número e o nome dos setores
--para os mecânicos que tenham essa informação.
SELECT mecanico.nome,
    mecanico.funcao,
    setor.cods,
    setor.nome
FROM mecanico
    LEFT JOIN setor ON mecanico.cods = setor.cods;
--6) Recupere o nome de todos os mecânicos, e as datas dos consertos para os mecânicos que têm consertos feitos 
--(deve aparecer apenas um registro de nome de mecânico para cada data de conserto).
SELECT DISTINCT nome,
    data
FROM conserto
    JOIN mecanico USING (codm);
--7) Recupere a média da quilometragem de todos os veículos dos clientes.
SELECT ROUND(AVG(quilometragem)::numeric, 3)
FROM veiculo;
--8) Recupere a soma da quilometragem dos veículos de cada cidade onde residem seus proprietários.
SELECT c.cidade,
    sum(v.quilometragem)
from cliente c
    join veiculo v using (codc)
group by c.cidade
SELECT distinct cidade
from cliente;
--9) Recupere a quantidade de consertos feitos por cada mecânico durante o período de 12/06/2014 até 19/06/2014
SELECT m.codm,
    m.nome,
    count(*)
FROM mecanico m
    JOIN conserto c using (codm)
WHERE c.data between '12/6/2014' and '19/06/2014'
group by m.codm,
    m.nome;
--10) Recupere a quantidade de consertos feitos agrupada pela marca do veículo.
SELECT v.modelo,
    count(*)
from veiculo v
    JOIN conserto using (codv)
group by v.modelo;
--11) Recupere o modelo, a marca e o ano dos veículos que têm quilometragem maior que a média de quilometragem de todos os veículos.
SELECT v.modelo,
    v.marca,
    v.ano
FROM veiculo v
WHERE v.quilometragem > (
        SELECT avg(quilometragem)
        from veiculo
    );
--12) Recupere o nome dos mecânicos que têm mais de um conserto marcado para o mesmo dia.
SELECT m.codm,
    m.nome,
    count(*)
from mecanico m
    join conserto c using(codm)
GROUP BY m.codm,
    m.nome
having count(*) > 1;