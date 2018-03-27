CREATE TABLE CATEGORIE(
    ID_CATEGORIE SERIAL NOT NULL ,
    LIBELLE      VARCHAR(20) NOT NULL ,
    CONSTRAINT PK_CATEGORIE PRIMARY KEY (ID_CATEGORIE)
);

CREATE TABLE RANG(
    ID_RANG SERIAL  NOT NULL ,
    LIBELLE VARCHAR(25) NOT NULL ,
    CONSTRAINT PK_RANG PRIMARY KEY (ID_RANG)
);

CREATE TABLE GENRE(
    ID_GENRE SERIAL  NOT NULL ,
    LIBELLE  VARCHAR(20) NOT NULL ,
    CONSTRAINT PK_GENRE PRIMARY KEY (ID_GENRE)
);

CREATE TABLE TYPEPIECEJOINTE(
    ID_TYPEPIECEJOINTE SERIAL  NOT NULL ,
    LIBELLE            VARCHAR(25) NOT NULL ,
    CONSTRAINT PK_TYPEPIECEJOINTE PRIMARY KEY (ID_TYPEPIECEJOINTE)
);

CREATE TABLE EQUIPE(
    ID_EQUIPE SERIAL NOT NULL ,
    NOM       VARCHAR(25) NOT NULL ,
    CODE      VARCHAR(10) NOT NULL ,
    VALIDE    Char (1) NOT NULL ,
    CONSTRAINT PK_EQUIPE PRIMARY KEY (ID_EQUIPE)
);

CREATE TABLE ROLEEQUIPE(
    ID_ROLEEQUIPE SERIAL NOT NULL ,
    LIBELLE       VARCHAR(25) NOT NULL ,
    CONSTRAINT PK_ROLEEQUIPE PRIMARY KEY (ID_ROLEEQUIPE)
);

CREATE TABLE UTILISATEUR(
    ID_UTILISATEUR SERIAL NOT NULL ,
    NOM            VARCHAR(25) NOT NULL ,
    PRENOM         VARCHAR(25) NOT NULL ,
    DATENAISSANCE  DATE NOT NULL ,
    NUMTELEPHONE   VARCHAR(25) NOT NULL ,
    CLUB           VARCHAR(25) NOT NULL ,
    EMAIL          VARCHAR(25) NOT NULL ,
    CODEPOSTAL     VARCHAR(25) NOT NULL ,
    VILLE          VARCHAR(25) NOT NULL ,
    ADRESSE        VARCHAR(25) NOT NULL ,
    ID_GENRE       SERIAL NOT NULL ,
    ID_RANG        SERIAL NOT NULL ,
    ID_EQUIPE      SERIAL NOT NULL ,
    ID_ROLEEQUIPE  SERIAL NOT NULL ,
    CONSTRAINT PK_UTILISATEUR PRIMARY KEY (ID_UTILISATEUR) ,
    CONSTRAINT FK_UTILISATEUR_GENRE FOREIGN KEY (ID_GENRE) REFERENCES GENRE(ID_GENRE) ,
    CONSTRAINT FK_UTILISATEUR_RANG FOREIGN KEY (ID_RANG) REFERENCES RANG(ID_RANG) ,
    CONSTRAINT FK_UTILISATEUR_EQUIPE FOREIGN KEY (ID_EQUIPE) REFERENCES EQUIPE(ID_EQUIPE) ,
    CONSTRAINT FK_UTILISATEUR_ROLEEQUIPE FOREIGN KEY (ID_ROLEEQUIPE) REFERENCES ROLEEQUIPE(ID_ROLEEQUIPE)
);

CREATE TABLE PIECEJOINTE(
    ID_PIECEJOINTE     SERIAL NOT NULL ,
    LIBELLE            VARCHAR(25) NOT NULL ,
    CHEMIN             VARCHAR(25) NOT NULL ,
    ID_UTILISATEUR     SERIAL NOT NULL ,
    ID_TYPEPIECEJOINTE SERIAL NOT NULL ,
    CONSTRAINT PK_PIECEJOINTE PRIMARY KEY (ID_PIECEJOINTE) ,
    CONSTRAINT FK_PIECEJOINTE_UTILISATEUR FOREIGN KEY (ID_UTILISATEUR) REFERENCES UTILISATEUR(ID_UTILISATEUR) ,
    CONSTRAINT FK_PIECEJOINTE_ROLEEQUIPE FOREIGN KEY (ID_TYPEPIECEJOINTE) REFERENCES ROLEEQUIPE(ID_ROLEEQUIPE)
);

CREATE TABLE TYPECOMPETITION(
    ID_TYPECOMPETITION SERIAL NOT NULL ,
    LIBELLE            VARCHAR(25) NOT NULL ,
    CONSTRAINT PK_TYPECOMPETITION PRIMARY KEY (ID_TYPECOMPETITION)
);

CREATE TABLE COMPETITION(
    ID_COMPETITION     SERIAL NOT NULL ,
    NOM                VARCHAR(25) NOT NULL ,
    DateFinInscription DATE NOT NULL ,
    DateDebut          DATE NOT NULL ,
    ID_TYPECOMPETITION SERIAL NOT NULL ,
    ID_CATEGORIE       SERIAL NOT NULL ,
    CONSTRAINT PK_COMPETITION PRIMARY KEY (ID_COMPETITION),
    CONSTRAINT FK_COMPETITION_TYPECOMPETITION FOREIGN KEY (ID_TYPECOMPETITION) REFERENCES TYPECOMPETITION(ID_TYPECOMPETITION)
);

CREATE TABLE TYPEEPREUVE(
    ID_TYPEEPREUVE SERIAL NOT NULL ,
    LIBELLE        VARCHAR(25) NOT NULL ,
    CONSTRAINT PK_TYPEEPREUVE PRIMARY KEY (ID_TYPEEPREUVE)
);

CREATE TABLE EPREUVE(
    ID_EPREUVE     SERIAL  NOT NULL ,
    ORDRE          INT NOT NULL ,
    ID_TYPEEPREUVE SERIAL NOT NULL ,
    ID_COMPETITION SERIAL NOT NULL ,
    CONSTRAINT PK_EPREUVE PRIMARY KEY (ID_EPREUVE) ,
    CONSTRAINT FK_EPREUVE_TYPEEPREUVE FOREIGN KEY (ID_TYPEEPREUVE) REFERENCES TYPEEPREUVE(ID_TYPEEPREUVE) ,
    CONSTRAINT FK_EPREUVE_COMPETITION FOREIGN KEY (ID_COMPETITION) REFERENCES COMPETITION(ID_COMPETITION)
);

CREATE TABLE PARTICIPER(
    ID_COMPETITION SERIAL NOT NULL ,
    ID_EQUIPE      SERIAL NOT NULL ,
    SCORE          INT ,
    CONSTRAINT PK_PARTICIPER PRIMARY KEY (ID_COMPETITION, ID_EQUIPE) ,
    CONSTRAINT FK_PARTICIPER_COMPETITION FOREIGN KEY (ID_COMPETITION) REFERENCES COMPETITION(ID_COMPETITION) ,
    CONSTRAINT FK_PARTICIPER_EQUIPE FOREIGN KEY (ID_EQUIPE) REFERENCES EQUIPE(ID_EQUIPE)
);

CREATE TABLE CHRONOMETRER(
    TEMPS          INT NOT NULL ,
    ID_UTILISATEUR SERIAL NOT NULL ,
    ID_EPREUVE     SERIAL NOT NULL ,
    CONSTRAINT PK_CHRONOMETRER PRIMARY KEY (ID_UTILISATEUR, ID_EPREUVE) ,
    CONSTRAINT FK_CHRONOMETRER_UTILISATEUR FOREIGN KEY (ID_UTILISATEUR) REFERENCES UTILISATEUR(ID_UTILISATEUR) ,
    CONSTRAINT FK_CHRONOMETRER_EPREUVE FOREIGN KEY (ID_EPREUVE) REFERENCES EPREUVE(ID_EPREUVE)
);

CREATE TABLE ASSOCIER(
    DOSSARD        INT ,
    PUCE           INT ,
    ID_UTILISATEUR SERIAL NOT NULL ,
    ID_COMPETITION SERIAL NOT NULL ,
    CONSTRAINT PK_ASSOCIER PRIMARY KEY (ID_UTILISATEUR, ID_COMPETITION) ,
    CONSTRAINT FK_ASSOCIER_UTILISATEUR FOREIGN KEY (ID_UTILISATEUR) REFERENCES UTILISATEUR(ID_UTILISATEUR) ,
    CONSTRAINT FK_ASSOCIER_COMPETITION FOREIGN KEY (ID_COMPETITION) REFERENCES COMPETITION(ID_COMPETITION)
);

CREATE TABLE CLASSEMENT(
    ID_CLASSEMENT SERIAL NOT NULL ,
    LIBELLE       VARCHAR(255) NOT NULL ,
    CONSTRAINT PK_CLASSEMENT PRIMARY KEY (ID_CLASSEMENT)
);

CREATE TABLE CLASSER(
    POSITION      INT NOT NULL ,
    ID_EQUIPE     SERIAL NOT NULL ,
    ID_CLASSEMENT SERIAL NOT NULL ,
    CONSTRAINT PK_CLASSER PRIMARY KEY (ID_EQUIPE, ID_CLASSEMENT)
);