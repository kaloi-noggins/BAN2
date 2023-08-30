--1)Função para inserção de um mecânico.
create or replace function (pcodm int, pnome varchar, pfuncao varchar) returns void as
$$
    insert into mecanico(codm, nome, funcao)
    values (pcodm,pnome,pfuncao)
$$
language sql;
--2)Função para exclusão de um mecânico. 
--3)Função única para inserção, atualizar e exclusão de um cliente.

--4)Função que limite o cadastro de no máximo 10 setores na oficina mecânica.
create or replace function cadastrar_setor(pcods int, pnome varchar) returns void as
$$
declare
    quant int default 0;
begin
    select count(*) from setor into quant;
    if quant > 10 then
        raise execption 'Qunatidade máxima excedidad';
    end if;
    insert into setor values(pcods, pnome);
end;
$$
language plpgsql;
--5)Função que limita o cadastro de um conserto apenas se o mecânico não tiver mais de 3 consertos agendados para o mesmo dia.
--6)Função para calcular a média geral de idade dos Mecânicos e Clientes.
--7)Função única que permita fazer a exclusão de um Setor, Mecânico, Cliente ou Veículo.
--8)Considerando que na tabela Cliente apenas codc é a chave primária, faça uma função que remova clientes com CPF repetido, deixando apenas um cadastro para cada CPF. Escolha o critério que preferir para definir qual cadastro será mantido: aquele com a menor idade, que possuir mais consertos agendados, etc. Para testar a função, não se esqueça de inserir na tabela alguns clientes com este problema.
--9)Função para calcular se o CPF é válido*.
--10)Função que calcula a quantidade de horas extras de um mecânico em um mês de trabalho. O número de horas extras é calculado a partir das horas que excedam as 160 horas de trabalho mensais. O número de horas mensais trabalhadas é calculada a partir dos consertos realizados. Cada conserto tem a duração de 1 hora.