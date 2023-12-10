USE Rook

/*
Drop TABLE Loger.Sess
Drop TABLE Loger.Browser
Drop TABLE Loger.Browser_brand
Drop TABLE Loger.MCardResult
*/

USE Rook

-- Browser session LOG

CREATE Table Loger.Browser_brand (
    BB_Id SMALLINT IDENTITY(1,1) PRIMARY KEY,
    BrandName VARCHAR(24) NOT NULL,
    BrandNormal VARCHAR(24) NOT NULL,
)

CREATE Table Loger.Browser (
    BrCode CHAR(8) PRIMARY KEY,
    BB_Id SMALLINT NOT NULL,
    Vers SMALLINT NOT NULL,
    Lang CHAR(7) NOT NULL,
    DeviceMemory REAL NOT NULL,
    IsNew BIT NOT NULL,
    Created DATETIME NOT NULL,
    Modified DATETIME
)

CREATE Table Loger.Sess (
    Se_Id INT IDENTITY(1,1) PRIMARY KEY,
    BrCode CHAR(8) NOT NULL,
    SessCode CHAR(6) NOT NULL,
    Created DATETIME NOT NULL
)

-- MCard LOG

CREATE Table Loger.MCardResult (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    BrCode CHAR(8) NOT NULL,
    SessCode CHAR(6) NOT NULL,
    Points SMALLINT NOT NULL,
    Moves SMALLINT NOT NULL,
    Duration TIME(3) NOT NULL,
    Created DATETIME NOT NULL
)