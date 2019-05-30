-- -----------------------------------------------------
-- Delete, Create, and Use Schema prs
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS simpleRPG;
CREATE SCHEMA IF NOT EXISTS simpleRPG;
USE simpleRPG;

-- -----------------------------------------------------
-- Table Player
-- -----------------------------------------------------
CREATE TABLE player (
  ID			INT			NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
  UserName		VARCHAR(45)	NOT NULL,
  Password		VARCHAR(45)	NOT NULL,
  BasePower		INT			NOT NULL,
  BaseDefense	INT			NOT NULL,
  BaseHealth	INT			NOT NULL,
  Level			INT			NOT NULL,
  InventorySize	INT			NOT NULL,
  CurrentExp	INT			NOT NULL,
  HeadItemID	INT,
  BodyItemID	INT,
  LegItemID		INT,
  BootItemID	INT,
  JewelryItemID	INT,
  WeaponItemID	INT,
  IsActive		TINYINT(1)	NOT NULL	DEFAULT 1,
  DateCreated	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
  DateUpdated	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP	ON UPDATE CURRENT_TIMESTAMP,
  UpdatedByUser INT			NOT NULL	DEFAULT 1,
  CONSTRAINT uname UNIQUE (UserName)
);

-- -----------------------------------------------------
-- Table Item
-- -----------------------------------------------------
CREATE TABLE item (
  ID			INT			NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
  Name			VARCHAR(45)	NOT NULL,
  FlavorText	VARCHAR(100),
  Power			INT			NOT NULL,
  Defense		INT			NOT NULL,
  Level			INT			NOT NULL,
  Slot			VARCHAR(45)	NOT NULL,
  Rarity		VARCHAR(45)	NOT NULL,
  Value			INT			NOT NULL,
  IconPath		VARCHAR(255),
  IsActive		TINYINT(1)	NOT NULL	DEFAULT 1,
  DateCreated	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
  DateUpdated	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP	ON UPDATE CURRENT_TIMESTAMP,
  UpdatedByUser INT			NOT NULL	DEFAULT 1,
  CONSTRAINT iname UNIQUE(Name)
);

-- -----------------------------------------------------
-- Table Inventory
-- -----------------------------------------------------
CREATE TABLE inventory (
  ID			INT			NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
  PlayerID		INT			NOT NULL,
  ItemID		INT			NOT NULL,
  IsActive		TINYINT(1)	NOT NULL	DEFAULT 1,
  DateCreated	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
  DateUpdated	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP	ON UPDATE CURRENT_TIMESTAMP,
  UpdatedByUser INT			NOT NULL	DEFAULT 1,
  FOREIGN KEY (PlayerID) REFERENCES player(ID),
  FOREIGN KEY (ItemID) REFERENCES item(ID)
);

-- -----------------------------------------------------
-- Table Enemy
-- -----------------------------------------------------
CREATE TABLE enemy (
  ID			INT			NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
  Name			VARCHAR(45)	NOT NULL,
  BasePower		INT			NOT NULL,
  BaseDefense	INT			NOT NULL,
  BaseHealth	INT			NOT NULL,
  Level			INT			NOT NULL,
  IsBoss		TINYINT(1)	NOT NULL	DEFAULT 0,
  BaseExp		INT			NOT NULL,
  AttackRate	DOUBLE(5,2)	NOT NULL,
  IsActive		TINYINT(1)	NOT NULL	DEFAULT 1,
  DateCreated	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
  DateUpdated	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP	ON UPDATE CURRENT_TIMESTAMP,
  UpdatedByUser INT			NOT NULL	DEFAULT 1,
  CONSTRAINT name_level UNIQUE (Name, Level)
);

-- -----------------------------------------------------
-- Table Loot
-- -----------------------------------------------------
CREATE TABLE loot (
  ID			INT	NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
  EnemyID		INT	NOT NULL,
  ItemID		INT	NOT NULL,
  IsActive		TINYINT(1)	NOT NULL	DEFAULT 1,
  DateCreated	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP,
  DateUpdated	DATETIME	NOT NULL	DEFAULT CURRENT_TIMESTAMP	ON UPDATE CURRENT_TIMESTAMP,
  UpdatedByUser INT			NOT NULL	DEFAULT 1,
  FOREIGN KEY (EnemyID) REFERENCES enemy(ID),
  FOREIGN KEY (ItemID) REFERENCES item(ID)
);

-- -----------------------------------------------------
-- Create a user and grant privileges to that user
-- -----------------------------------------------------
CREATE USER IF NOT EXISTS simpleRPG_user@localhost IDENTIFIED BY 'Th1sIs@ReallyLongP@ssw0rd';
GRANT SELECT, INSERT, DELETE, UPDATE ON simpleRPG.* TO simpleRPG_user@localhost;

-- -----------------------------------------------------
-- Insert Item
-- -----------------------------------------------------
INSERT INTO item (Name, FlavorText, Power, Defense, Level, Slot, Rarity, Value, IconPath) VALUES
-- Commons - Level 1
('Paper Hat', 'In the shape of a sailboat', 0, 2, 1, 'Head', 'Common', 1, ''),
('Cloth Shirt', '', 0, 2, 1, 'Body', 'Common', 2, ''),
('Cloth Pants', '', 0, 2, 1, 'Leg', 'Common', 2, ''),
('Cloth Sandals', '', 0, 2, 1, 'Boot', 'Common', 2, ''),
('A Ball of Mud', '', 2, 2, 1, 'Jewelry', 'Common', 2, ''),
('A Stick', 'What''s brown and sticky?', 8, 0, 1, 'Weapon', 'Common', 3, ''),
-- Commons - Level 5
('Rusty Bucket', 'Empty out the fried pickle spears and use for cranium protection.', 0, 10, 5, 'Head', 'Common', 1, ''),
('Hide Jerkin', 'Made from the hides of your enemies.', 0, 10, 5, 'Body', 'Common', 2, ''),
('Camo Trousers', 'Tough to see, but plenty of cargo pockets.', 0, 10, 5, 'Leg', 'Common', 2, ''),
('Leather Boots', 'Found in a local Hot Topic.', 0, 10, 5, 'Boot', 'Common', 2, ''),
('Twine Necklace', 'This prime-time twine necklace uses fine twine made of thyme', 10, 10, 5, 'Jewelry', 'Common', 2, ''),
('Stone Axe', 'Simple, but effective.', 40, 0, 5, 'Weapon', 'Common', 3, ''),
-- Magic - Level 10
('Wizard Hat', 'Yer a wizard now.', 0, 40, 10, 'Head', 'Magic', 1, ''),
('Arcane Robes', 'Soft and velvety.', 0, 40, 10, 'Body', 'Magic', 2, ''),
('Wizz Shorts', 'Is wizz short for wizard shorts or did you wizz in your shorts?', 0, 40, 10, 'Leg', 'Magic', 2, ''),
('Glass Slippers', 'Fragile, but fashionable.', 0, 40, 10, 'Boot', 'Magic', 2, ''),
('Crystal Ball', 'Even without magic you could just smack someone with it.', 40, 40, 10, 'Jewelry', 'Magic', 2, ''),
('Gnarled Staff', 'Veins of glowing energy course through this branch.', 160, 0, 10, 'Weapon', 'Magic', 3, ''),
-- Magic - Level 20
('Spartan Helmet', 'Intimidation level of 300.', 0, 100, 20, 'Head', 'Magic', 1, ''),
('6 Pack Abs Breastplate', "If you don't have a 6-pack, now you do.", 0, 100, 20, 'Body', 'Magic', 2, ''),
('Metal Jockstrap', 'Enough protection where it matters, but freedom of mobility.', 0, 100, 20, 'Leg', 'Magic', 2, ''),
('Steel Toed Buttkickers', 'Can kick many things, not just butts.', 0, 100, 20, 'Boot', 'Magic', 2, ''),
('Two Chains (Gold)', 'Talk Dirty and have no Mercy', 100, 100, 20, 'Jewelry', 'Magic', 2, ''),
('Metal Lance', 'Not lance with the long hair and eye makeup... an actual spear.', 400, 0, 20, 'Weapon', 'Magic', 3, ''),
-- Rare - Level 30
('Mid-Life Crisis Ball Cap', "Level 30 shouldn't wear this backwards, but you don't care", 0, 250, 30, 'Head', 'Rare', 1, ''),
('Mid-Life Crisis Varsity Jacket', 'Putting this on brings back a youthful vigor.', 0, 250, 30, 'Body', 'Rare', 2, ''),
('Mid-Life Crisis "Too old for those" Jeans', '', 0, 250, 30, 'Leg', 'Rare', 2, ''),
('Converse All-Stars', 'These were cool before, so they can be cool again!', 0, 250, 30, 'Boot', 'Rare', 2, ''),
('Generic Tribal Tattoo', 'Adds over 9000 cool points.', 250, 250, 30, 'Jewelry', 'Rare', 2, ''),
('Broken Beer Bottle', 'A makeshift weapon when the reunion turns into a brawl.', 1000, 0, 30, 'Weapon', 'Rare', 3, ''),
-- Rare - Level 50
('', '', 60, 860, 50, 'Head', 'Rare', 1, ''),
('', '', 40, 890, 50, 'Body', 'Rare', 2, ''),
('', '', 40, 1000, 50, 'Leg', 'Rare', 2, ''),
('', '', 40, 1030, 50, 'Boot', 'Rare', 2, ''),
('', '', 900, 900, 50, 'Jewelry', 'Rare', 2, ''),
('', '', 5000, 160, 50, 'Weapon', 'Rare', 3, ''),
-- Legendary - Level 75
('', '', 100, 1200, 75, 'Head', 'Legendary', 1, ''),
('', '', 100, 1290, 75, 'Body', 'Legendary', 2, ''),
('', '', 140, 1520, 75, 'Leg', 'Legendary', 2, ''),
('', '', 120, 1400, 75, 'Boot', 'Legendary', 2, ''),
('', '', 1300, 1300, 75, 'Jewelry', 'Legendary', 100, ''),
('', '', 9200, 600, 75, 'Weapon', 'Legendary', 3, ''),
-- Legendairy - Level 100
('', '', 100, 2000, 100, 'Head', 'Legendairy', 1, ''),
('', '', 160, 2070, 100, 'Body', 'Legendairy', 2, ''),
('', '', 140, 2120, 100, 'Leg', 'Legendairy', 2, ''),
('', '', 120, 2180, 100, 'Boot', 'Legendairy', 2, ''),
('The Cowbell', '', 2100, 2100, 100, 'Jewelry', 'Legendairy', 100, ''),
('A Drumstick', '', 17776, 600, 100, 'Weapon', 'Legendairy', 100, '');

-- -----------------------------------------------------
-- Insert Enemy
-- -----------------------------------------------------
INSERT INTO enemy (Name, BasePower, BaseDefense, BaseHealth, Level, IsBoss, BaseExp, AttackRate) VALUES
-- Level 1
('', 8, 7, 55, 1, 0, 1.5),
('', 7, 6, 40, 1, 0, 0, 1),
('', 7, 6, 45, 1, 0, 0, 1.2),
('', 9, 9, 100, 1, 1, 1),
-- Level 5
('', 9, 9, 40, 5, 0, 1),
('', 10, 10, 50, 5, 0, 1.2),
('', 11, 11, 70, 5, 0, 1.5),
('', 13, 13, 150, 5, 1, 1),
-- Level 10
('', 30, 29, , 10, 0, 0),
-- Level 20
('', 0, 0, 0, 20, 0, 0),
-- Level 30
('', 0, 0, 0, 30, 0, 0),
-- Level 50
('', 0, 0, 0, 50, 0, 0),
-- Level 75
('', 0, 0, 0, 75, 0, 0),
-- Level 100
('', 0, 0, 0, 100, 0, 0)