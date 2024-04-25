-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2024-04-22 09:06:08 GFT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_coletaextra (
    id_coleta_e           NUMBER NOT NULL,
    t_usuario_id_usuario  NUMBER NOT NULL,
    t_qrcodes_e_id_qrcode NUMBER NOT NULL,
    dt_coleta             DATE NOT NULL,
    status                VARCHAR2(20) NOT NULL
);

CREATE UNIQUE INDEX t_coletaextra__idx ON
    t_coletaextra (
        t_qrcodes_e_id_qrcode
    ASC );

ALTER TABLE t_coletaextra ADD CONSTRAINT t_coletaextra_pk PRIMARY KEY ( id_coleta_e,
                                                                        t_usuario_id_usuario );

CREATE TABLE t_coletafixa (
    id_coleta_f           NUMBER NOT NULL,
    t_qrcodes_f_id_qrcode NUMBER NOT NULL,
    t_usuario_id_usuario  NUMBER NOT NULL,
    dt_coleta             DATE NOT NULL,
    status                VARCHAR2(20) NOT NULL
);

CREATE UNIQUE INDEX t_coletafixa__idx ON
    t_coletafixa (
        t_qrcodes_f_id_qrcode
    ASC );

CREATE UNIQUE INDEX t_coletafixa__idxv1 ON
    t_coletafixa (
        t_usuario_id_usuario
    ASC );

ALTER TABLE t_coletafixa ADD CONSTRAINT t_coletafixa_pk PRIMARY KEY ( id_coleta_f );

CREATE TABLE t_login (
    id_login             NUMBER NOT NULL,
    t_usuario_id_usuario NUMBER NOT NULL,
    email_login          VARCHAR2(100) NOT NULL,
    senha_login          VARCHAR2(20) NOT NULL
);

CREATE UNIQUE INDEX t_login__idx ON
    t_login (
        t_usuario_id_usuario
    ASC );

ALTER TABLE t_login ADD CONSTRAINT t_login_pk PRIMARY KEY ( id_login );

CREATE TABLE t_notificacoes (
    id_notificacao       NUMBER NOT NULL,
    t_usuario_id_usuario NUMBER NOT NULL,
    tp_notificacao       VARCHAR2(50) NOT NULL,
    mensagem             VARCHAR2(1000) NOT NULL,
    dt_envio             DATE NOT NULL
);

ALTER TABLE t_notificacoes ADD CONSTRAINT t_notificacoes_pk PRIMARY KEY ( id_notificacao );

CREATE TABLE t_qrcodes_e (
    id_qrcode                 NUMBER NOT NULL,
    t_coletaextra_id_coleta_e NUMBER NOT NULL,
    t_coletaextra_id_usuario  NUMBER NOT NULL,
    tipo_coleta               VARCHAR2(20) NOT NULL,
    status                    VARCHAR2(20) NOT NULL
);

CREATE UNIQUE INDEX t_qrcodes_e__idx ON
    t_qrcodes_e (
        t_coletaextra_id_coleta_e
    ASC,
        t_coletaextra_id_usuario
    ASC );

ALTER TABLE t_qrcodes_e ADD CONSTRAINT t_qrcodes_e_pk PRIMARY KEY ( id_qrcode );

CREATE TABLE t_qrcodes_f (
    id_qrcode                NUMBER NOT NULL,
    t_coletafixa_id_coleta_f NUMBER NOT NULL,
    qrcode                   CLOB NOT NULL,
    tipo_coleta              VARCHAR2(20) NOT NULL,
    status                   VARCHAR2(20) NOT NULL
);

CREATE UNIQUE INDEX t_qrcodes_f__idx ON
    t_qrcodes_f (
        t_coletafixa_id_coleta_f
    ASC );

ALTER TABLE t_qrcodes_f ADD CONSTRAINT t_qrcodes_f_pk PRIMARY KEY ( id_qrcode );

CREATE TABLE t_usuario (
    id_usuario               NUMBER NOT NULL,
    t_coletafixa_id_coleta_f NUMBER NOT NULL,
    t_login_id_login         NUMBER NOT NULL,
    nm_usuario               VARCHAR2(100) NOT NULL,
    cnpj_usuario             VARCHAR2(20) NOT NULL,
    telefone                 VARCHAR2(20) NOT NULL,
    cep                      VARCHAR2(20) NOT NULL,
    uf                       VARCHAR2(50) NOT NULL,
    cidade                   VARCHAR2(50) NOT NULL,
    bairro                   VARCHAR2(50) NOT NULL,
    rua                      VARCHAR2(50) NOT NULL,
    nr_endereco              VARCHAR2(50) NOT NULL,
    dia_coleta1              VARCHAR2(20) NOT NULL,
    dia_coleta2              VARCHAR2(20) NOT NULL,
    hr_coleta                VARCHAR2(50) NOT NULL,
    complemento              VARCHAR2(100)
);

CREATE UNIQUE INDEX t_usuario__idx ON
    t_usuario (
        t_login_id_login
    ASC );

CREATE UNIQUE INDEX t_usuario__idxv1 ON
    t_usuario (
        t_coletafixa_id_coleta_f
    ASC );

ALTER TABLE t_usuario ADD CONSTRAINT t_usuario_pk PRIMARY KEY ( id_usuario );

ALTER TABLE t_coletaextra
    ADD CONSTRAINT t_coletaextra_t_qrcodes_e_fk FOREIGN KEY ( t_qrcodes_e_id_qrcode )
        REFERENCES t_qrcodes_e ( id_qrcode );

ALTER TABLE t_coletaextra
    ADD CONSTRAINT t_coletaextra_t_usuario_fk FOREIGN KEY ( t_usuario_id_usuario )
        REFERENCES t_usuario ( id_usuario );

ALTER TABLE t_coletafixa
    ADD CONSTRAINT t_coletafixa_t_qrcodes_f_fk FOREIGN KEY ( t_qrcodes_f_id_qrcode )
        REFERENCES t_qrcodes_f ( id_qrcode );

ALTER TABLE t_coletafixa
    ADD CONSTRAINT t_coletafixa_t_usuario_fk FOREIGN KEY ( t_usuario_id_usuario )
        REFERENCES t_usuario ( id_usuario );

ALTER TABLE t_login
    ADD CONSTRAINT t_login_t_usuario_fk FOREIGN KEY ( t_usuario_id_usuario )
        REFERENCES t_usuario ( id_usuario );

ALTER TABLE t_notificacoes
    ADD CONSTRAINT t_notificacoes_t_usuario_fk FOREIGN KEY ( t_usuario_id_usuario )
        REFERENCES t_usuario ( id_usuario );

ALTER TABLE t_qrcodes_e
    ADD CONSTRAINT t_qrcodes_e_t_coletaextra_fk FOREIGN KEY ( t_coletaextra_id_coleta_e,
                                                              t_coletaextra_id_usuario )
        REFERENCES t_coletaextra ( id_coleta_e,
                                   t_usuario_id_usuario );

ALTER TABLE t_qrcodes_f
    ADD CONSTRAINT t_qrcodes_f_t_coletafixa_fk FOREIGN KEY ( t_coletafixa_id_coleta_f )
        REFERENCES t_coletafixa ( id_coleta_f );

ALTER TABLE t_usuario
    ADD CONSTRAINT t_usuario_t_coletafixa_fk FOREIGN KEY ( t_coletafixa_id_coleta_f )
        REFERENCES t_coletafixa ( id_coleta_f );

ALTER TABLE t_usuario
    ADD CONSTRAINT t_usuario_t_login_fk FOREIGN KEY ( t_login_id_login )
        REFERENCES t_login ( id_login );

CREATE SEQUENCE SQ_NOTIFICACOES
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             8
-- ALTER TABLE                             17
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

-- VERIFICACAO DE ASSIDUIDADE

-- Desabilitar as restrições de chave estrangeira para todas as tabelas

-- t_coletaextra
ALTER TABLE t_coletaextra DISABLE CONSTRAINT t_coletaextra_t_qrcodes_e_fk;
ALTER TABLE t_coletaextra DISABLE CONSTRAINT t_coletaextra_t_usuario_fk;

-- t_coletafixa
ALTER TABLE t_coletafixa DISABLE CONSTRAINT t_coletafixa_t_qrcodes_f_fk;
ALTER TABLE t_coletafixa DISABLE CONSTRAINT t_coletafixa_t_usuario_fk;

-- t_login
ALTER TABLE t_login DISABLE CONSTRAINT t_login_t_usuario_fk;

-- t_notificacoes
ALTER TABLE t_notificacoes DISABLE CONSTRAINT t_notificacoes_t_usuario_fk;

-- t_qrcodes_e
ALTER TABLE t_qrcodes_e DISABLE CONSTRAINT t_qrcodes_e_t_coletaextra_fk;

-- t_qrcodes_f
ALTER TABLE t_qrcodes_f DISABLE CONSTRAINT t_qrcodes_f_t_coletafixa_fk;

-- t_usuario
ALTER TABLE t_usuario DISABLE CONSTRAINT t_usuario_t_coletafixa_fk;
ALTER TABLE t_usuario DISABLE CONSTRAINT t_usuario_t_login_fk;

-- INPUTANDO DADOS FICTÍCIOS
    
    -- Inserir dados fictícios na tabela t_usuario
INSERT INTO t_usuario (id_usuario, t_coletafixa_id_coleta_f, t_login_id_login, nm_usuario, cnpj_usuario, telefone, cep, uf, cidade, bairro, rua, nr_endereco, dia_coleta1, dia_coleta2, hr_coleta, status, complemento)
    SELECT 1, 1, 1, 'Usuario 1', '12345678901234', '1234567890', '12345678', 'SP', 'São Paulo', 'Centro', 'Rua A', '123', 'Segunda', 'Quarta', '08:00-10:00', 'ATIVO', 'Complemento 1' FROM DUAL UNION ALL
    SELECT 2, 2, 2, 'Usuario 2', '12345678901235', '1234567891', '12345679', 'RJ', 'Rio de Janeiro', 'Copacabana', 'Rua B', '456', 'Terça', 'Quinta', '09:00-11:00', 'ATIVO', 'Complemento 2' FROM DUAL UNION ALL
    SELECT 3, 3, 3, 'Usuario 3', '12345678901236', '1234567892', '12345680', 'MG', 'Belo Horizonte', 'Savassi', 'Rua C', '789', 'Quarta', 'Sexta', '10:00-12:00', 'ATIVO', 'Complemento 3' FROM DUAL;

-- Inserir dados fictícios na tabela t_login
INSERT INTO t_login (id_login, t_usuario_id_usuario, email_login, senha_login)
    SELECT 1, 1, 'usuario1@example.com', 'senha123' FROM DUAL UNION ALL
    SELECT 2, 2, 'usuario2@example.com', 'senha456' FROM DUAL UNION ALL
    SELECT 3, 3, 'usuario3@example.com', 'senha789' FROM DUAL;
    
    -- Inserir dados fictícios na tabela t_notificacoes
INSERT INTO t_notificacoes (id_notificacao, t_usuario_id_usuario, tp_notificacao, mensagem, dt_envio)
    SELECT 1, 1, 'Alerta', 'Atenção! Seu cadastro ficou inativo devido ao não cumprimento das coletas fixas. Para recadastrar, entre em contato com o suporte.', SYSDATE FROM DUAL UNION ALL
    SELECT 2, 2, 'Alerta', 'Alerta! Suas coletas fixas estão sendo negligenciadas há algumas semanas. Por favor, entre em contato com o suporte.', SYSDATE FROM DUAL UNION ALL
    SELECT 3, 3, 'Alerta', 'Alerta de cancelamento de cadastro. Uma das coletas não foi realizada nessa semana!', SYSDATE FROM DUAL;

    -- Inserir dados fictícios na tabela t_coletaextra
INSERT INTO t_coletaextra (id_coleta_e, t_usuario_id_usuario, t_qrcodes_e_id_qrcode, dt_coleta, status)
    SELECT 1, 1, 1, SYSDATE, 'COLETADO' FROM DUAL UNION ALL
    SELECT 2, 2, 2, SYSDATE, 'PENDENTE' FROM DUAL UNION ALL
    SELECT 3, 3, 3, SYSDATE, 'NÃO COLETADO' FROM DUAL;

    -- Inserir dados fictícios na tabela t_qrcodes_e
INSERT INTO t_qrcodes_e (id_qrcode, t_coletaextra_id_coleta_e, t_coletaextra_id_usuario, tipo_coleta, status, qrcode)
    SELECT 1, 1, 1, 'Tipo 1', 'LIDO', 'QRCODE1' FROM DUAL UNION ALL
    SELECT 2, 2, 2, 'Tipo 2', 'NÃO LIDO', 'QRCODE2' FROM DUAL UNION ALL
    SELECT 3, 3, 3, 'Tipo 3', 'PENDENTE', 'QRCODE3' FROM DUAL;

-- Inserir dados fictícios na tabela t_coletafixa
INSERT INTO t_coletafixa (id_coleta_f, t_qrcodes_f_id_qrcode, t_usuario_id_usuario, dt_coleta, status)
    SELECT 1, 1, 1, SYSDATE, 'COLETADO' FROM DUAL UNION ALL
    SELECT 2, 2, 2, SYSDATE, 'PENDENTE' FROM DUAL UNION ALL
    SELECT 3, 3, 3, SYSDATE, 'NÃO COLETADO' FROM DUAL;

-- Inserir dados fictícios na tabela t_qrcodes_f
INSERT INTO t_qrcodes_f (id_qrcode, t_coletafixa_id_coleta_f, qrcode, tipo_coleta, status)
    SELECT 1, 1, 'QRCODE1', 'Tipo 1', 'LIDO' FROM DUAL UNION ALL
    SELECT 2, 2, 'QRCODE2', 'Tipo 2', 'NÃO LIDO' FROM DUAL UNION ALL
    SELECT 3, 3, 'QRCODE3', 'Tipo 3', 'PENDENTE' FROM DUAL;
    
-- Habilitar as restrições de chave estrangeira para todas as tabelas

-- t_coletaextra
ALTER TABLE t_coletaextra ENABLE CONSTRAINT t_coletaextra_t_qrcodes_e_fk;
ALTER TABLE t_coletaextra ENABLE CONSTRAINT t_coletaextra_t_usuario_fk;

-- t_coletafixa
ALTER TABLE t_coletafixa ENABLE CONSTRAINT t_coletafixa_t_qrcodes_f_fk;
ALTER TABLE t_coletafixa ENABLE CONSTRAINT t_coletafixa_t_usuario_fk;

-- t_login
ALTER TABLE t_login ENABLE CONSTRAINT t_login_t_usuario_fk;

-- t_notificacoes
ALTER TABLE t_notificacoes ENABLE CONSTRAINT t_notificacoes_t_usuario_fk;

-- t_qrcodes_e
ALTER TABLE t_qrcodes_e ENABLE CONSTRAINT t_qrcodes_e_t_coletaextra_fk;

-- t_qrcodes_f
ALTER TABLE t_qrcodes_f ENABLE CONSTRAINT t_qrcodes_f_t_coletafixa_fk;

-- t_usuario
ALTER TABLE t_usuario ENABLE CONSTRAINT t_usuario_t_coletafixa_fk;
ALTER TABLE t_usuario ENABLE CONSTRAINT t_usuario_t_login_fk;

-- PROCEDURES ------------------------------------------------------------------------------------------------------------

-- PROCEDURE DE CONTROLE DE STATUS DE COLETA FIXA

-- SEQUENCE 
CREATE SEQUENCE seq_coletafixa START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_qrcode START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE criacao_de_coletas_fixas_automatizadas AS
    v_dia_semana_atual VARCHAR2(20);
BEGIN
    -- Obter o dia atual da semana
    SELECT TO_CHAR(SYSDATE, 'Day') INTO v_dia_semana_atual FROM DUAL;

    -- Loop através dos usuários
    FOR user_rec IN (SELECT * FROM t_usuario) LOOP
        -- Verificar se o dia atual está entre os dias de coleta do usuário
        IF v_dia_semana_atual = user_rec.dia_coleta1 OR v_dia_semana_atual = user_rec.dia_coleta2 THEN
            -- Inserir linha de coleta fixa
            INSERT INTO t_coletafixa (id_coleta_f, t_qrcodes_f_id_qrcode, t_usuario_id_usuario, dt_coleta, status)
            VALUES (seq_coletafixa.nextval, seq_qrcode.nextval, user_rec.id_usuario, SYSDATE, 'Pendente');

            -- Inserir linha de QR Code
            INSERT INTO t_qrcodes_f (id_qrcode, t_coletafixa_id_coleta_f, qrcode, tipo_coleta, status)
            VALUES (seq_qrcode.nextval, seq_coletafixa.currval, 'seu_qrcode', 'Tipo Coleta', 'Pendente');

            -- Sai do loop, pois já encontrou os dois dias de coleta
            EXIT;
        END IF;
    END LOOP;
END;
/

EXEC criacao_de_coletas_fixas_automatizadas;

-- FUNÇÃO PARA ATUALIZAR O STATUS DA COLETA

CREATE OR REPLACE FUNCTION atualizar_status_qr_code (p_id_qrcode IN NUMBER) RETURN VARCHAR2 IS
    v_status_qr_code VARCHAR2(20);
BEGIN
    -- Verificar se o QR Code foi lido
    SELECT status INTO v_status_qr_code FROM t_qrcodes_f WHERE id_qrcode = p_id_qrcode;

    -- Atualizar o status do QR Code
    IF v_status_qr_code = 'Lido' THEN
        UPDATE t_qrcodes_f SET status = 'Coletado' WHERE id_qrcode = p_id_qrcode;
        RETURN 'Coletado';
    ELSE
        UPDATE t_qrcodes_f SET status = 'Não Coletado' WHERE id_qrcode = p_id_qrcode;
        RETURN 'Não Coletado';
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'QR Code não encontrado';
    WHEN OTHERS THEN
        RETURN 'Erro ao atualizar status';
END;
/
EXEC atualizar_status_qr_code;

-- CRIANDO TABELA AUXILIAR DA PROCEDURE DE VERIFICAÇÃO DE ASSIDUIDADE
CREATE TABLE T_ANALISE_SEMANA (
    id_analise    NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    id_usuario    NUMBER NOT NULL,
    dt_analise    DATE NOT NULL,
    id_coleta_f   NUMBER NOT NULL,
    CONSTRAINT fk_analise_usuario FOREIGN KEY (id_usuario) REFERENCES t_usuario (id_usuario),
    CONSTRAINT fk_analise_coleta_f FOREIGN KEY (id_coleta_f) REFERENCES t_coletafixa (id_coleta_f)
);

-- VERIFICACAO DE ASSIDUIDADE
create or replace PROCEDURE verificarAssiduidadeColetasFixas AS
BEGIN
    FOR user_rec IN (SELECT u.id_usuario,
                            u.nm_usuario,
                            cf.id_coleta_f,
                            cf.dt_coleta,
                            cf.status
                     FROM t_usuario u
                     JOIN t_coletafixa cf ON u.t_coletafixa_id_coleta_f = cf.id_coleta_f)
    LOOP
        DECLARE
            semana_anterior DATE := TRUNC(SYSDATE) - 7;
            status_anterior VARCHAR2(20);
            status_atual VARCHAR2(20);
            contador NUMBER := 0;
            semana_anterior_analisada NUMBER;
        BEGIN
        -- A semana anterior já foi analisada?
            SELECT MAX(id_coleta_f)
            INTO semana_anterior_analisada
            FROM t_analise_semana
            WHERE id_usuario = user_rec.id_usuario
              AND dt_analise = semana_anterior;

            IF semana_anterior_analisada IS NULL THEN
        --
                FOR coleta_rec IN (SELECT status
                                    FROM t_coletafixa
                                    WHERE id_coleta_f = user_rec.id_coleta_f
                                      AND dt_coleta BETWEEN semana_anterior AND TRUNC(SYSDATE))
                LOOP
                    status_atual := coleta_rec.status;

                    IF contador > 3 THEN
                        EXIT;
                    END IF;

                    IF contador > 0 THEN
                        IF status_atual = 'NÃO COLETADO' THEN
                            contador := contador + 1;
                        ELSE
                            contador := 0;
                        END IF;
                    ELSE
                        IF status_atual = 'NÃO COLETADO' THEN
                            contador := 1;
                        END IF;
                    END IF;

                    status_anterior := status_atual;
                END LOOP;

                IF contador >= 1 THEN
                    IF contador = 1 THEN
                        INSERT INTO t_notificacoes (id_notificacao, t_usuario_id_usuario, tp_notificacao, mensagem, dt_envio)
                        VALUES (SQ_NOTIFICACOES.NEXTVAL, user_rec.id_usuario, 'Alerta', 'Alerta de cancelamento de cadastro. Uma das coletas não foi realizada nessa semana!', SYSDATE);
                    ELSE
                        INSERT INTO t_notificacoes (id_notificacao, t_usuario_id_usuario, tp_notificacao, mensagem, dt_envio)
                        VALUES (SQ_NOTIFICACOES.NEXTVAL, user_rec.id_usuario, 'Alerta', 'Alerta! Suas coletas fixas estão sendo negligenciadas há algumas semanas. Por favor, entre em contato com o suporte.', SYSDATE);
                    END IF;
                END IF;

                IF contador >= 3 THEN
                    INSERT INTO t_notificacoes (id_notificacao, t_usuario_id_usuario, tp_notificacao, mensagem, dt_envio)
                    VALUES (SQ_NOTIFICACOES.NEXTVAL, user_rec.id_usuario, 'Alerta', 'Atenção! Seu cadastro ficou inativo devido ao não cumprimento das coletas fixas. Para recadastrar, entre em contato com o suporte.', SYSDATE);

                    -- Atualizar o status do usuário para INATIVO
                    UPDATE t_usuario
                    SET status = 'INATIVO'
                    WHERE id_usuario = user_rec.id_usuario;
                END IF;

                -- Registrar a análise da semana
                INSERT INTO t_analise_semana (id_usuario, dt_analise, id_coleta_f)
                VALUES (user_rec.id_usuario, semana_anterior, user_rec.id_coleta_f);
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Ignorar caso não haja dados
                NULL;
            WHEN OTHERS THEN
                -- Gerar log de exceção
                DBMS_OUTPUT.PUT_LINE('Erro ao processar usuário ' || user_rec.nm_usuario || ': ' || SQLERRM);
        END;
    END LOOP;
END verificarAssiduidadeColetasFixas;

EXEC verificarAssiduidadeColetasFixas;

-- BAIXA DE QUANTIDADE DE COLETAS

-- CRIANDO TABELA AUXILIAR DA PROCEDURE DE QUANTIDADE DE COLETAS
CREATE TABLE t_dados_coletas (
    id_dados_coletas     NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    id_usuario           NUMBER NOT NULL,
    data_coleta          DATE NOT NULL,
    tipo_coleta          VARCHAR2(10) NOT NULL, -- Pode ser 'FIXA' ou 'EXTRA'
    total                NUMBER NOT NULL
);

ALTER TABLE t_dados_coletas
    ADD CONSTRAINT t_dados_coletas_pk PRIMARY KEY (id_dados_coletas);

ALTER TABLE t_dados_coletas
    ADD CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES t_usuario (id_usuario);
    
CREATE TABLE t_log_erros (
    id_log_erro       NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    id_usuario        NUMBER NOT NULL,
    mensagem_erro     VARCHAR2(4000) NOT NULL,
    data_erro         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT t_log_erros_pk PRIMARY KEY (id_log_erro),
    CONSTRAINT fk_usuario_log_erros FOREIGN KEY (id_usuario) REFERENCES t_usuario (id_usuario)
);

CREATE OR REPLACE PROCEDURE realizarBaixaColetas AS
BEGIN
    FOR user_rec IN (SELECT u.id_usuario,
                            u.nm_usuario,
                            ce.dt_coleta AS data_coleta,
                            'EXTRA' AS tipo_coleta,
                            'COLETADO' AS status_coleta
                     FROM t_usuario u
                     JOIN t_coletaextra ce ON u.id_usuario = ce.t_usuario_id_usuario
                     WHERE ce.status = 'COLETADO'
                     UNION
                     SELECT u.id_usuario,
                            u.nm_usuario,
                            cf.dt_coleta AS data_coleta,
                            'FIXA' AS tipo_coleta,
                            'COLETADO' AS status_coleta
                     FROM t_usuario u
                     JOIN t_coletafixa cf ON u.id_usuario = cf.t_usuario_id_usuario
                     WHERE cf.status = 'COLETADO')
    LOOP
        DECLARE
            total_coletas NUMBER;
        BEGIN
            -- Calcular o total de coletas realizadas
            SELECT COUNT(*) INTO total_coletas
            FROM t_dados_coletas
            WHERE id_usuario = user_rec.id_usuario
              AND data_coleta = user_rec.data_coleta
              AND tipo_coleta = user_rec.tipo_coleta;
            
            -- Se já existe um registro para esta data e tipo de coleta, atualizar o total
            IF total_coletas > 0 THEN
                UPDATE t_dados_coletas
                SET total = total + 1
                WHERE id_usuario = user_rec.id_usuario
                  AND data_coleta = user_rec.data_coleta
                  AND tipo_coleta = user_rec.tipo_coleta;
            ELSE
                -- Caso contrário, inserir um novo registro
                INSERT INTO t_dados_coletas (id_usuario, data_coleta, tipo_coleta, total)
                VALUES (user_rec.id_usuario, user_rec.data_coleta, user_rec.tipo_coleta, 1);
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                -- Registrar o erro em uma tabela de log de erros
                INSERT INTO t_log_erros (id_usuario, mensagem_erro, data_erro)
                VALUES (user_rec.id_usuario, SQLERRM, SYSDATE);
        END;
    END LOOP;
END realizarBaixaColetas;
/

EXEC realizarBaixaColetas;
