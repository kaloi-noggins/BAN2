--1)Crie um índice para cada uma das chaves estrangeiras presentes do esquema de dados.

-- como são operações de comparação em chaves estrangeiras para junção,
-- um hashmap é adequado como estrutura de indexação
create index if not exists idx_mecanico_cods on mecanico using hash(cods);

create index if not exists idx_conserto_codm on conserto using hash(codm);
create index if not exists idx_conserto_codv on conserto using hash(codv);

create index if not exists idx_veiculo_codc on veiculo using hash(codc);

--2)Crie um índice para acelerar a busca dos mecânicos pela função.
create index if not exists idx_mecanico_funcao on mecanico using btree(substr(funcao,1,10));

--3)Crie um índice para acelerar a ordenação dos consertos pela data e hora.
create index if not exists idx_conserto_datahora on conserto using btree(data,hora);

--4)Crie um índice para acelerar a busca de clientes pelo cpf.
create index if not exists idx_cliente_cpf on cliente using btree(cpf);

--5)Crie um índice para acelerar a busca pelas primeiras 5 letras do nome dos clientes.
create index if not exists idx_cliente_nome on cliente using btree(substr(nome,1,5));

--6)Crie um índice para acelerar a busca dos clientes com CPF com final XXX.XXX.XXX-55.
create index if not exists idx_cliente_cpf55 on cliente using btree(cpf) where cpf like '%55';