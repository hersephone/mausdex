SET ECHO OFF;

-- TABLE DROPS
PROMPT *******  Dropping Tables;

DROP TABLE placements cascade constraints;
DROP TABLE tournaments cascade constraints;
DROP TABLE moves cascade constraints;
DROP TABLE pkmn cascade constraints;
DROP TABLE typechart cascade constraints;
DROP TABLE regulations cascade constraints;
DROP TABLE items cascade constraints;
DROP TABLE abilities cascade constraints;
DROP TABLE generations cascade constraints;
DROP TABLE elemtypes cascade constraints;

-- TABLE CREATION
PROMPT *******  Starting Table Creation;

CREATE TABLE generations (
    genID INT NOT NULL PRIMARY KEY,
    tableNumber INT NOT NULL,
    genName VARCHAR(10) NOT NULL
);

CREATE TABLE elemtypes (
    elemtypeID INT NOT NULL PRIMARY KEY,
    tableNumber INT NOT NULL,
    genID INT NOT NULL,
    elemtypeName VARCHAR(50) NOT NULL,
    CONSTRAINT elemtypes_gen_fk FOREIGN KEY (genID) REFERENCES generations(genID)
);

CREATE TABLE abilities (
    abilityID INT NOT NULL PRIMARY KEY,
    tableNumber INT NOT NULL,
    genID INT NOT NULL,
    abilityName VARCHAR(50) NOT NULL,
    abilityDesc VARCHAR(200) NOT NULL,
    CONSTRAINT abilities_gen_fk FOREIGN KEY (genID) REFERENCES generations(genID)
);

CREATE TABLE items (
    itemID INT NOT NULL PRIMARY KEY,
    tableNumber INT NOT NULL,
    genID INT NOT NULL,
    itemName VARCHAR(50) NOT NULL,
    CONSTRAINT items_gen_fk FOREIGN KEY (genID) REFERENCES generations(genID)
);


CREATE TABLE moves (
    moveID INT NOT NULL PRIMARY KEY,
    tableNumber INT NOT NULL,
    genID INT NOT NULL,
    moveName VARCHAR(50) NOT NULL,
    moveType INT NOT NULL,
    moveCategory VARCHAR(50) NOT NULL,
    movePP INT NOT NULL,
    movePower INT,
    moveAccuracy DECIMAL(3,2),
    CONSTRAINT moves_type_fk FOREIGN KEY (moveType) REFERENCES elemtypes(elemtypeID),
    CONSTRAINT moves_gen_fk FOREIGN KEY (genID) REFERENCES generations(genID)
);

CREATE TABLE pkmn (
    pkmnID INT NOT NULL PRIMARY KEY,
    tableNumber INT NOT NULL,
    genID INT NOT NULL,
    pkmnName VARCHAR(50) NOT NULL,
    pkmnType INT NOT NULL,
    pkmnType2 INT NOT NULL,
    hitpoint INT NOT NULL,
    attack INT NOT NULL,
    defense INT NOT NULL,
    specialAttack INT NOT NULL,
    specialDefense INT NOT NULL,
    speed INT NOT NULL,
    ability INT NOT NULL,
    ability2 INT NOT NULL,
    ability3 INT NOT NULL,
    CONSTRAINT pkmn_gen_fk FOREIGN KEY (genID) REFERENCES generations(genID),
    CONSTRAINT pkmn_type_fk FOREIGN KEY (pkmnType) REFERENCES elemtypes(elemtypeID),
    CONSTRAINT pkmn_type2_fk FOREIGN KEY (pkmnType2) REFERENCES elemtypes(elemtypeID),
    CONSTRAINT pkmn_ability_fk FOREIGN KEY (ability) REFERENCES abilities(abilityID),
    CONSTRAINT pkmn_ability2_fk FOREIGN KEY (ability2) REFERENCES abilities(abilityID),
    CONSTRAINT pkmn_ability3_fk FOREIGN KEY (ability3) REFERENCES abilities(abilityID)
);

CREATE TABLE typechart (
    genID INT NOT NULL,
    tableNumber INT NOT NULL,
    attacker INT NOT NULL,
    defender INT NOT NULL,
    PRIMARY KEY (genID, attacker, defender),
    outcome INT NOT NULL,
    CONSTRAINT typechart_gen_fk FOREIGN KEY (genID) REFERENCES generations(genID),
    CONSTRAINT typechart_attacker_fk FOREIGN KEY (attacker) REFERENCES elemtypes(elemtypeID),
    CONSTRAINT typechart_defender_fk FOREIGN KEY (defender) REFERENCES elemtypes(elemtypeID)
);

CREATE TABLE regulations (
    regID INT NOT NULL PRIMARY KEY,
    tableNumber INT NOT NULL,
    genID INT NOT NULL,
    regName VARCHAR (10) NOT NULL,
    CONSTRAINT regulation_gen_fk FOREIGN KEY (genID) REFERENCES generations(genID)
);

CREATE TABLE tournaments (
    tournID INT NOT NULL PRIMARY KEY,
    tableNumber INT NOT NULL,
    genID INT NOT NULL,
    tournName VARCHAR(100) NOT NULL,
    tournDate DATE NOT NULL,
    regID INT NOT NULL,
    tournLevel VARCHAR(50) NOT NULL,
    season INT NOT NULL,
    CONSTRAINT tournament_reg_fk FOREIGN KEY (regID) references regulations(regID),
    CONSTRAINT tournament_gen_fk FOREIGN KEY (genID) REFERENCES generations(genID)
);

CREATE TABLE placements (
    placeID INT NOT NULL PRIMARY KEY,
    tableNumber INT NOT NULL,
    genID INT NOT NULL,
    pkmnID INT NOT NULL,
    teraType INT NOT NULL,
    abilityID INT NOT NULL,
    itemID INT NOT NULL,
    move1ID INT NOT NULL,
    move2ID INT NOT NULL,
    move3ID INT NOT NULL,
    move4ID INT NOT NULL,
    tournID INT NOT NULL,
    CONSTRAINT placement_gen_fk FOREIGN KEY (genID) REFERENCES generations(genID),
    CONSTRAINT placement_pkmn_fk FOREIGN KEY (pkmnID) references pkmn(pkmnID),
    CONSTRAINT placement_tera_fk FOREIGN KEY (teraType) references elemtypes(elemtypeID),
    CONSTRAINT placement_ability_fk FOREIGN KEY (abilityID) references abilities(abilityID),
    CONSTRAINT placement_item_fk FOREIGN KEY (itemID) references items(itemID),
    CONSTRAINT placement_move1_fk FOREIGN KEY (move1ID) references moves(moveID),
    CONSTRAINT placement_move2_fk FOREIGN KEY (move2ID) references moves(moveID),
    CONSTRAINT placement_move3_fk FOREIGN KEY (move3ID) references moves(moveID),
    CONSTRAINT placement_move4_fk FOREIGN KEY (move4ID) references moves(moveID),
    CONSTRAINT placement_tourn_fk FOREIGN KEY (tournID) references tournaments(tournID)
);

sqlldr dbs311_253nbb27@22114164 control=generations.ctl