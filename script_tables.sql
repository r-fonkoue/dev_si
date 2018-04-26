/*
Suppression des tables
*/

DROP TABLE CLASSER_UTILISATEUR_EPREUVE;
DROP TABLE CLASSER_EQUIPE_EPREUVE;
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
    LIBELLE      VARCHAR2(50) NOT NULL ,
    CONSTRAINT PK_CATEGORIE PRIMARY KEY (ID_CATEGORIE)
);

/*
Table: RANG
*/

CREATE TABLE RANG(
    ID_RANG NUMBER NOT NULL ,
    LIBELLE VARCHAR2(50) NOT NULL ,
    CONSTRAINT PK_RANG PRIMARY KEY (ID_RANG)
);

/*
Table: GENRE
*/

CREATE TABLE GENRE(
    ID_GENRE NUMBER(10,0) NOT NULL ,
    LIBELLE  VARCHAR2(50) NOT NULL ,
    CONSTRAINT PK_GENRE PRIMARY KEY (ID_GENRE)
);

/*
Table: TYPEPIECEJOINTE
*/

CREATE TABLE TYPEPIECEJOINTE(
    ID_TYPEPIECEJOINTE NUMBER(10,0) NOT NULL ,
    LIBELLE            VARCHAR2(50) NOT NULL ,
    CONSTRAINT PK_TYPEPIECEJOINTE PRIMARY KEY (ID_TYPEPIECEJOINTE)
);

/*
Table: EQUIPE
*/

CREATE TABLE EQUIPE(
    ID_EQUIPE NUMBER(10,0) NOT NULL ,
    NOM       VARCHAR2(50) NOT NULL ,
    CODE      VARCHAR2(10) ,
    VALIDE    CHAR(1) NOT NULL ,
    CONSTRAINT PK_EQUIPE PRIMARY KEY (ID_EQUIPE)
);

/*
Table: ROLEEQUIPE
*/

CREATE TABLE ROLEEQUIPE(
    ID_ROLEEQUIPE NUMBER(10,0) NOT NULL ,
    LIBELLE       VARCHAR2(50) NOT NULL ,
    CONSTRAINT PK_ROLEEQUIPE PRIMARY KEY (ID_ROLEEQUIPE)
);

/*
Table: UTILISATEUR
*/

CREATE TABLE UTILISATEUR(
    ID_UTILISATEUR NUMBER(10,0) NOT NULL ,
    NOM            VARCHAR2(50) NOT NULL CONSTRAINT NOM_MAJUSCULE CHECK(NOM=UPPER(NOM)),
    PRENOM         VARCHAR2(50) NOT NULL CONSTRAINT PRENOM_MAJUSCULE_INITCAP CHECK(PRENOM=INITCAP(PRENOM)),
    DATENAISSANCE  DATE NOT NULL ,
    NUMTELEPHONE   VARCHAR2(50) NOT NULL ,
    CLUB           VARCHAR2(50) ,
    EMAIL          VARCHAR2(50) NOT NULL ,
    CODEPOSTAL     VARCHAR2(50) NOT NULL ,
    VILLE          VARCHAR2(50) NOT NULL ,
    ADRESSE        VARCHAR2(50) NOT NULL ,
    MOTDEPASSE     CHAR(64) NOT NULL ,
    ID_GENRE       NUMBER(10,0) NOT NULL ,
    ID_RANG        NUMBER(10,0) ,
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
    CONSTRAINT PK_APPARTENIR PRIMARY KEY (ID_UTILISATEUR, ID_EQUIPE) ,
    CONSTRAINT FK_APPARTENIR_UTILISATEUR FOREIGN KEY (ID_UTILISATEUR) REFERENCES UTILISATEUR(ID_UTILISATEUR) ,
    CONSTRAINT FK_APPARTENIR_EQUIPE FOREIGN KEY (ID_EQUIPE) REFERENCES EQUIPE(ID_EQUIPE) ,
    CONSTRAINT FK_APPARTENIR_ROLEEQUIPE FOREIGN KEY (ID_ROLEEQUIPE) REFERENCES ROLEEQUIPE(ID_ROLEEQUIPE)
);

/*
Table: PIECEJOINTE
*/

CREATE TABLE PIECEJOINTE(
    ID_PIECEJOINTE     NUMBER(10,0) NOT NULL ,
    LIBELLE            VARCHAR2(50) NOT NULL ,
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
    LIBELLE            VARCHAR2(50) NOT NULL ,
    CONSTRAINT PK_TYPECOMPETITION PRIMARY KEY (ID_TYPECOMPETITION)
);

/*
Table: COMPETITION
*/

CREATE TABLE COMPETITION(
    ID_COMPETITION     NUMBER(10,0) NOT NULL ,
    NOM                VARCHAR2(50) NOT NULL ,
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
    LIBELLE        VARCHAR2(50) NOT NULL ,
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
    ID_UTILISATEUR NUMBER(10,0) NOT NULL ,
    ID_EPREUVE     NUMBER(10,0) NOT NULL ,
    TEMPS          NUMBER(10,0) NOT NULL ,
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
    LIBELLE       VARCHAR2(255) NOT NULL ,
    CONSTRAINT PK_CLASSEMENT PRIMARY KEY (ID_CLASSEMENT)
);

/*
Table: CLASSER
*/

CREATE TABLE CLASSER(
    ID_EQUIPE     NUMBER(10,0) NOT NULL ,
    ID_CLASSEMENT NUMBER(10,0) NOT NULL ,
    POSITION      NUMBER(10,0) NOT NULL ,
    CONSTRAINT PK_CLASSER PRIMARY KEY (ID_EQUIPE, ID_CLASSEMENT),
    CONSTRAINT FK_CLASSER_EQUIPE FOREIGN KEY (ID_EQUIPE) REFERENCES EQUIPE(ID_EQUIPE),
    CONSTRAINT FK_CLASSER_CLASSEMENT FOREIGN KEY (ID_CLASSEMENT) REFERENCES CLASSEMENT(ID_CLASSEMENT)
);

/*
Table: CLASSER_EQUIPE_EPREUVE
*/

CREATE TABLE CLASSER_EQUIPE_EPREUVE(
    ID_EQUIPE     NUMBER(10,0) NOT NULL ,
    ID_EPREUVE    NUMBER(10,0) NOT NULL ,
    POSITION      NUMBER(10,0) NOT NULL ,
    CONSTRAINT PK_CLASSER_EQUIPE_EPREUVE PRIMARY KEY (ID_EQUIPE, ID_EPREUVE),
    CONSTRAINT FK_CEE_EQ FOREIGN KEY (ID_EQUIPE) REFERENCES EQUIPE(ID_EQUIPE),
    CONSTRAINT FK_CEE_EP FOREIGN KEY (ID_EPREUVE) REFERENCES EPREUVE(ID_EPREUVE)
);

/*
Table: CLASSER_PARTICIPANT_EPREUVE
*/

CREATE TABLE CLASSER_UTILISATEUR_EPREUVE(
    ID_UTILISATEUR  NUMBER(10,0) NOT NULL ,
    ID_EPREUVE      NUMBER(10,0) NOT NULL ,
    POSITION        NUMBER(10,0) NOT NULL ,
    CONSTRAINT PK_CPE PRIMARY KEY (ID_UTILISATEUR, ID_EPREUVE),
    CONSTRAINT FK_CUE_U FOREIGN KEY (ID_UTILISATEUR) REFERENCES UTILISATEUR(ID_UTILISATEUR),
    CONSTRAINT FK_CUE_E FOREIGN KEY (ID_EPREUVE) REFERENCES EPREUVE(ID_EPREUVE)
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
Triggers
*/

CREATE OR REPLACE TRIGGER TRIGGERUTILISATEUR
BEFORE INSERT OR UPDATE ON UTILISATEUR 
FOR EACH ROW 
BEGIN
    if inserting then 
        SELECT SEQ_UTILISATEUR_ID_UTILISATEUR.NEXTVAL INTO :NEW.ID_UTILISATEUR FROM DUAL;
    elsif updating then
        :NEW.ID_UTILISATEUR:=:OLD.ID_UTILISATEUR;
    end if;
    :NEW.NOM:=UPPER(:NEW.NOM);
    :NEW.PRENOM:=INITCAP(:NEW.PRENOM);
END;
/

CREATE OR REPLACE TRIGGER RANG_ID_RANG
BEFORE INSERT OR UPDATE ON RANG 
FOR EACH ROW 
BEGIN
    if inserting then
        SELECT SEQ_RANG_ID_RANG.NEXTVAL INTO :NEW.ID_RANG FROM DUAL;
    elsif updating then 
        :NEW.ID_RANG:=:OLD.ID_RANG;
    end if;
END;
/

CREATE OR REPLACE TRIGGER PIECEJOINTE_ID_PIECEJOINTE
BEFORE INSERT OR UPDATE ON PIECEJOINTE 
FOR EACH ROW 
BEGIN
    if inserting then 
        SELECT SEQ_PIECEJOINTE_ID_PIECEJOINTE.NEXTVAL INTO :NEW.ID_PIECEJOINTE FROM DUAL;
    elsif updating then
        :NEW.ID_PIECEJOINTE:=:OLD.ID_PIECEJOINTE;
    end if;
END;
/

CREATE OR REPLACE TRIGGER TYPEPIECEJ_ID_TYPEPIECEJ
BEFORE INSERT OR UPDATE ON TYPEPIECEJOINTE 
FOR EACH ROW 
BEGIN
    if inserting then 
	    SELECT SEQ_TYPEPIECEJ_ID_TYPEPIECEJ.NEXTVAL INTO :NEW.ID_TYPEPIECEJOINTE FROM DUAL; 
    elsif updating then
        :NEW.ID_TYPEPIECEJOINTE:=:OLD.ID_TYPEPIECEJOINTE;
    end if;
END;
/

CREATE OR REPLACE TRIGGER TRIGGEREQUIPE
BEFORE INSERT OR UPDATE ON EQUIPE 
FOR EACH ROW 
BEGIN
    if inserting then 
	    SELECT SEQ_EQUIPE_ID_EQUIPE.NEXTVAL INTO :NEW.ID_EQUIPE FROM DUAL;
        SELECT dbms_random.string('A', 10) INTO :NEW.CODE FROM DUAL;
        :NEW.VALIDE:=0;
    elsif updating then 
        :NEW.ID_EQUIPE:=:OLD.ID_EQUIPE;
    end if;
END;
/

CREATE OR REPLACE TRIGGER ROLEEQUIPE_ID_ROLEEQUIPE
BEFORE INSERT OR UPDATE ON ROLEEQUIPE 
FOR EACH ROW 
BEGIN
    if inserting then 
    	SELECT SEQ_ROLEEQUIPE_ID_ROLEEQUIPE.NEXTVAL INTO :NEW.ID_ROLEEQUIPE FROM DUAL;
    elsif updating then 
        :NEW.ID_ROLEEQUIPE:=:OLD.ID_ROLEEQUIPE;
    end if;
END;
/

CREATE OR REPLACE TRIGGER TYPECOMP_ID_TYPECOMP
BEFORE INSERT OR UPDATE ON TYPECOMPETITION 
FOR EACH ROW 
BEGIN
    if inserting then 
	    SELECT SEQ_TYPECOMP_ID_TYPECOMP.NEXTVAL INTO :NEW.ID_TYPECOMPETITION FROM DUAL;
    elsif updating then 
        :NEW.ID_TYPECOMPETITION:=:OLD.ID_TYPECOMPETITION;
    end if;
END;
/

CREATE OR REPLACE TRIGGER COMPETITION_ID_COMPETITION
BEFORE INSERT OR UPDATE ON COMPETITION 
FOR EACH ROW 
BEGIN
    if inserting then 
        SELECT SEQ_COMPETITION_ID_COMPETITION.NEXTVAL INTO :NEW.ID_COMPETITION FROM DUAL;
    elsif updating then 
        :NEW.ID_COMPETITION:=:OLD.ID_COMPETITION;
    end if;
END;
/

CREATE OR REPLACE TRIGGER TYPEEPREUVE_ID_TYPEEPREUVE
BEFORE INSERT OR UPDATE ON TYPEEPREUVE 
FOR EACH ROW 
BEGIN
    if inserting then 
        SELECT SEQ_TYPEEPREUVE_ID_TYPEEPREUVE.NEXTVAL INTO :NEW.ID_TYPEEPREUVE FROM DUAL;
    elsif updating then 
        :NEW.ID_TYPEEPREUVE:=:OLD.ID_TYPEEPREUVE;
    end if;
END;
/

CREATE OR REPLACE TRIGGER EPREUVE_ID_EPREUVE
BEFORE INSERT OR UPDATE ON EPREUVE 
FOR EACH ROW 
BEGIN
    if inserting then 
	    SELECT SEQ_EPREUVE_ID_EPREUVE.NEXTVAL INTO :NEW.ID_EPREUVE FROM DUAL;
    elsif updating then 
        :NEW.ID_EPREUVE:=:OLD.ID_EPREUVE;
    end if;
END;
/

CREATE OR REPLACE TRIGGER GENRE_ID_GENRE
BEFORE INSERT OR UPDATE ON GENRE 
FOR EACH ROW 
BEGIN
    if inserting then 
        SELECT SEQ_GENRE_ID_GENRE.NEXTVAL INTO :NEW.ID_GENRE FROM DUAL; 
    elsif updating then 
        :NEW.ID_GENRE:=:OLD.ID_GENRE;
    end if;
END;
/

CREATE OR REPLACE TRIGGER CATEGORIE_ID_CATEGORIE
BEFORE INSERT OR UPDATE ON CATEGORIE 
FOR EACH ROW 
BEGIN
    if inserting then 
        SELECT SEQ_CATEGORIE_ID_CATEGORIE.NEXTVAL INTO :NEW.ID_CATEGORIE FROM DUAL;
    elsif updating then 
        :NEW.ID_CATEGORIE:=:OLD.ID_CATEGORIE;
    end if;
END;
/

CREATE OR REPLACE TRIGGER CLASSEMENT_ID_CLASSEMENT
BEFORE INSERT OR UPDATE ON CLASSEMENT 
FOR EACH ROW 
BEGIN
    if inserting then
        SELECT SEQ_CLASSEMENT_ID_CLASSEMENT.NEXTVAL INTO :NEW.ID_CLASSEMENT FROM DUAL;
    elsif updating then
        :NEW.ID_CLASSEMENT:=:OLD.ID_CLASSEMENT;
    end if;
END;
/

CREATE OR REPLACE TRIGGER TRIGGERPARTICIPER
BEFORE INSERT ON PARTICIPER 
FOR EACH ROW 
BEGIN
    if inserting then
        :NEW.SCORE:=0;
    end if;
END;
/

/*
WIP
CREATE OR REPLACE TRIGGER TRIGGERCHRONOMETRER
AFTER INSERT OR UPDATE OR DELETE ON CHRONOMETRER
FOR EACH ROW
BEGIN
    if inserting or updating then
        INSERT INTO CLASSER_UTILISATEUR_EPREUVE(ID_UTILISATEUR, ID_EPREUVE, POSITION) VALUES (:NEW.ID_UTILISATEUR, :NEW.ID_EPREUVE);
    end if;
END;
/*/

/*
Valeurs par défaut
*/

INSERT INTO RANG(LIBELLE) VALUES ('Participant');
INSERT INTO RANG(LIBELLE) VALUES ('Tresorier');
INSERT INTO RANG(LIBELLE) VALUES ('Secretaire');
INSERT INTO RANG(LIBELLE) VALUES ('Administrateur');

INSERT INTO CATEGORIE(LIBELLE) VALUES ('Hommes');
INSERT INTO CATEGORIE(LIBELLE) VALUES ('Femmes');
INSERT INTO CATEGORIE(LIBELLE) VALUES ('Mixte');

INSERT INTO GENRE(LIBELLE) VALUES ('Homme');
INSERT INTO GENRE(LIBELLE) VALUES ('Femme');

INSERT INTO TYPEPIECEJOINTE(LIBELLE) VALUES ('Licence');
INSERT INTO TYPEPIECEJOINTE(LIBELLE) VALUES ('Certificat médical');
INSERT INTO TYPEPIECEJOINTE(LIBELLE) VALUES ('Autorisation parentale');
INSERT INTO TYPEPIECEJOINTE(LIBELLE) VALUES ('Autre');

INSERT INTO ROLEEQUIPE(LIBELLE) VALUES ('Capitaine');
INSERT INTO ROLEEQUIPE(LIBELLE) VALUES ('Equipier');

INSERT INTO TYPECOMPETITION(LIBELLE) VALUES ('Bol d''Air');
INSERT INTO TYPECOMPETITION(LIBELLE) VALUES ('Mini Bol d''Air');
INSERT INTO TYPECOMPETITION(LIBELLE) VALUES ('Bol d''Eau');
INSERT INTO TYPECOMPETITION(LIBELLE) VALUES ('Mini Bol d''Eau');

INSERT INTO TYPEEPREUVE(LIBELLE) VALUES ('Course à pied');
INSERT INTO TYPEEPREUVE(LIBELLE) VALUES ('Canoe');
INSERT INTO TYPEEPREUVE(LIBELLE) VALUES ('VTT');

/*
Jeu d'essai
*/

INSERT INTO COMPETITION(NOM, DATEFININSCRIPTION, DATEDEBUT, ID_TYPECOMPETITION, ID_CATEGORIE) VALUES ('Bol d''Air Juillet 2018 Mixte', TO_DATE('2018/07/2 1:00:00', 'YYYY/MM/DD HH:MI:SS'), TO_DATE('2018/07/02 2:00:00', 'YYYY/MM/DD HH:MI:SS'), 1, 3);
INSERT INTO COMPETITION(NOM, DATEFININSCRIPTION, DATEDEBUT, ID_TYPECOMPETITION, ID_CATEGORIE) VALUES ('Mini Bol d''Air Juillet 2018 Mixte', TO_DATE('2018/07/9 1:00:00', 'YYYY/MM/DD HH:MI:SS'), TO_DATE('2018/07/09 2:00:00', 'YYYY/MM/DD HH:MI:SS'), 3, 3);

INSERT INTO EPREUVE(ORDRE, ID_TYPEEPREUVE, ID_COMPETITION) VALUES(1, 1, 1);
INSERT INTO EPREUVE(ORDRE, ID_TYPEEPREUVE, ID_COMPETITION) VALUES(2, 2, 1);
INSERT INTO EPREUVE(ORDRE, ID_TYPEEPREUVE, ID_COMPETITION) VALUES(3, 3, 1);

INSERT INTO EPREUVE(ORDRE, ID_TYPEEPREUVE, ID_COMPETITION) VALUES(1, 3, 2);
INSERT INTO EPREUVE(ORDRE, ID_TYPEEPREUVE, ID_COMPETITION) VALUES(2, 2, 2);
INSERT INTO EPREUVE(ORDRE, ID_TYPEEPREUVE, ID_COMPETITION) VALUES(3, 1, 2);

INSERT INTO UTILISATEUR(NOM, PRENOM, DATENAISSANCE, NUMTELEPHONE, CLUB, EMAIL, CODEPOSTAL, VILLE, ADRESSE, MOTDEPASSE, ID_GENRE) VALUES ('avecclub', 'jean', to_date('1970-07-09', 'yyyy-MM-dd'), '0123456789', 'Club', 'a@a.com', '11111', 'Oui', 'Avenue du oui', 'aaaaaa', 1);
INSERT INTO UTILISATEUR(NOM, PRENOM, DATENAISSANCE, NUMTELEPHONE, EMAIL, CODEPOSTAL, VILLE, ADRESSE, MOTDEPASSE, ID_GENRE) VALUES ('sansclub', 'jean', to_date('1970-07-09', 'yyyy-MM-dd'), '0123456789', '11111', 'b@a.com', 'Oui', 'Avenue du oui', 'aaaaaa', 2);
INSERT INTO UTILISATEUR(NOM, PRENOM, DATENAISSANCE, NUMTELEPHONE, EMAIL, CODEPOSTAL, VILLE, ADRESSE, MOTDEPASSE, ID_GENRE, ID_RANG) VALUES ('Dang', 'xavier', to_date('1970-07-09', 'yyyy-MM-dd'), '0123456789', 'c@a.com', '11111', 'Oui', 'Avenue du oui', 'aaaaaa', 1, 4);

INSERT INTO EQUIPE(NOM) VALUES ('Le Zoo');

INSERT INTO APPARTENIR VALUES (1, 1, 1);
INSERT INTO APPARTENIR VALUES (2, 1, 2);

INSERT INTO PARTICIPER(ID_COMPETITION, ID_EQUIPE) VALUES (1, 1);

INSERT INTO CHRONOMETRER(ID_UTILISATEUR, ID_EPREUVE, TEMPS) VALUES (1, 1, 7200);
INSERT INTO CHRONOMETRER(ID_UTILISATEUR, ID_EPREUVE, TEMPS) VALUES (2, 1, 3600);

/*
procédures À TESTER

CREATE OR REPLACE PROCEDURE inscription_utilisateur (_NOM VARCHAR2, _PRENOM VARCHAR2, _DATENAISSANCE DATE, _NUMTELEPHONE VARCHAR2, _CLUB VARCHAR2 DEFAULT NULL, _EMAIL VARCHAR2, _CODEPOSTAL VARCHAR2, _VILLE VARCHAR2, _ADRESSE VARCHAR2, _MOTDEPASSE CHAR(64), _ID_GENRE NUMBER(10,0), _ID_RANG NUMBER(10,0))
	BEGIN
		INSERT INTO UTILISATEUR(NOM, PRENOM, DATENAISSANCE, NUMTELEPHONE, CLUB, EMAIL, CODEPOSTAL, VILLE, ADRESSE, MOTDEPASSE, ID_GENRE, ID_RANG) VALUES (_NOM, _PRENOM, _DATENAISSANCE, _NUMTELEPHONE, _CLUB, _EMAIL, _CODEPOSTAL, _VILLE, _ADRESSE, _MOTDEPASSE, _ID_GENRE, _ID_RANG);
	END;
/

CREATE OR REPLACE PROCEDURE chronometrer (_ID_UTILISATEUR NUMBER(10,0), _ID_EPREUVE NUMBER(10,0), _TEMPS NUMBER(10,0))
	BEGIN
		INSERT INTO CHRONOMETRER(ID_UTILISATEUR, ID_EPREUVE, TEMPS) VALUES (_ID_UTILISATEUR, _ID_EPREUVE, _TEMPS);
	END;
/

CREATE OR REPLACE PROCEDURE ajout_participant_equipe (_ID_UTILISATEUR NUMBER(10,0), _ID_EQUIPE NUMBER(10,0), _ID_ROLEEQUIPE NUMBER(10,0))
	BEGIN
		INSERT INTO APPARTENIR(ID_UTILISATEUR, ID_EQUIPE, ID_ROLEEQUIPE) VALUES (_ID_UTILISATEUR, _ID_EQUIPE, _ID_ROLEEQUIPE);
	END;
/

CREATE OR REPLACE PROCEDURE ajout_participation_equipe (_ID_COMPETITION NUMBER(10,0), _ID_EQUIPE NUMBER(10,0))
	BEGIN 
		INSERT INTO PARTICIPER(ID_COMPETITION, ID_EQUIPE) VALUES (_ID_COMPETITION, _ID_EQUIPE);
	END;
/

CREATE OR REPLACE FUNCTION VERIF_EMAIL_DEJA_UTIL (_EMAIL VARCHAR2) RETURN NUMBER(1)
	IS NBR_PRESENCE NUMBER(1);
	BEGIN
		SELECT COUNT(*)
		INTO NBR_PRESENCE
		FROM UTILISATEUR
		WHERE EMAIL = _EMAIL
		RETURN NBR_PRESENCE;
	END;
/
	

*/
