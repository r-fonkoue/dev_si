/*
Suppression des tables
*/

DROP TABLE CLASSER;
DROP TABLE CLASSEMENT;
DROP TABLE ASSOCIER;
DROP TABLE CHRONOMETRER;
DROP TABLE PARTICIPER;
DROP TABLE EPREUVE;
DROP TABLE TYPEEPREUVE;
DROP TABLE COMPETITION;
DROP TABLE TYPECOMPETITION;
DROP TABLE PIECEJOINTE;
DROP TABLE APPARTENIR;
DROP TABLE UTILISATEUR;
DROP TABLE ROLEEQUIPE;
DROP TABLE EQUIPE;
DROP TABLE TYPEPIECEJOINTE;
DROP TABLE GENRE;
DROP TABLE RANG;
DROP TABLE CATEGORIE;

/*
Suppression des sequences
*/

DROP SEQUENCE SEQ_UTILISATEUR_ID_UTILISATEUR;
DROP SEQUENCE SEQ_RANG_ID_RANG;
DROP SEQUENCE SEQ_PIECEJOINTE_ID_PIECEJOINTE;
DROP SEQUENCE SEQ_TYPEPIECEJ_ID_TYPEPIECEJ;
DROP SEQUENCE SEQ_EQUIPE_ID_EQUIPE;
DROP SEQUENCE SEQ_ROLEEQUIPE_ID_ROLEEQUIPE;
DROP SEQUENCE SEQ_TYPECOMP_ID_TYPECOMP;
DROP SEQUENCE SEQ_COMPETITION_ID_COMPETITION;
DROP SEQUENCE SEQ_TYPEEPREUVE_ID_TYPEEPREUVE;
DROP SEQUENCE SEQ_EPREUVE_ID_EPREUVE;
DROP SEQUENCE SEQ_GENRE_ID_GENRE;
DROP SEQUENCE SEQ_CATEGORIE_ID_CATEGORIE;
DROP SEQUENCE SEQ_CLASSEMENT_ID_CLASSEMENT;

/*
Table: CATEGORIE
*/

CREATE TABLE CATEGORIE(
    ID_CATEGORIE NUMBER(10,0) NOT NULL ,
    LIBELLE      VARCHAR2(20) NOT NULL ,
    CONSTRAINT PK_CATEGORIE PRIMARY KEY (ID_CATEGORIE)
);

/*
Table: RANG
*/

CREATE TABLE RANG(
    ID_RANG NUMBER NOT NULL ,
    LIBELLE VARCHAR2(25) NOT NULL ,
    CONSTRAINT PK_RANG PRIMARY KEY (ID_RANG)
);

/*
Table: GENRE
*/

CREATE TABLE GENRE(
    ID_GENRE NUMBER(10,0) NOT NULL ,
    LIBELLE  VARCHAR2(20) NOT NULL ,
    CONSTRAINT PK_GENRE PRIMARY KEY (ID_GENRE)
);

/*
Table: TYPEPIECEJOINTE
*/

CREATE TABLE TYPEPIECEJOINTE(
    ID_TYPEPIECEJOINTE NUMBER(10,0) NOT NULL ,
    LIBELLE            VARCHAR2(25) NOT NULL ,
    CONSTRAINT PK_TYPEPIECEJOINTE PRIMARY KEY (ID_TYPEPIECEJOINTE)
);

/*
Table: EQUIPE
*/

CREATE TABLE EQUIPE(
    ID_EQUIPE NUMBER(10,0) NOT NULL ,
    NOM       VARCHAR2(25) NOT NULL ,
    CODE      VARCHAR2(10) NOT NULL ,
    VALIDE    CHAR(1) NOT NULL ,
    CONSTRAINT PK_EQUIPE PRIMARY KEY (ID_EQUIPE)
);

/*
Table: ROLEEQUIPE
*/

CREATE TABLE ROLEEQUIPE(
    ID_ROLEEQUIPE NUMBER(10,0) NOT NULL ,
    LIBELLE       VARCHAR2(25) NOT NULL ,
    CONSTRAINT PK_ROLEEQUIPE PRIMARY KEY (ID_ROLEEQUIPE)
);

/*
Table: UTILISATEUR
*/

CREATE TABLE UTILISATEUR(
    ID_UTILISATEUR NUMBER(10,0) NOT NULL ,
    NOM            VARCHAR2(25) NOT NULL ,
    PRENOM         VARCHAR2(25) NOT NULL ,
    DATENAISSANCE  DATE NOT NULL ,
    NUMTELEPHONE   VARCHAR2(25) NOT NULL ,
    CLUB           VARCHAR2(25) NOT NULL ,
    EMAIL          VARCHAR2(50) NOT NULL ,
    CODEPOSTAL     VARCHAR2(25) NOT NULL ,
    VILLE          VARCHAR2(25) NOT NULL ,
    ADRESSE        VARCHAR2(25) NOT NULL ,
    MOTDEPASSE     CHAR(64) NOT NULL ,
    ID_GENRE       NUMBER(10,0) NOT NULL ,
    ID_RANG        NUMBER(10,0) NOT NULL ,
    CONSTRAINT PK_UTILISATEUR PRIMARY KEY (ID_UTILISATEUR) ,
    CONSTRAINT FK_UTILISATEUR_GENRE FOREIGN KEY (ID_GENRE) REFERENCES GENRE(ID_GENRE) ,
    CONSTRAINT FK_UTILISATEUR_RANG FOREIGN KEY (ID_RANG) REFERENCES RANG(ID_RANG)
);

/*
Table: APPARTENIR
*/
CREATE TABLE APPARTENIR(
    ID_UTILISATEUR NUMBER(10,0) NOT NULL ,
    ID_EQUIPE NUMBER(10,0) NOT NULL ,
    ID_ROLEEQUIPE NUMBER(10,0) NOT NULL ,
    CONSTRAINT PK_APPARTENIR PRIMARY KEY (ID_UTILISATEUR, ID_EQUIPE, ID_ROLEEQUIPE) ,
    CONSTRAINT FK_APPARTENIR_UTILISATEUR FOREIGN KEY (ID_UTILISATEUR) REFERENCES UTILISATEUR(ID_UTILISATEUR) ,
    CONSTRAINT FK_APPARTENIR_EQUIPE FOREIGN KEY (ID_EQUIPE) REFERENCES EQUIPE(ID_EQUIPE) ,
    CONSTRAINT FK_APPARTENIR_ROLEEQUIPE FOREIGN KEY (ID_ROLEEQUIPE) REFERENCES ROLEEQUIPE(ID_ROLEEQUIPE)
);

/*
Table: PIECEJOINTE
*/

CREATE TABLE PIECEJOINTE(
    ID_PIECEJOINTE     NUMBER(10,0) NOT NULL ,
    LIBELLE            VARCHAR2(25) NOT NULL ,
    CHEMIN             VARCHAR2(50) NOT NULL ,
    ID_UTILISATEUR     NUMBER(10,0) NOT NULL ,
    ID_TYPEPIECEJOINTE NUMBER(10,0) NOT NULL ,
    CONSTRAINT PK_PIECEJOINTE PRIMARY KEY (ID_PIECEJOINTE) ,
    CONSTRAINT FK_PIECEJOINTE_UTILISATEUR FOREIGN KEY (ID_UTILISATEUR) REFERENCES UTILISATEUR(ID_UTILISATEUR) ,
    CONSTRAINT FK_PIECEJOINTE_ROLEEQUIPE FOREIGN KEY (ID_TYPEPIECEJOINTE) REFERENCES ROLEEQUIPE(ID_ROLEEQUIPE)
);

/*
Table: TYPECOMPETITION
*/

CREATE TABLE TYPECOMPETITION(
    ID_TYPECOMPETITION NUMBER(10,0) NOT NULL ,
    LIBELLE            VARCHAR2(25) NOT NULL ,
    CONSTRAINT PK_TYPECOMPETITION PRIMARY KEY (ID_TYPECOMPETITION)
);

/*
Table: COMPETITION
*/

CREATE TABLE COMPETITION(
    ID_COMPETITION     NUMBER(10,0) NOT NULL ,
    NOM                VARCHAR2(25) NOT NULL ,
    DATEFININSCRIPTION DATE NOT NULL ,
    DATEDEBUT          DATE NOT NULL ,
    ID_TYPECOMPETITION NUMBER(10,0) NOT NULL ,
    ID_CATEGORIE       NUMBER(10,0) NOT NULL ,
    CONSTRAINT PK_COMPETITION PRIMARY KEY (ID_COMPETITION),
    CONSTRAINT FK_COMPETITION_TYPECOMPETITION FOREIGN KEY (ID_TYPECOMPETITION) REFERENCES TYPECOMPETITION(ID_TYPECOMPETITION)
);

/*
Table: TYPEEPREUVE
*/

CREATE TABLE TYPEEPREUVE(
    ID_TYPEEPREUVE NUMBER(10,0) NOT NULL ,
    LIBELLE        VARCHAR2(25) NOT NULL ,
    CONSTRAINT PK_TYPEEPREUVE PRIMARY KEY (ID_TYPEEPREUVE)
);

/*
Table: EPREUVE
*/

CREATE TABLE EPREUVE(
    ID_EPREUVE     NUMBER(10,0) NOT NULL ,
    ORDRE          NUMBER(10,0) NOT NULL ,
    ID_TYPEEPREUVE NUMBER(10,0) NOT NULL ,
    ID_COMPETITION NUMBER(10,0) NOT NULL ,
    CONSTRAINT PK_EPREUVE PRIMARY KEY (ID_EPREUVE) ,
    CONSTRAINT FK_EPREUVE_TYPEEPREUVE FOREIGN KEY (ID_TYPEEPREUVE) REFERENCES TYPEEPREUVE(ID_TYPEEPREUVE) ,
    CONSTRAINT FK_EPREUVE_COMPETITION FOREIGN KEY (ID_COMPETITION) REFERENCES COMPETITION(ID_COMPETITION)
);

/*
Table: PARTICIPER
*/

CREATE TABLE PARTICIPER(
    ID_COMPETITION NUMBER(10,0) NOT NULL ,
    ID_EQUIPE      NUMBER(10,0) NOT NULL ,
    SCORE          NUMBER(10,0) ,
    CONSTRAINT PK_PARTICIPER PRIMARY KEY (ID_COMPETITION, ID_EQUIPE) ,
    CONSTRAINT FK_PARTICIPER_COMPETITION FOREIGN KEY (ID_COMPETITION) REFERENCES COMPETITION(ID_COMPETITION) ,
    CONSTRAINT FK_PARTICIPER_EQUIPE FOREIGN KEY (ID_EQUIPE) REFERENCES EQUIPE(ID_EQUIPE)
);

/*
Table: CHRONOMETRER
*/

CREATE TABLE CHRONOMETRER(
    TEMPS          NUMBER(10,0) NOT NULL ,
    ID_UTILISATEUR NUMBER(10,0) NOT NULL ,
    ID_EPREUVE     NUMBER(10,0) NOT NULL ,
    CONSTRAINT PK_CHRONOMETRER PRIMARY KEY (ID_UTILISATEUR, ID_EPREUVE) ,
    CONSTRAINT FK_CHRONOMETRER_UTILISATEUR FOREIGN KEY (ID_UTILISATEUR) REFERENCES UTILISATEUR(ID_UTILISATEUR) ,
    CONSTRAINT FK_CHRONOMETRER_EPREUVE FOREIGN KEY (ID_EPREUVE) REFERENCES EPREUVE(ID_EPREUVE)
);

/*
Table: ASSOCIER
*/

CREATE TABLE ASSOCIER(
    DOSSARD        NUMBER(10,0) ,
    PUCE           NUMBER(10,0) ,
    ID_UTILISATEUR NUMBER(10,0) NOT NULL ,
    ID_COMPETITION NUMBER(10,0) NOT NULL ,
    CONSTRAINT PK_ASSOCIER PRIMARY KEY (ID_UTILISATEUR, ID_COMPETITION) ,
    CONSTRAINT FK_ASSOCIER_UTILISATEUR FOREIGN KEY (ID_UTILISATEUR) REFERENCES UTILISATEUR(ID_UTILISATEUR) ,
    CONSTRAINT FK_ASSOCIER_COMPETITION FOREIGN KEY (ID_COMPETITION) REFERENCES COMPETITION(ID_COMPETITION)
);

/*
Table: CLASSEMENT
*/

CREATE TABLE CLASSEMENT(
    ID_CLASSEMENT NUMBER(10,0) NOT NULL ,
    LIBELLE       VARCHAR2 (255) NOT NULL ,
    CONSTRAINT PK_CLASSEMENT PRIMARY KEY (ID_CLASSEMENT)
);

/*
Table: CLASSER
*/

CREATE TABLE CLASSER(
    POSITION      NUMBER(10,0) NOT NULL ,
    ID_EQUIPE     NUMBER(10,0) NOT NULL ,
    ID_CLASSEMENT NUMBER(10,0) NOT NULL ,
    CONSTRAINT PK_CLASSER PRIMARY KEY (ID_EQUIPE, ID_CLASSEMENT),
    CONSTRAINT FK_CLASSER_EQUIPE FOREIGN KEY (ID_EQUIPE) REFERENCES EQUIPE(ID_EQUIPE),
    CONSTRAINT FK_CLASSER_CLASSEMENT FOREIGN KEY (ID_CLASSEMENT) REFERENCES CLASSEMENT(ID_CLASSEMENT)
);

/*
Sequences
*/

CREATE SEQUENCE SEQ_UTILISATEUR_ID_UTILISATEUR START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE SEQ_RANG_ID_RANG START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE SEQ_PIECEJOINTE_ID_PIECEJOINTE START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE SEQ_TYPEPIECEJ_ID_TYPEPIECEJ START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE SEQ_EQUIPE_ID_EQUIPE START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE SEQ_ROLEEQUIPE_ID_ROLEEQUIPE START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE SEQ_TYPECOMP_ID_TYPECOMP START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE SEQ_COMPETITION_ID_COMPETITION START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE SEQ_TYPEEPREUVE_ID_TYPEEPREUVE START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE SEQ_EPREUVE_ID_EPREUVE START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE SEQ_GENRE_ID_GENRE START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE SEQ_CATEGORIE_ID_CATEGORIE START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE SEQ_CLASSEMENT_ID_CLASSEMENT START WITH 1 INCREMENT BY 1 NOCYCLE;

/*
Triggers AUTO_INCREMENT
*/

CREATE OR REPLACE TRIGGER UTILISATEUR_ID_UTILISATEUR
BEFORE INSERT ON UTILISATEUR 
FOR EACH ROW 
WHEN (NEW.ID_UTILISATEUR IS NULL) 
BEGIN
    SELECT SEQ_UTILISATEUR_ID_UTILISATEUR.NEXTVAL INTO :NEW.ID_UTILISATEUR FROM DUAL;
END;
/

CREATE OR REPLACE TRIGGER RANG_ID_RANG
BEFORE INSERT ON RANG 
FOR EACH ROW 
WHEN (NEW.ID_RANG IS NULL) 
BEGIN
    SELECT SEQ_RANG_ID_RANG.NEXTVAL INTO :NEW.ID_RANG FROM DUAL; 
END;
/

CREATE OR REPLACE TRIGGER PIECEJOINTE_ID_PIECEJOINTE
BEFORE INSERT ON PIECEJOINTE 
FOR EACH ROW 
WHEN (NEW.ID_PIECEJOINTE IS NULL) 
BEGIN
    SELECT SEQ_PIECEJOINTE_ID_PIECEJOINTE.NEXTVAL INTO :NEW.ID_PIECEJOINTE FROM DUAL; 
END;
/

CREATE OR REPLACE TRIGGER TYPEPIECEJ_ID_TYPEPIECEJ
BEFORE INSERT ON TYPEPIECEJOINTE 
FOR EACH ROW 
WHEN (NEW.ID_TYPEPIECEJOINTE IS NULL) 
BEGIN
	SELECT SEQ_TYPEPIECEJ_ID_TYPEPIECEJ.NEXTVAL INTO :NEW.ID_TYPEPIECEJOINTE FROM DUAL; 
END;
/

CREATE OR REPLACE TRIGGER EQUIPE_ID_EQUIPE
BEFORE INSERT ON EQUIPE 
FOR EACH ROW 
WHEN (NEW.ID_EQUIPE IS NULL) 
BEGIN
	SELECT SEQ_EQUIPE_ID_EQUIPE.NEXTVAL INTO :NEW.ID_EQUIPE FROM DUAL; 
END;
/

CREATE OR REPLACE TRIGGER ROLEEQUIPE_ID_ROLEEQUIPE
BEFORE INSERT ON ROLEEQUIPE 
FOR EACH ROW 
WHEN (NEW.ID_ROLEEQUIPE IS NULL) 
BEGIN
	SELECT SEQ_ROLEEQUIPE_ID_ROLEEQUIPE.NEXTVAL INTO :NEW.ID_ROLEEQUIPE FROM DUAL; 
END;
/

CREATE OR REPLACE TRIGGER TYPECOMP_ID_TYPECOMP
BEFORE INSERT ON TYPECOMPETITION 
FOR EACH ROW 
WHEN (NEW.ID_TYPECOMPETITION IS NULL) 
BEGIN
	SELECT SEQ_TYPECOMP_ID_TYPECOMP.NEXTVAL INTO :NEW.ID_TYPECOMPETITION FROM DUAL; 
END;
/

CREATE OR REPLACE TRIGGER COMPETITION_ID_COMPETITION
BEFORE INSERT ON COMPETITION 
FOR EACH ROW 
WHEN (NEW.ID_COMPETITION IS NULL) 
BEGIN
    SELECT SEQ_COMPETITION_ID_COMPETITION.NEXTVAL INTO :NEW.ID_COMPETITION FROM DUAL; 
END;
/

CREATE OR REPLACE TRIGGER TYPEEPREUVE_ID_TYPEEPREUVE
BEFORE INSERT ON TYPEEPREUVE 
FOR EACH ROW 
WHEN (NEW.ID_TYPEEPREUVE IS NULL) 
BEGIN
    SELECT SEQ_TYPEEPREUVE_ID_TYPEEPREUVE.NEXTVAL INTO :NEW.ID_TYPEEPREUVE FROM DUAL; 
END;
/

CREATE OR REPLACE TRIGGER EPREUVE_ID_EPREUVE
BEFORE INSERT ON EPREUVE 
FOR EACH ROW 
WHEN (NEW.ID_EPREUVE IS NULL) 
BEGIN
	SELECT SEQ_EPREUVE_ID_EPREUVE.NEXTVAL INTO :NEW.ID_EPREUVE FROM DUAL; 
END;
/

CREATE OR REPLACE TRIGGER GENRE_ID_GENRE
BEFORE INSERT ON GENRE 
FOR EACH ROW 
WHEN (NEW.ID_GENRE IS NULL) 
BEGIN
	SELECT SEQ_GENRE_ID_GENRE.NEXTVAL INTO :NEW.ID_GENRE FROM DUAL; 
END;
/

CREATE OR REPLACE TRIGGER CATEGORIE_ID_CATEGORIE
BEFORE INSERT ON CATEGORIE 
FOR EACH ROW 
	WHEN (NEW.ID_CATEGORIE IS NULL) 
	BEGIN
	SELECT SEQ_CATEGORIE_ID_CATEGORIE.NEXTVAL INTO :NEW.ID_CATEGORIE FROM DUAL; 
END;
/

CREATE OR REPLACE TRIGGER CLASSEMENT_ID_CLASSEMENT
BEFORE INSERT ON CLASSEMENT 
FOR EACH ROW 
WHEN (NEW.ID_CLASSEMENT IS NULL) 
BEGIN
	SELECT SEQ_CLASSEMENT_ID_CLASSEMENT.NEXTVAL INTO :NEW.ID_CLASSEMENT FROM DUAL; 
END;
/
