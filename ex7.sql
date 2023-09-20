--1)Função para inserção de um mecânico.
CREATE OR REPLACE FUNCTION cadastrar_mecanico(param_codm int, param_nome varchar, param_funcao varchar)
    RETURNS void
    AS $$
BEGIN
    INSERT INTO mecanico(codm, nome, funcao)
        VALUES(pcodm, pnome, pfuncao);
END;
$$
LANGUAGE plpgsql;

--2)Função para exclusão de um mecânico.
CREATE OR REPLACE FUNCTION remover_mecanico(param_codm int)
    RETURNS void
    AS $$
BEGIN
    DELETE FROM mecanico
    WHERE pcodm = pcodm_param;
END;
$$
LANGUAGE plpgsql;

--3)Função única para inserção, atualizar e exclusão de um cliente.
-- operacoes:
-- 1 - inserir
-- 2 - atualizar
-- 3 - exlusão
CREATE OR REPLACE FUNCTION gerencia_clientes(operacao int, param_codc int, param_cpf char(11), param_nome varchar, param_idade int, param_endereco varchar, param_cidade varchar)
    RETURNS void
    AS $$
BEGIN
    IF operacao = 1 THEN
        INSERT INTO cliente
            VALUES(param_codc, param_cpf, param_nome, param_endereco, param_cidade);
    ELSIF operacao = 2 THEN
        UPDATE
            cliente
        SET
(codc,
                cpf,
                nome,
                endereco,
                cidade) =(param_codc,
                param_cpf param_nome,
                param_endereco,
                param_cidade);
    ELSIF operacao = 2 THEN
        DELETE FROM cliente
        WHERE codc = param_codc;
        ELSe: RETURN void;
    END IF;
END;
$$
LANGUAGE plpgsql;

--4)Função que limite o cadastro de no máximo 10 setores na oficina mecânica.
CREATE OR REPLACE FUNCTION cadastrar_setor(pcods int, pnome varchar)
    RETURNS void
    AS $$
DECLARE
    quant int DEFAULT 0;
BEGIN
    SELECT
        count(*)
    FROM
        setor INTO quant;
    IF quant > 10 THEN
        RAISE execption 'Quantidade máxima excedida';
    END IF;
    INSERT INTO setor
        VALUES (pcods, pnome);
END;
$$
LANGUAGE plpgsql;

--5)Função que limita o cadastro de um conserto apenas se o mecânico não tiver mais de 3 consertos agendados para o mesmo dia.
--6)Função para calcular a média geral de idade dos Mecânicos e Clientes.
--7)Função única que permita fazer a exclusão de um Setor, Mecânico, Cliente ou Veículo.
--8)Considerando que na tabela Cliente apenas codc é a chave primária, faça uma função que remova clientes com CPF repetido, deixando apenas um cadastro para cada CPF. Escolha o critério que preferir para definir qual cadastro será mantido: aquele com a menor idade, que possuir mais consertos agendados, etc. Para testar a função, não se esqueça de inserir na tabela alguns clientes com este problema.
--9)Função para calcular se o CPF é válido*.
--10)Função que calcula a quantidade de horas extras de um mecânico em um mês de trabalho. O número de horas extras é calculado a partir das horas que excedam as 160 horas de trabalho mensais. O número de horas mensais trabalhadas é calculada a partir dos consertos realizados. Cada conserto tem a duração de 1 hora.
