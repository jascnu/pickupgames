CREATE TABLE Sports
(
  Name VARCHAR NOT NULL,
  SportID SERIAL NOT NULL,
  PRIMARY KEY (SportID),
  UNIQUE (Name)
);

CREATE TABLE Location
(
  LocationID SERIAL NOT NULL,
  Address VARCHAR NOT NULL,
  Lat FLOAT NOT NULL,
  Long FLOAT NOT NULL,
  Website VARCHAR,
  IsOpenAccess BOOL NOT NULL,
  PRIMARY KEY (LocationID)
);

CREATE TABLE Role
(
  RoleID SERIAL NOT NULL,
  RoleName VARCHAR NOT NULL,
  RoleDescription VARCHAR NOT NULL,
  PRIMARY KEY (RoleID)
);

CREATE TABLE CompetitiveLevels
(
  Level INT NOT NULL,
  LevelID SERIAL NOT NULL,
  PRIMARY KEY (LevelID)
);

CREATE TABLE PickupUser
(
  UserID SERIAL NOT NULL,
  FirstName VARCHAR NOT NULL,
  Middle VARCHAR NOT NULL,
  LastName VARCHAR NOT NULL,
  Email VARCHAR NOT NULL,
  Username VARCHAR NOT NULL,
  AttendanceScore INT NOT NULL,
  PasswordHash VARCHAR NOT NULL,
  ZipCode INT,
  Description VARCHAR NOT NULL,
  RoleID INT NOT NULL,
  PRIMARY KEY (UserID),
  FOREIGN KEY (RoleID) REFERENCES Role(RoleID),
  UNIQUE (Email),
  UNIQUE (Username)
);

CREATE TABLE Game
(
  GameID SERIAL NOT NULL,
  Title VARCHAR NOT NULL,
  PlayersRequired INT NOT NULL,
  IsCompetitive BOOL NOT NULL,
  PlayersJoined INT NOT NULL,
  Description VARCHAR,
  DateTime DATE NOT NULL,
  UserID INT NOT NULL,
  SportID INT NOT NULL,
  LocationID INT NOT NULL,
  LevelID INT NOT NULL,
  PRIMARY KEY (GameID),
  FOREIGN KEY (UserID) REFERENCES PickupUser(UserID),
  FOREIGN KEY (SportID) REFERENCES Sports(SportID),
  FOREIGN KEY (LocationID) REFERENCES Location(LocationID),
  FOREIGN KEY (LevelID) REFERENCES CompetitiveLevels(LevelID)
);

CREATE TABLE GameTemplate
(
  RepeatStart BOOL NOT NULL,
  GameTemplateId  SERIAL NOT NULL,
  RepeatInterval INT NOT NULL,
  GameID INT NOT NULL,
  PRIMARY KEY (GameTemplateId),
  FOREIGN KEY (GameID) REFERENCES Game(GameID)
);

CREATE TABLE Joined
(
  Attended BOOL NOT NULL,
  UserID INT NOT NULL,
  GameID INT NOT NULL,
  PRIMARY KEY (UserID, GameID),
  FOREIGN KEY (UserID) REFERENCES PickupUser(UserID),
  FOREIGN KEY (GameID) REFERENCES Game(GameID)
);