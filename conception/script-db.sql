/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 11g                            */
/* Date de création :  08/06/2021 19:56:25                      */
/*==============================================================*/


alter table BET
   drop constraint FK_BET_RELATION__BETCATEG;

alter table BET
   drop constraint FK_BET_RELATION__USERS;

alter table BETCATEGORY
   drop constraint FK_BETCATEG_RELATION__CATEGORY;

alter table MATCH
   drop constraint FK_MATCH_RELATION__CATEGORY;

alter table MATCH
   drop constraint FK_MATCH_RELATION__TEAM_A;

alter table MATCH
   drop constraint FK_MATCH_RELATION__TEAM_B;

alter table TEAM
   drop constraint FK_TEAM_RELATION__CATEGORY;

drop index RELATION_6_FK;

drop index RELATION_5_FK;

drop table BET cascade constraints;

drop index RELATION_7_FK;

drop table BETCATEGORY cascade constraints;

drop table CATEGORY cascade constraints;

drop index RELATION_4_FK;

drop index RELATION_3_FK;

drop index RELATION_2_FK;

drop table MATCH cascade constraints;

drop index RELATION_1_FK;

drop table TEAM cascade constraints;

drop table USERS cascade constraints;

drop sequence S_BET;

drop sequence S_BETCATEGORY;

drop sequence S_CATEGORY;

drop sequence S_MATCH;

drop sequence S_TEAM;

create sequence S_BET;

create sequence S_BETCATEGORY;

create sequence S_CATEGORY;

create sequence S_MATCH;

create sequence S_TEAM;

/*==============================================================*/
/* Table : BET                                                  */
/*==============================================================*/
create table BET 
(
   IDBET                NUMBER(6)            not null,
   IDBETCATEGORY        NUMBER(6),
   EMAIL                VARCHAR2(150),
   BETVALUE             NUMBER(8,2)          not null,
   BETDATE              TIMESTAMP            default CURRENT_DATE not null,
   WINNINGRATE          NUMBER(6,2)          not null,
   constraint PK_BET primary key (IDBET)
);

/*==============================================================*/
/* Index : RELATION_5_FK                                        */
/*==============================================================*/
create index RELATION_5_FK on BET (
   IDBETCATEGORY ASC
);

/*==============================================================*/
/* Index : RELATION_6_FK                                        */
/*==============================================================*/
create index RELATION_6_FK on BET (
   EMAIL ASC
);

/*==============================================================*/
/* Table : BETCATEGORY                                          */
/*==============================================================*/
create table BETCATEGORY 
(
   IDBETCATEGORY        NUMBER(6)            not null,
   IDCATEGORY           NUMBER(6),
   BETCATEGORYLABEL     VARCHAR2(30)         not null,
   CURRENTWINNINGRATE   NUMBER(6,2)          not null,
   constraint PK_BETCATEGORY primary key (IDBETCATEGORY)
);

/*==============================================================*/
/* Index : RELATION_7_FK                                        */
/*==============================================================*/
create index RELATION_7_FK on BETCATEGORY (
   IDCATEGORY ASC
);

/*==============================================================*/
/* Table : CATEGORY                                             */
/*==============================================================*/
create table CATEGORY 
(
   IDCATEGORY           NUMBER(6)            not null,
   CATEGORYLABEL        VARCHAR2(30)         not null,
   STATE                INTEGER              default 0,
   constraint PK_CATEGORY primary key (IDCATEGORY)
);

/*==============================================================*/
/* Table : MATCH                                                */
/*==============================================================*/
create table MATCH 
(
   IDMATCH              NUMBER(6)            not null,
   TEAM_A               NUMBER(6),
   TEAM_B               NUMBER(6),
   IDCATEGORY           NUMBER(6),
   MATCHDATE            TIMESTAMP            not null,
   STATE                INTEGER              default 0 not null,
   constraint PK_MATCH primary key (IDMATCH)
);

/*==============================================================*/
/* Index : RELATION_2_FK                                        */
/*==============================================================*/
create index RELATION_2_FK on MATCH (
   IDCATEGORY ASC
);

/*==============================================================*/
/* Index : RELATION_3_FK                                        */
/*==============================================================*/
create index RELATION_3_FK on MATCH (
   TEAM_A ASC
);

/*==============================================================*/
/* Index : RELATION_4_FK                                        */
/*==============================================================*/
create index RELATION_4_FK on MATCH (
   TEAM_B ASC
);

/*==============================================================*/
/* Table : TEAM                                                 */
/*==============================================================*/
create table TEAM 
(
   IDTEAM               NUMBER(6)            not null,
   IDCATEGORY           NUMBER(6),
   TEAMNAME             VARCHAR2(40)         not null,
   constraint PK_TEAM primary key (IDTEAM)
);

/*==============================================================*/
/* Index : RELATION_1_FK                                        */
/*==============================================================*/
create index RELATION_1_FK on TEAM (
   IDCATEGORY ASC
);

/*==============================================================*/
/* Table : USERS                                                */
/*==============================================================*/
create table USERS 
(
   EMAIL                VARCHAR2(150)        not null,
   FIRSTNAME            VARCHAR2(40)         not null,
   PASSWORD             VARCHAR2(500)        not null,
   LASTNAME             VARCHAR2(40)         not null,
   USERNAME             VARCHAR2(40)         not null,
   DAYOFBIRTH           DATE                 not null,
   STATE                INTEGER              default 0 not null,
   constraint PK_USERS primary key (EMAIL)
);

alter table BET
   add constraint FK_BET_RELATION__BETCATEG foreign key (IDBETCATEGORY)
      references BETCATEGORY (IDBETCATEGORY);

alter table BET
   add constraint FK_BET_RELATION__USERS foreign key (EMAIL)
      references USERS (EMAIL);

alter table BETCATEGORY
   add constraint FK_BETCATEG_RELATION__CATEGORY foreign key (IDCATEGORY)
      references CATEGORY (IDCATEGORY);

alter table MATCH
   add constraint FK_MATCH_RELATION__CATEGORY foreign key (IDCATEGORY)
      references CATEGORY (IDCATEGORY);

alter table MATCH
   add constraint FK_MATCH_RELATION__TEAM_A foreign key (TEAM_A)
      references TEAM (IDTEAM);

alter table MATCH
   add constraint FK_MATCH_RELATION__TEAM_B foreign key (TEAM_B)
      references TEAM (IDTEAM);

alter table TEAM
   add constraint FK_TEAM_RELATION__CATEGORY foreign key (IDCATEGORY)
      references CATEGORY (IDCATEGORY);

