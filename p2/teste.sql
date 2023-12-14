CREATE OR REPLACE FUNCTION questao1() RETURNS trigger AS
$$
DECLARE
    dep_projet int;
    dep_empregado int;
BEGIN
    SELECT dnumero INTO dep_empregado
    FROM empregado e
    JOIN departamento d
    ON e.ssn = NEW.essn AND e.dno = d.dnumero;

    SELECT dnum INTO dep_projeto
    FROM projeto p
    WHERE p.pnumero = NEW.pno;

    IF dep_empregado <> dep_projeto THEN
        RAISE EXCEPTION 'Empregado e projeto são de departamentos diferentes';
    END IF;

    RETURN NEW;
END;
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER questao1_t
BEFORE INSERT OR UPDATE
ON trabalha_em
FOR EACH ROW
EXECUTE PROCEDURE questao1();

CREATE OR REPLACE FUNCTION questao2() RETURNS trigger AS
$$
DECLARE
    salario_atual int;
    novo_salario int;
BEGIN
    SELECT salario INTO salario_atual
    FROM empregado
    WHERE ssn = NEW.essn;

    novo_salario := salario + (salario * 0.02);
    
    UPDATE empregado
    SET salario = novo_salario
    WHERE ssn = NEW.essn;

    RETURN NEW;
END;
$$

CREATE OR REPLACE TRIGGER questao2_t
BEFORE INSERT
ON trabalha_em
FOR EACH ROW
EXECUTE PROCEDURE questao2()

CREATE OR REPLACE FUNCTION questao3 RETURNS trigger AS
$$
DECLARE
    num_empregados int;
    num_projetos int;
BEGIN
    SELECT COUNT(*) INTO num_empregados
    FROM empregado
    WHERE dno = NEW.dnum;

    SELECT COUNT(*) INTO num_projetos
    FROM projeto
    WHERE dnum = NEW.dnum

    IF num_empregados < (num_projetos * 2) THEN
        RAISE EXCEPTION 'Nope';
    END IF;

    RETURN NEW;
END;
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER questao3_t
BEFORE INSERT
ON projeto
FOR EACH ROW
EXECUTE PROCEDURE questao3();