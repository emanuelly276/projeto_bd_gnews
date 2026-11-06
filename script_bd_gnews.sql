CREATE TABLE noticia(

  id_noticia SERIAL PRIMARY KEY,

  titulo           varchar(255),
  subtitulo        varchar(255),
  conteudo_texto   varchar(255),
  status           varchar(255),
  data_publicacao  timestamp,
  data_criacao     timestamp,
  fk_jornalista    bigint,
  fk_categoria     bigint,

  CONSTRAINT fk_jornalista FOREIGN KEY (fk_jornalista) REFERENCES jornalista (id_jornalista),
  CONSTRAINT fk_categoria FOREIGN KEY (fk_categoria) REFERENCES categoria (id_categoria)

);

CREATE TABLE curtida_noticia(

  id_curtida SERIAL PRIMARY KEY,
  fk_jornalista   int,
  data_reacao     timestamp,

  CONSTRAINT fk_jornalista FOREIGN KEY (fk_jornalista) REFERENCES jornalista (id_jornalista)

);

INSERT INTO noticia (titulo, subtitulo, conteudo_texto, status, data_publicacao, data_criacao) VALUES ('Cidade inaugura primeiro parque 100% sustentável', 'Novo espaço de lazer conta com iluminação autossuficiente, Wi-Fi gratuito e áreas de preservação da fauna local.', 'texto grande', 'Publicada', '2026-08-15 14:30:00', '2026-08-15 14:01:00');

SELECT * FROM noticia;

CREATE TABLE historico_revisao (

  id_historico SERIAL PRIMARY KEY,

  observacao_revisao   varchar (255),
  status_aplicado      varchar (255),
  data_alteracao       timestamp,
  fk_noticia           bigint,
  CONSTRAINT fk_noticia FOREIGN KEY (fk_noticia) REFERENCES noticia (id_noticia)
  
);

SELECT * FROM historico_revisao;

INSERT INTO  historico_revisao(observacao_revisao, status_aplicado, data_alteracao) VALUES ('Observação concluida com sucesso e sem erros', 'Ok', '2026-12-30 14:30:00' );

CREATE TABLE midia_noticia (
  id_noticia SERIAL PRIMARY KEY,
  tipo_midia   varchar(255),
  url_arquivo  varchar(500),
  legenda      varchar(255),
  data_upload  timestamp,
  fk_noticia   bigint,
  CONSTRAINT fk_noticia FOREIGN KEY (fk_noticia) REFERENCES noticia (id_noticia)
);         

SELECT * FROM midia_noticia;

INSERT INTO  midia_noticia(tipo_midia, url_arquivo, legenda, data_upload) VALUES ('Página web', 'www.gnews.com', 'Parque sustentável', '2027-01-01 03:00:34' );


CREATE TABLE usuario(
  id_usuario serial primary key,
  nome                varchar(255) not null,
  email               varchar(255) null,
  senha_hash          varchar(255),
  data_nascimento     date,
  tipo_perfil         varchar(255),
  data_cadastro       timestamp
);

CREATE TABLE jornalista(

  id_jornalista SERIAL PRIMARY KEY,

  fk_usuario                 bigint,
  registro_profissional      varchar(255) null,
  biografia                  character varying(255),
  especialidade              varchar(255) null,

  CONSTRAINT fk_usuario FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario)

);

CREATE TABLE comentario(
  id_comentario SERIAL PRIMARY KEY,
  registro_profissional   varchar(255) not null,
  biografia               varchar(255) null,
  entrevista              character varying(255),
  especialidade           varchar(255) null,
  fk_usuario              bigint,
  fk_noticia              bigint,

  CONSTRAINT fk_noticia FOREIGN KEY (fk_noticia) REFERENCES noticia (id_noticia),
  CONSTRAINT fk_usuario FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario)

);

CREATE TABLE tag(
  id_tag SERIAL PRIMARY KEY,
  nome_tag      varchar(50) NOT NULL
);

create table categoria(
  id_categoria serial primary key,

  nome_categoria     varchar(100) null,
  descricao          varchar(255) null,
  slug               varchar(100)


);

CREATE TABLE noticia_tag(
  id_noticia_tag serial primary key,
  fk_noticia   bigint,
  fk_tag      bigint,

  CONSTRAINT fk_noticia FOREIGN KEY (fk_noticia) REFERENCES noticia(id_noticia),
  CONSTRAINT fk_tag FOREIGN KEY (fk_tag) REFERENCES tag (id_tag)
);
