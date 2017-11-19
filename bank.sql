--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: Nutri; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "Nutri";


ALTER SCHEMA "Nutri" OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = "Nutri", pg_catalog;

--
-- Name: descontar(); Type: FUNCTION; Schema: Nutri; Owner: postgres
--

CREATE FUNCTION descontar() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare desconto integer;
declare plano integer;
declare validade date;
Begin
      select p.cod_plan,p.datavalidade into plano,validade
      from  paciente p
      where new.cpfp = p.cpf;
      if(plano != NULL and validade > NOW()) then
        select plan.desconto into desconto
        from plano_saude plan 
        where plan.cod =  plano;
        new.preco = new.preco *(desconto/100);
      end if;
      return new;
 
END;
$$;


ALTER FUNCTION "Nutri".descontar() OWNER TO postgres;

--
-- Name: insert(); Type: FUNCTION; Schema: Nutri; Owner: postgres
--

CREATE FUNCTION insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$Begin
       return new;
end;$$;


ALTER FUNCTION "Nutri".insert() OWNER TO postgres;

--
-- Name: no_insert(); Type: FUNCTION; Schema: Nutri; Owner: postgres
--

CREATE FUNCTION no_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$Begin
       RAISE EXCEPTION 'Valores invalidos foram inseridos!';
       return null;
end;$$;


ALTER FUNCTION "Nutri".no_insert() OWNER TO postgres;

--
-- Name: verif_date(); Type: FUNCTION; Schema: Nutri; Owner: postgres
--

CREATE FUNCTION verif_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
       if ( new.data_inicio > ((select data from consulta c where c.id = new.id) +7))then 
       RAISE EXCEPTION 'Data Invalida!'
       USING HINT = 'O tratamento só pode ser iniciado no prazo de 7 dias após a consulta!';
  
       return null;
       end if;
       return new;

END;
$$;


ALTER FUNCTION "Nutri".verif_date() OWNER TO postgres;

--
-- Name: verif_desconto(); Type: FUNCTION; Schema: Nutri; Owner: postgres
--

CREATE FUNCTION verif_desconto() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
Begin
      if (new.desconto > 50) then
      raise exception 'Desconto invalido!'
      using hint = 'Descontos aceitos são de no máximo 50%!';
      return null;
      end if;
      return new;
END;
$$;


ALTER FUNCTION "Nutri".verif_desconto() OWNER TO postgres;

--
-- Name: verif_peso(); Type: FUNCTION; Schema: Nutri; Owner: postgres
--

CREATE FUNCTION verif_peso() RETURNS trigger
    LANGUAGE plpgsql
    AS $$Begin
       if (new.peso_objetivo > new.peso_inicio) then
               RAISE EXCEPTION 'Peso objetivo invalido.'
               USING HINT = 'O peso objetivo deve ser menor que o inicial.';
               return null ; 
       end if;
       return new;
end;$$;


ALTER FUNCTION "Nutri".verif_peso() OWNER TO postgres;

--
-- Name: verif_safra(); Type: FUNCTION; Schema: Nutri; Owner: postgres
--

CREATE FUNCTION verif_safra() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
 if ( new.safra < ( NOW() - interval '360 days' ))then 
       RAISE EXCEPTION 'Safra Invalida!'
       USING HINT = 'Produtos aceitos devem possuir safra de no máximo 1 ano anterior ao cadastro!';
  
       return null;
       end if;
       return new;
END;
$$;


ALTER FUNCTION "Nutri".verif_safra() OWNER TO postgres;

--
-- Name: verif_vencimento(); Type: FUNCTION; Schema: Nutri; Owner: postgres
--

CREATE FUNCTION verif_vencimento() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
 if ( new.validade < ( NOW() + '30 days' ))then 
       RAISE EXCEPTION 'Data Invalida!'
       USING HINT = 'O prazo de vencimento do produto deve ser de no minimo 1 mes após cadastro!';
  
       return null;
       end if;
       return new;
END;
$$;


ALTER FUNCTION "Nutri".verif_vencimento() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: clinica; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE clinica (
    cod integer NOT NULL,
    nome character varying(30),
    endereco character varying(50)
);


ALTER TABLE clinica OWNER TO postgres;

--
-- Name: consulta; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE consulta (
    id integer NOT NULL,
    cpfp bigint NOT NULL,
    cpfn bigint NOT NULL,
    data date NOT NULL
);


ALTER TABLE consulta OWNER TO postgres;

--
-- Name: conta; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE conta (
    cpfp bigint NOT NULL,
    senha bigint NOT NULL
);


ALTER TABLE conta OWNER TO postgres;

--
-- Name: dieta; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE dieta (
    cod integer NOT NULL,
    definicoes character varying(300)
);


ALTER TABLE dieta OWNER TO postgres;

--
-- Name: ed_alimentar; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE ed_alimentar (
    cpfp bigint NOT NULL,
    cpfn bigint NOT NULL,
    id integer NOT NULL,
    carencias character varying(200) NOT NULL
);


ALTER TABLE ed_alimentar OWNER TO postgres;

--
-- Name: emagrecimento; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE emagrecimento (
    cpfp bigint NOT NULL,
    cpfn bigint NOT NULL,
    id integer NOT NULL,
    peso_inicio integer NOT NULL,
    peso_objetivo integer NOT NULL
);


ALTER TABLE emagrecimento OWNER TO postgres;

--
-- Name: mensagem; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE mensagem (
    cpfp bigint NOT NULL,
    cpfn bigint NOT NULL,
    texto character varying(200) NOT NULL,
    data date NOT NULL
);


ALTER TABLE mensagem OWNER TO postgres;

--
-- Name: musculacao; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE musculacao (
    cpfp bigint NOT NULL,
    cpfn bigint NOT NULL,
    id integer NOT NULL,
    exercicios character varying(200) NOT NULL
);


ALTER TABLE musculacao OWNER TO postgres;

--
-- Name: nutricionista; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE nutricionista (
    cpf bigint NOT NULL,
    cod integer NOT NULL,
    nome character varying(30)
);


ALTER TABLE nutricionista OWNER TO postgres;

--
-- Name: paciente; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE paciente (
    cpf bigint NOT NULL,
    nome character varying(30),
    endereco character varying(50),
    datanascimento date,
    cod_plan integer,
    datavalidade date
);


ALTER TABLE paciente OWNER TO postgres;

--
-- Name: plano_saude; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE plano_saude (
    cod integer NOT NULL,
    nome character varying(30),
    desconto integer NOT NULL
);


ALTER TABLE plano_saude OWNER TO postgres;

--
-- Name: planos_aceitos; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE planos_aceitos (
    cod_plan integer NOT NULL,
    cod_clin integer NOT NULL
);


ALTER TABLE planos_aceitos OWNER TO postgres;

--
-- Name: prod_industrial; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE prod_industrial (
    cod integer NOT NULL,
    validade date NOT NULL
);


ALTER TABLE prod_industrial OWNER TO postgres;

--
-- Name: prod_natural; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE prod_natural (
    cod integer NOT NULL,
    safra date NOT NULL
);


ALTER TABLE prod_natural OWNER TO postgres;

--
-- Name: produto; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE produto (
    cod bigint NOT NULL,
    descricao character varying(200) NOT NULL,
    "faixa_preço" character varying(50) NOT NULL,
    nome character varying(30) NOT NULL
);


ALTER TABLE produto OWNER TO postgres;

--
-- Name: receita; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE receita (
    cod integer NOT NULL,
    cpfn bigint NOT NULL,
    preparo character varying(300),
    nome character varying(30)
);


ALTER TABLE receita OWNER TO postgres;

--
-- Name: receita_produto; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE receita_produto (
    cod_p integer NOT NULL,
    cod_r integer NOT NULL
);


ALTER TABLE receita_produto OWNER TO postgres;

--
-- Name: recomendacao; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE recomendacao (
    cod_r integer NOT NULL,
    cpfn bigint NOT NULL,
    cod_dieta integer NOT NULL
);


ALTER TABLE recomendacao OWNER TO postgres;

--
-- Name: telefone; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE telefone (
    cpf bigint NOT NULL,
    numero bigint NOT NULL
);


ALTER TABLE telefone OWNER TO postgres;

--
-- Name: tratamento; Type: TABLE; Schema: Nutri; Owner: postgres
--

CREATE TABLE tratamento (
    cod_dieta integer,
    cpfp bigint NOT NULL,
    cpfn bigint NOT NULL,
    id integer NOT NULL,
    data_inicio date NOT NULL,
    instrucoes character varying(300),
    preco real NOT NULL
);


ALTER TABLE tratamento OWNER TO postgres;

--
-- Data for Name: clinica; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO clinica VALUES (1, 'Clinica A', '64e2cf40ac6916b3fc0bf2bbd8dacc1b');
INSERT INTO clinica VALUES (2, 'Clinica B', '0cabc5919ca8fae4f72756211eaff1a7');
INSERT INTO clinica VALUES (3, 'Clinica C', 'f316b03c0a96b77625045d1e70af82b2');
INSERT INTO clinica VALUES (4, 'Clinica D', 'fe521dd697edd3a1cb00b21bd97acee3');
INSERT INTO clinica VALUES (5, 'Clinica E', 'bd617a4191490110596ad2cde7876a3c');
INSERT INTO clinica VALUES (6, 'Clinica F', 'a4b145d071746f2d774895e4a1120967');
INSERT INTO clinica VALUES (7, 'Clinica G', 'c6734e24eedb1b5960bd428a06c80c79');
INSERT INTO clinica VALUES (8, 'Clinica H', '5a1c41616aa60797c39889f212522845');


--
-- Data for Name: consulta; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO consulta VALUES (1, 13072640651, 42279095602, '1995-12-10');
INSERT INTO consulta VALUES (2, 57003539180, 45853145443, '2017-01-15');
INSERT INTO consulta VALUES (3, 40424332855, 46854340391, '2016-03-28');
INSERT INTO consulta VALUES (4, 13072640651, 82609205883, '2016-07-30');
INSERT INTO consulta VALUES (5, 35149817107, 29112712456, '2017-02-21');
INSERT INTO consulta VALUES (6, 13062640650, 35250308247, '2015-11-30');
INSERT INTO consulta VALUES (7, 95726404943, 26407639286, '2015-03-15');
INSERT INTO consulta VALUES (8, 99778398530, 29112712456, '2016-07-19');
INSERT INTO consulta VALUES (56, 67029386446, 45380537574, '2017-10-16');
INSERT INTO consulta VALUES (78, 84065496850, 45853145443, '2015-11-28');


--
-- Data for Name: conta; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO conta VALUES (13062640650, 314330200);
INSERT INTO conta VALUES (13072640651, 442984885);
INSERT INTO conta VALUES (31086957095, 554341308);
INSERT INTO conta VALUES (25283537055, 605161057);
INSERT INTO conta VALUES (84065496850, 566276709);
INSERT INTO conta VALUES (40424332855, 517014716);
INSERT INTO conta VALUES (99778398530, 24700402);
INSERT INTO conta VALUES (57003539180, 666188374);
INSERT INTO conta VALUES (35460252500, 676287682);
INSERT INTO conta VALUES (35149817107, 580958655);
INSERT INTO conta VALUES (59667392665, 207708568);
INSERT INTO conta VALUES (21591984080, 477541894);
INSERT INTO conta VALUES (95726404943, 429116793);
INSERT INTO conta VALUES (67029386446, 862133711);


--
-- Data for Name: dieta; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO dieta VALUES (1, '377e89a286353bdf13c9ccd972129da2');
INSERT INTO dieta VALUES (2, 'bad115c1fbc9286afb2d0d9db149d853');
INSERT INTO dieta VALUES (3, 'a3898794ea48cb09cd668e7d471fee11');
INSERT INTO dieta VALUES (4, 'c2bcc6bbeacdbd0c9b8843f71a623999');
INSERT INTO dieta VALUES (5, '1550d40a7f49e8f4cf3a6ff57121f602');
INSERT INTO dieta VALUES (6, '7ad7ec739ba44cc3792c2cd38e0fa8bf');
INSERT INTO dieta VALUES (7, '97d4177c4f356fba708eb67682e12d2a');
INSERT INTO dieta VALUES (8, '071e0f95a15eddb95b3e2ae8437a070a');
INSERT INTO dieta VALUES (9, '1240083e2b6f58b3c0f0a36ceef06655');
INSERT INTO dieta VALUES (10, 'ca576b637bc00f76842da172fa552349');
INSERT INTO dieta VALUES (11, '5025738558ec1fdf78b7420eb80d2ecd');
INSERT INTO dieta VALUES (12, '5019ff792993de144aab0db0b7527a93');


--
-- Data for Name: ed_alimentar; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO ed_alimentar VALUES (95726404943, 26407639286, 7, 'Vitamina B12,C,D');


--
-- Data for Name: emagrecimento; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO emagrecimento VALUES (57003539180, 45853145443, 2, 120, 90);
INSERT INTO emagrecimento VALUES (84065496850, 45853145443, 78, 150, 110);


--
-- Data for Name: mensagem; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO mensagem VALUES (25283537055, 29112712456, 'Quando posso iniciar um tratamento?', '2015-11-30');
INSERT INTO mensagem VALUES (31086957095, 45853145443, 'Me encontre as 12horas na clinica', '2017-01-15');
INSERT INTO mensagem VALUES (31086957095, 65519865238, 'Olá , notei que você não vem a nossa clinica faz algum tempo, aconteceu algo?', '2017-02-21');
INSERT INTO mensagem VALUES (13072640651, 29112712456, 'Uma consulta para daqui a 8 dias, por favor ?', '2013-05-13');
INSERT INTO mensagem VALUES (57003539180, 26407639286, 'Não, não podemos te atender, desculpe!', '2016-07-31');
INSERT INTO mensagem VALUES (21591984080, 45853145443, 'Qual receita me recomenda?', '2017-04-01');
INSERT INTO mensagem VALUES (59667392665, 29112712456, 'Ainda não cadastramos nenhum telefone seu no sistema, você possui algum ?', '2015-03-18');


--
-- Data for Name: musculacao; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO musculacao VALUES (40424332855, 46854340391, 3, 'Lista de exercicios:
-A
-B
-C
-D');


--
-- Data for Name: nutricionista; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO nutricionista VALUES (45853145443, 7, 'Vania');
INSERT INTO nutricionista VALUES (42279095602, 1, 'Clarice');
INSERT INTO nutricionista VALUES (10445663612, 5, 'Gustavo');
INSERT INTO nutricionista VALUES (35250308247, 7, 'Yago');
INSERT INTO nutricionista VALUES (82609205883, 6, 'Junior Flavio');
INSERT INTO nutricionista VALUES (34595951297, 1, 'Manelita');
INSERT INTO nutricionista VALUES (46854340391, 4, 'Lara Croft');
INSERT INTO nutricionista VALUES (65519865238, 2, 'Eugenia');
INSERT INTO nutricionista VALUES (61234746407, 5, 'Rodrigo Luis');
INSERT INTO nutricionista VALUES (90467826797, 2, 'Lucas Ribeiro');
INSERT INTO nutricionista VALUES (24727030610, 4, 'Paulo Pato');
INSERT INTO nutricionista VALUES (45380537574, 2, 'Tania');
INSERT INTO nutricionista VALUES (42692571365, 1, 'Varginha');
INSERT INTO nutricionista VALUES (26407639286, 7, 'Fabio');
INSERT INTO nutricionista VALUES (29112712456, 3, 'Otavio');


--
-- Data for Name: paciente; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO paciente VALUES (13062640650, 'asdsa', 'dasd', '1997-09-22', NULL, NULL);
INSERT INTO paciente VALUES (13072640651, 'Noutro', 'Isso', '2015-10-22', NULL, NULL);
INSERT INTO paciente VALUES (31086957095, 'Geraldo', '69d222d3b0a8ad8c2c623e6a0fb383cb', '1957-11-16', 6, '2012-11-16');
INSERT INTO paciente VALUES (25283537055, 'Eslovaquio', '411d888729cee0ac4afb81bde0c3fbd4', '1927-11-16', 6, '2013-11-16');
INSERT INTO paciente VALUES (84065496850, 'Britnei', 'd8feb6b9600057eb6834a6c534fe350e', '2007-11-16', 2, '2012-11-16');
INSERT INTO paciente VALUES (40424332855, 'Manoel Teles', '907bbcd4a723c9a5a3d969dd5ddadc5d', '1947-11-16', 5, '2018-11-16');
INSERT INTO paciente VALUES (99778398530, 'Jurandir', 'e1262058c0d695ab602fdf153ea12a1f', '2017-11-16', 5, '2019-11-16');
INSERT INTO paciente VALUES (57003539180, 'Camila', '6823b29c1ab5ff875db8dcad6e29fb66', '1977-09-08', 7, '2013-11-16');
INSERT INTO paciente VALUES (35460252500, 'Patricia Brava', 'b05e255bd26bed06bd81f03381a91d45', '1957-05-17', 2, '2015-11-16');
INSERT INTO paciente VALUES (35149817107, 'Jorge Mendes', '842f4e43f9096e6cb6bad82a5fe588c1', '2007-08-03', 4, '2015-09-12');
INSERT INTO paciente VALUES (59667392665, 'Suzyane', '4c181be2d47293e6e9bd845445278388', '2017-12-23', 4, '2019-11-16');
INSERT INTO paciente VALUES (21591984080, 'Luana', '1ea99213b77ec7db0628241eba338be6', '2010-06-16', 6, '2020-10-23');
INSERT INTO paciente VALUES (95726404943, 'Raiane', '5d418fb67d7c311ab4f79d00f5a952f9', '1937-11-16', 2, '2021-05-18');
INSERT INTO paciente VALUES (67029386446, 'Geraldo Gutes', '5c26ffa1de454aa3cfba4a0849a85a20', '2007-11-16', 4, '2020-03-01');


--
-- Data for Name: plano_saude; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO plano_saude VALUES (1, 'PlanoA', 10);
INSERT INTO plano_saude VALUES (2, 'PlanoB', 15);
INSERT INTO plano_saude VALUES (3, 'PlanoC', 20);
INSERT INTO plano_saude VALUES (4, 'PlanoD', 23);
INSERT INTO plano_saude VALUES (5, 'PlanoE', 27);
INSERT INTO plano_saude VALUES (7, 'PlanoG', 43);
INSERT INTO plano_saude VALUES (6, 'PlanoF', 34);


--
-- Data for Name: planos_aceitos; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO planos_aceitos VALUES (2, 3);
INSERT INTO planos_aceitos VALUES (2, 4);
INSERT INTO planos_aceitos VALUES (1, 2);
INSERT INTO planos_aceitos VALUES (1, 7);
INSERT INTO planos_aceitos VALUES (1, 6);
INSERT INTO planos_aceitos VALUES (7, 1);
INSERT INTO planos_aceitos VALUES (7, 4);
INSERT INTO planos_aceitos VALUES (4, 3);
INSERT INTO planos_aceitos VALUES (3, 6);
INSERT INTO planos_aceitos VALUES (2, 5);
INSERT INTO planos_aceitos VALUES (5, 5);
INSERT INTO planos_aceitos VALUES (5, 3);
INSERT INTO planos_aceitos VALUES (1, 1);
INSERT INTO planos_aceitos VALUES (1, 3);
INSERT INTO planos_aceitos VALUES (1, 4);
INSERT INTO planos_aceitos VALUES (1, 5);
INSERT INTO planos_aceitos VALUES (1, 8);


--
-- Data for Name: prod_industrial; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO prod_industrial VALUES (715, '2019-05-13');
INSERT INTO prod_industrial VALUES (448, '2019-01-01');


--
-- Data for Name: prod_natural; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO prod_natural VALUES (392, '2017-01-01');
INSERT INTO prod_natural VALUES (802, '2017-06-01');
INSERT INTO prod_natural VALUES (139, '2016-08-01');


--
-- Data for Name: produto; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO produto VALUES (802, '6f812d50c18ca609c8766d8c7aad6538', '20 - 30', 'Prod A');
INSERT INTO produto VALUES (715, 'b13647be1cc40a599a8dd3c6e9986c0d', '25 - 30', 'Prod B');
INSERT INTO produto VALUES (329, 'ee30e7d1e750bf839df8c2f457162f6a', '10 - 18', 'Prod C');
INSERT INTO produto VALUES (139, '7f8124891c390866804b652ab575df74', '13 - 17', 'Prod D');
INSERT INTO produto VALUES (392, 'fb10257c4fc2f2ef50d376f3a039c3ae', '21 - 25', 'Prod E');
INSERT INTO produto VALUES (448, '37d3903278a4035728a46b3dcc67c64a', '5 - 10', 'Prod F');
INSERT INTO produto VALUES (583, '61a9a47ec046bdf4cab8786a7f51f523', '2 - 8', 'Prod G');


--
-- Data for Name: receita; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO receita VALUES (477, 45853145443, '62c2c069a4702ef3ed498d65d027c176', 'MGXNWCQUIKICTGO');
INSERT INTO receita VALUES (117, 35250308247, '2069eabeb3c4612194f39ebebe135ebb', 'sdsafdfsda');
INSERT INTO receita VALUES (431, 34595951297, '8f4af1e5db49357a7f951386e1c1502a', 'gjusf');
INSERT INTO receita VALUES (387, 65519865238, '26a9dd24a122d953c0be8acf994217e0', 'VGJHGFDD');
INSERT INTO receita VALUES (119, 24727030610, '68797a5213f79454e461c77978cb7cbb', 'SFGGO');
INSERT INTO receita VALUES (68, 61234746407, '9a34cff0501f4a2c237fc007389c602a', 'DSADFDS');
INSERT INTO receita VALUES (393, 90467826797, 'ecc466dd2e4044734242e94d4bb58679', 'ASDDFDS');
INSERT INTO receita VALUES (182, 42692571365, 'b4b1b49a944426e3526b47a1e29b2de1', 'DADDSAD');
INSERT INTO receita VALUES (126, 45380537574, 'cc9186dbf3c9a6beb7a8f54e98c57cc1', 'SDAMJLQUIASDAS');
INSERT INTO receita VALUES (348, 26407639286, 'e513c56726960872722ffa1d2cae2961', 'UGNWCQUDAS');
INSERT INTO receita VALUES (128, 29112712456, 'd6f8c525e66ff77b5427d3f230c446e5', 'JODJJL');
INSERT INTO receita VALUES (345, 42279095602, '7bf05b907a69eb0af41ceeff1c1a323c', 'GFDDHT');


--
-- Data for Name: receita_produto; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO receita_produto VALUES (392, 387);
INSERT INTO receita_produto VALUES (139, 387);
INSERT INTO receita_produto VALUES (715, 393);
INSERT INTO receita_produto VALUES (583, 431);
INSERT INTO receita_produto VALUES (139, 345);
INSERT INTO receita_produto VALUES (583, 477);
INSERT INTO receita_produto VALUES (448, 182);
INSERT INTO receita_produto VALUES (392, 431);
INSERT INTO receita_produto VALUES (139, 68);


--
-- Data for Name: recomendacao; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO recomendacao VALUES (345, 42279095602, 10);
INSERT INTO recomendacao VALUES (345, 42279095602, 9);
INSERT INTO recomendacao VALUES (68, 10445663612, 1);
INSERT INTO recomendacao VALUES (126, 34595951297, 3);
INSERT INTO recomendacao VALUES (126, 46854340391, 10);


--
-- Data for Name: telefone; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO telefone VALUES (13062640650, 67733223);
INSERT INTO telefone VALUES (13072640651, 42766706);
INSERT INTO telefone VALUES (31086957095, 88954767);
INSERT INTO telefone VALUES (25283537055, 44694158);
INSERT INTO telefone VALUES (84065496850, 38604378);
INSERT INTO telefone VALUES (40424332855, 25986053);
INSERT INTO telefone VALUES (99778398530, 67107639);
INSERT INTO telefone VALUES (57003539180, 26990273);
INSERT INTO telefone VALUES (35460252500, 87879458);
INSERT INTO telefone VALUES (35149817107, 94614540);
INSERT INTO telefone VALUES (59667392665, 51687907);
INSERT INTO telefone VALUES (95726404943, 70067305);
INSERT INTO telefone VALUES (67029386446, 47581436);


--
-- Data for Name: tratamento; Type: TABLE DATA; Schema: Nutri; Owner: postgres
--

INSERT INTO tratamento VALUES (NULL, 40424332855, 46854340391, 3, '2016-03-30', 'algumas instruçoes', 50);
INSERT INTO tratamento VALUES (9, 95726404943, 26407639286, 7, '2015-03-20', 'Seguir a dieta corretamento e fazer os seguintes exercicios ~', 78.3000031);
INSERT INTO tratamento VALUES (NULL, 13062640650, 35250308247, 6, '2015-11-30', NULL, 30.5);
INSERT INTO tratamento VALUES (12, 13072640651, 42279095602, 1, '1995-12-11', '', 103);
INSERT INTO tratamento VALUES (3, 84065496850, 45853145443, 78, '2015-12-01', 'Instrucoes', 99.9000015);
INSERT INTO tratamento VALUES (10, 57003539180, 45853145443, 2, '2017-01-15', NULL, 130);
INSERT INTO tratamento VALUES (5, 99778398530, 29112712456, 8, '2016-07-20', NULL, 41);
INSERT INTO tratamento VALUES (NULL, 67029386446, 45380537574, 56, '2017-10-17', NULL, 100);


--
-- Name: clinica clinica_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY clinica
    ADD CONSTRAINT clinica_pkey PRIMARY KEY (cod);


--
-- Name: consulta consulta_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY consulta
    ADD CONSTRAINT consulta_pkey PRIMARY KEY (id, cpfp, cpfn);


--
-- Name: conta conta_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY conta
    ADD CONSTRAINT conta_pkey PRIMARY KEY (cpfp, senha);


--
-- Name: dieta dieta_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY dieta
    ADD CONSTRAINT dieta_pkey PRIMARY KEY (cod);


--
-- Name: ed_alimentar ed_alimentar_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY ed_alimentar
    ADD CONSTRAINT ed_alimentar_pkey PRIMARY KEY (cpfp, cpfn, id);


--
-- Name: emagrecimento emagrecimento_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY emagrecimento
    ADD CONSTRAINT emagrecimento_pkey PRIMARY KEY (cpfp, cpfn, id);


--
-- Name: mensagem mensagem_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY mensagem
    ADD CONSTRAINT mensagem_pkey PRIMARY KEY (cpfp, cpfn, texto);


--
-- Name: musculacao musculacao_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY musculacao
    ADD CONSTRAINT musculacao_pkey PRIMARY KEY (cpfp, cpfn, id);


--
-- Name: nutricionista nutricionista_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY nutricionista
    ADD CONSTRAINT nutricionista_pkey PRIMARY KEY (cpf);


--
-- Name: paciente paciente_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY paciente
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (cpf);


--
-- Name: plano_saude plano_saude_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY plano_saude
    ADD CONSTRAINT plano_saude_pkey PRIMARY KEY (cod);


--
-- Name: planos_aceitos planos_aceitos_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY planos_aceitos
    ADD CONSTRAINT planos_aceitos_pkey PRIMARY KEY (cod_plan, cod_clin);


--
-- Name: prod_industrial prod_industrial_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY prod_industrial
    ADD CONSTRAINT prod_industrial_pkey PRIMARY KEY (cod);


--
-- Name: prod_natural prod_natural_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY prod_natural
    ADD CONSTRAINT prod_natural_pkey PRIMARY KEY (cod);


--
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (cod);


--
-- Name: receita receita_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY receita
    ADD CONSTRAINT receita_pkey PRIMARY KEY (cod);


--
-- Name: receita_produto receita_produto_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY receita_produto
    ADD CONSTRAINT receita_produto_pkey PRIMARY KEY (cod_p, cod_r);


--
-- Name: recomendacao recomendacao_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY recomendacao
    ADD CONSTRAINT recomendacao_pkey PRIMARY KEY (cod_r, cpfn, cod_dieta);


--
-- Name: telefone telefone_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY telefone
    ADD CONSTRAINT telefone_pkey PRIMARY KEY (numero, cpf);


--
-- Name: tratamento tratamento_pkey; Type: CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY tratamento
    ADD CONSTRAINT tratamento_pkey PRIMARY KEY (cpfp, cpfn, id);


--
-- Name: hash_name; Type: INDEX; Schema: Nutri; Owner: postgres
--

CREATE INDEX hash_name ON clinica USING hash (nome);


--
-- Name: nutri_index; Type: INDEX; Schema: Nutri; Owner: postgres
--

CREATE INDEX nutri_index ON nutricionista USING btree (cpf);


--
-- Name: nutri_name; Type: INDEX; Schema: Nutri; Owner: postgres
--

CREATE INDEX nutri_name ON nutricionista USING hash (nome);


--
-- Name: pac_index; Type: INDEX; Schema: Nutri; Owner: postgres
--

CREATE INDEX pac_index ON paciente USING btree (cpf);


--
-- Name: pac_name; Type: INDEX; Schema: Nutri; Owner: postgres
--

CREATE INDEX pac_name ON paciente USING hash (nome);


--
-- Name: product_name; Type: INDEX; Schema: Nutri; Owner: postgres
--

CREATE INDEX product_name ON produto USING hash (nome);


--
-- Name: receita_name; Type: INDEX; Schema: Nutri; Owner: postgres
--

CREATE INDEX receita_name ON receita USING hash (nome);


--
-- Name: tratamento alem_consulta; Type: TRIGGER; Schema: Nutri; Owner: postgres
--

CREATE TRIGGER alem_consulta BEFORE INSERT OR UPDATE ON tratamento FOR EACH ROW EXECUTE PROCEDURE verif_date();


--
-- Name: tratamento calc_desconto; Type: TRIGGER; Schema: Nutri; Owner: postgres
--

CREATE TRIGGER calc_desconto BEFORE INSERT OR UPDATE ON tratamento FOR EACH ROW EXECUTE PROCEDURE descontar();


--
-- Name: paciente cpf_invalid1; Type: TRIGGER; Schema: Nutri; Owner: postgres
--

CREATE TRIGGER cpf_invalid1 BEFORE INSERT OR UPDATE ON paciente FOR EACH ROW WHEN (((new.cpf < '10000000000'::bigint) OR (new.cpf > '99999999999'::bigint))) EXECUTE PROCEDURE no_insert();


--
-- Name: nutricionista cpf_invalid2; Type: TRIGGER; Schema: Nutri; Owner: postgres
--

CREATE TRIGGER cpf_invalid2 BEFORE INSERT OR UPDATE ON nutricionista FOR EACH ROW WHEN (((new.cpf < '10000000000'::bigint) OR (new.cpf > '99999999999'::bigint))) EXECUTE PROCEDURE no_insert();


--
-- Name: plano_saude desconto_invalid; Type: TRIGGER; Schema: Nutri; Owner: postgres
--

CREATE TRIGGER desconto_invalid BEFORE INSERT OR UPDATE ON plano_saude FOR EACH ROW EXECUTE PROCEDURE verif_desconto();


--
-- Name: emagrecimento peso_invalido; Type: TRIGGER; Schema: Nutri; Owner: postgres
--

CREATE TRIGGER peso_invalido BEFORE INSERT OR UPDATE ON emagrecimento FOR EACH ROW EXECUTE PROCEDURE verif_peso();


--
-- Name: conta senha_invalida; Type: TRIGGER; Schema: Nutri; Owner: postgres
--

CREATE TRIGGER senha_invalida BEFORE INSERT OR UPDATE ON conta FOR EACH ROW WHEN (((new.senha < 100000) OR (new.senha > 999999999))) EXECUTE PROCEDURE no_insert();


--
-- Name: prod_natural v_safra; Type: TRIGGER; Schema: Nutri; Owner: postgres
--

CREATE TRIGGER v_safra BEFORE INSERT OR UPDATE ON prod_natural FOR EACH ROW EXECUTE PROCEDURE verif_safra();


--
-- Name: prod_industrial vencimento; Type: TRIGGER; Schema: Nutri; Owner: postgres
--

CREATE TRIGGER vencimento BEFORE INSERT OR UPDATE ON prod_industrial FOR EACH ROW EXECUTE PROCEDURE verif_vencimento();


--
-- Name: consulta consulta_cpfn_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY consulta
    ADD CONSTRAINT consulta_cpfn_fkey FOREIGN KEY (cpfn) REFERENCES nutricionista(cpf);


--
-- Name: consulta consulta_cpfp_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY consulta
    ADD CONSTRAINT consulta_cpfp_fkey FOREIGN KEY (cpfp) REFERENCES paciente(cpf);


--
-- Name: conta conta_cpfp_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY conta
    ADD CONSTRAINT conta_cpfp_fkey FOREIGN KEY (cpfp) REFERENCES paciente(cpf);


--
-- Name: ed_alimentar ed_alimentar_cpfp_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY ed_alimentar
    ADD CONSTRAINT ed_alimentar_cpfp_fkey FOREIGN KEY (cpfp, cpfn, id) REFERENCES tratamento(cpfp, cpfn, id);


--
-- Name: emagrecimento emagrecimento_cpfp_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY emagrecimento
    ADD CONSTRAINT emagrecimento_cpfp_fkey FOREIGN KEY (cpfp, cpfn, id) REFERENCES tratamento(cpfp, cpfn, id);


--
-- Name: mensagem mensagem_cpfn_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY mensagem
    ADD CONSTRAINT mensagem_cpfn_fkey FOREIGN KEY (cpfn) REFERENCES nutricionista(cpf);


--
-- Name: mensagem mensagem_cpfp_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY mensagem
    ADD CONSTRAINT mensagem_cpfp_fkey FOREIGN KEY (cpfp) REFERENCES paciente(cpf);


--
-- Name: musculacao musculacao_cpfp_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY musculacao
    ADD CONSTRAINT musculacao_cpfp_fkey FOREIGN KEY (cpfp, cpfn, id) REFERENCES tratamento(cpfp, cpfn, id);


--
-- Name: nutricionista nutricionista_cod_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY nutricionista
    ADD CONSTRAINT nutricionista_cod_fkey FOREIGN KEY (cod) REFERENCES clinica(cod);


--
-- Name: paciente paciente_cod_plan_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY paciente
    ADD CONSTRAINT paciente_cod_plan_fkey FOREIGN KEY (cod_plan) REFERENCES plano_saude(cod);


--
-- Name: planos_aceitos planos_aceitos_cod_clin_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY planos_aceitos
    ADD CONSTRAINT planos_aceitos_cod_clin_fkey FOREIGN KEY (cod_clin) REFERENCES clinica(cod);


--
-- Name: planos_aceitos planos_aceitos_cod_plan_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY planos_aceitos
    ADD CONSTRAINT planos_aceitos_cod_plan_fkey FOREIGN KEY (cod_plan) REFERENCES plano_saude(cod);


--
-- Name: prod_industrial prod_industrial_cod_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY prod_industrial
    ADD CONSTRAINT prod_industrial_cod_fkey FOREIGN KEY (cod) REFERENCES produto(cod);


--
-- Name: prod_natural prod_natural_cod_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY prod_natural
    ADD CONSTRAINT prod_natural_cod_fkey FOREIGN KEY (cod) REFERENCES produto(cod);


--
-- Name: receita receita_cpfn_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY receita
    ADD CONSTRAINT receita_cpfn_fkey FOREIGN KEY (cpfn) REFERENCES nutricionista(cpf);


--
-- Name: receita_produto receita_produto_cod_p_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY receita_produto
    ADD CONSTRAINT receita_produto_cod_p_fkey FOREIGN KEY (cod_p) REFERENCES produto(cod);


--
-- Name: receita_produto receita_produto_cod_r_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY receita_produto
    ADD CONSTRAINT receita_produto_cod_r_fkey FOREIGN KEY (cod_r) REFERENCES receita(cod);


--
-- Name: recomendacao recomendacao_cod_dieta_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY recomendacao
    ADD CONSTRAINT recomendacao_cod_dieta_fkey FOREIGN KEY (cod_dieta) REFERENCES dieta(cod);


--
-- Name: recomendacao recomendacao_cod_r_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY recomendacao
    ADD CONSTRAINT recomendacao_cod_r_fkey FOREIGN KEY (cod_r) REFERENCES receita(cod);


--
-- Name: recomendacao recomendacao_cpfn_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY recomendacao
    ADD CONSTRAINT recomendacao_cpfn_fkey FOREIGN KEY (cpfn) REFERENCES nutricionista(cpf);


--
-- Name: telefone telefone_cpf_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY telefone
    ADD CONSTRAINT telefone_cpf_fkey FOREIGN KEY (cpf) REFERENCES paciente(cpf);


--
-- Name: tratamento tratamento_cod_dieta_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY tratamento
    ADD CONSTRAINT tratamento_cod_dieta_fkey FOREIGN KEY (cod_dieta) REFERENCES dieta(cod);


--
-- Name: tratamento tratamento_cpfp_fkey; Type: FK CONSTRAINT; Schema: Nutri; Owner: postgres
--

ALTER TABLE ONLY tratamento
    ADD CONSTRAINT tratamento_cpfp_fkey FOREIGN KEY (cpfp, cpfn, id) REFERENCES consulta(cpfp, cpfn, id);


--
-- PostgreSQL database dump complete
--

