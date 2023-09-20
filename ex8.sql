-- 1)Gatilho para impedir a inserção ou atualização de Clientes com o mesmo CPF.

-- onde: cliente
-- operações: insert or update
-- quando: before
-- nivel: each row

create or replace function verifica_cpf() returns trigger as
$$
begin
	if (select 1 from cliente where cpf = new.cpf) then
		raise exception 'cpf já cadastrado';
	end if;
	raise notice 'trigger verifica_cpf() ativado';
	return new;
end
$$
language plpgsql;

create or replace trigger verifica_cpf before insert or update on cliente 
for each row execute procedure verifica_cpf();

-- 2)Gatilho para impedir a inserção ou atualização de Mecânicos com idade menor que 20 anos.

-- onde: mecanico
-- operações: insert or update
-- quando: before
-- nivel: each row

create or replace function verifica_idade_mecanico() returns trigger as
$$
begin
	if new.idade < 20 then
		raise exception 'mecanico com idade inferior a 20 anos'; 
	end if;
	return new;
end;
$$
language plpgsql;

create or replace trigger verifica_idade_mecanico() before insert or update on mecanico
for each row execute procedure verifica_idade_mecanico();

-- 3)Gatilho para atribuir um cods (sequencial) para um novo setor inserido.



-- 4)Gatilho para impedir a inserção de um mecânico ou cliente com CPF inválido.
-- 5)Gatilho para impedir que um mecânico seja removido caso não exista outro mecânico com a mesma função.
-- 6)Gatilho que ao inserir, atualizar ou remover um mecânico, reflita as mesmas modificações na tabela de Cliente. Em caso de atualização, se o mecânico ainda não existir na tabela de Cliente, deve ser inserido.

create or replace function atualizaCliente() returns trigger as
$$
begin
	if (TG_OP = 'INSERT') then
		insert into cliente (nome, cpf, idade, endereco, cidade)
			values (new.nome, new.cpf, new.idade, new.cidade);
	elseif (TG_OP = 'DELETE') then
		delete from cliente where cpf = new.cpf;
	elseif (TG_OP = 'UPDATE') then
		if (select 1 from cliente where cpf = new.cpf) then
			update cliente set
				nome = new.nome,
				idade= new.idade,
				endereco= new.endereco,
				cidade= new.cidade
			where cpf = new.cpf;
		else
			insert into cliente (nome, cpf, idade, endereco, cidade)
				values (new.nome, new.cpf, new.idade, new.cidade);
		end if;
	end if;
end;
$$
language plpgsql;

create or replace trigger atualizarCliente after insert or update or delete on mecanico 
	for each row execute procedure atualizaCliente();

create sequence seq_cliente start 10;

create or replace function new_cods() returns trigger as
$$
begin
	new.codc = nextval('seq_cliente');
end;
$$
language plpgsql;

create or replace trigger new_cods before insert on cliente 
	for each row execute procedure new_cods();

-- 7)Gatilho para impedir que um conserto seja inserido na tabela Conserto se o mecânico já realizou mais de 20 horas extras no mês.
-- 8)Gatilho para impedir que mais de 1 conserto seja agendado no mesmo setor na mesma hora.