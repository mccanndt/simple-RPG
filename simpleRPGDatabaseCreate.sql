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
('Paper Hat', 'In the shape of a sailboat.', 0, 2, 1, 'Head', 'Common', 1, ''),
('Cloth Shirt', 'Hawaiian. Minimal amount of buttons used.', 0, 2, 1, 'Body', 'Common', 2, ''),
('Cloth Pants', 'Silky smooth.', 0, 2, 1, 'Leg', 'Common', 2, ''),
('Cloth Sandals', 'Soft and quiet, but not much protection.', 0, 2, 1, 'Boot', 'Common', 2, ''),
('A Ball of Mud', 'Stress relief is invaluable.', 2, 2, 1, 'Jewelry', 'Common', 2, ''),
('A Stick', 'What''s brown and sticky?', 8, 0, 1, 'Weapon', 'Common', 3, ''),
-- Commons - Level 5
('Rusty Bucket', 'Empty out the fried pickle spears and use for cranium protection.', 0, 10, 5, 'Head', 'Common', 1, ''),
('Hide Jerkin', 'Made from the hides of your enemies.', 0, 10, 5, 'Body', 'Common', 2, ''),
('Work Slacks', 'Battered and torn. Expensive at one time, but probably not anymore.', 0, 10, 5, 'Leg', 'Common', 2, ''),
('Leather Boots', 'Found in a local Hot Topic.', 0, 10, 5, 'Boot', 'Common', 2, ''),
('Twine Necklace', 'This prime-time twine necklace uses fine twine made of thyme.', 10, 10, 5, 'Jewelry', 'Common', 2, ''),
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
('Two Chains (Gold)', 'Talk Dirty and have no Mercy.', 100, 100, 20, 'Jewelry', 'Magic', 2, ''),
('Metal Lance', 'Not lance with the long hair and eye makeup... an actual spear.', 400, 0, 20, 'Weapon', 'Magic', 3, ''),
-- Rare - Level 30
('Mid-Life Crisis Ball Cap', "Level 30 shouldn't wear this backwards, but you don't care.", 0, 250, 30, 'Head', 'Rare', 1, ''),
('Mid-Life Crisis Varsity Jacket', 'Putting this on brings back a youthful vigor.', 0, 250, 30, 'Body', 'Rare', 2, ''),
('Mid-Life Crisis "Too old for those" Jeans', '', 0, 250, 30, 'Leg', 'Rare', 2, ''),
('Converse All-Stars', 'These were cool before, so they can be cool again!', 0, 250, 30, 'Boot', 'Rare', 2, ''),
('Generic Tribal Tattoo', 'Adds over 9000 cool points.', 250, 250, 30, 'Jewelry', 'Rare', 2, ''),
('Broken Beer Bottle', 'A makeshift weapon when the reunion turns into a brawl.', 1000, 0, 30, 'Weapon', 'Rare', 3, ''),
-- Rare - Level 50
('Blindfold', 'Unsure how this helps, but some people like it.', 60, 860, 50, 'Head', 'Rare', 1, ''),
('Fur Coat', 'This same coat you may have seen at a thrift shop.', 40, 890, 50, 'Body', 'Rare', 2, ''),
('Leather Chaps', 'You have other pants to wear too right?', 40, 1000, 50, 'Leg', 'Rare', 2, ''),
('Studded Biker Boots', 'Ok now this is getting weird.', 40, 1030, 50, 'Boot', 'Rare', 2, ''),
('50 Shades of Grey', 'Last known copy that was not destroyed from overuse.', 900, 900, 50, 'Jewelry', 'Rare', 2, ''),
('Bull whip', 'When a problem comes along, You must whip it.', 5000, 160, 50, 'Weapon', 'Rare', 3, ''),
-- Legendary - Level 75
('Red Bandana', 'Keeps sweat out of your eyes and that is all you need.', 100, 1200, 75, 'Head', 'Legendary', 1, ''),
('Ammo Belt', 'More offense is sometimes the best defense.', 100, 1290, 75, 'Body', 'Legendary', 2, ''),
('Camo Pants', 'Tough to see, with plenty of cargo pockets.', 140, 1520, 75, 'Leg', 'Legendary', 2, ''),
('Army Boots', 'Tan with a little bit of red splotches.', 120, 1400, 75, 'Boot', 'Legendary', 2, ''),
('Dog Tags', 'They were not yours, but now they are.', 1300, 1300, 75, 'Jewelry', 'Legendary', 100, ''),
('Machine Gun', 'Packs a massive punch, a lot of massive punches, at a high rate of punching.', 9200, 600, 75, 'Weapon', 'Legendary', 3, ''),
-- Legendairy - Level 100
('Cheesehead Hat', 'Taken from a Green Bay Packers fan.', 100, 2000, 100, 'Head', 'Legendairy', 1, ''),
('Four Pronged Belly Protector', 'Udderly strong.', 160, 2070, 100, 'Body', 'Legendairy', 2, ''),
('Calf-Length Khakis', 'Neat cow print too, for style points and to help sneak up on cows.', 140, 2120, 100, 'Leg', 'Legendairy', 2, ''),
('COWboy Boots', 'Made from rattlesnake skin probably.', 120, 2180, 100, 'Boot', 'Legendairy', 2, ''),
('The Cowbell', 'The only known artifact that can defeat the Reaper.', 2100, 2100, 100, 'Jewelry', 'Legendairy', 100, ''),
('A Drumstick', 'Perfect combination for The Cowbell.', 17776, 600, 100, 'Weapon', 'Legendairy', 100, '');

-- -----------------------------------------------------
-- Insert Enemy
-- -----------------------------------------------------
INSERT INTO enemy (Name, BasePower, BaseDefense, BaseHealth, Level, IsBoss, BaseExp, AttackRate) VALUES
-- Level 1
('Imp', 8, 7, 55, 1, 0, 1, 1.5),
('Mouse', 7, 6, 40, 1, 0, 1, 1),
('Pigeon', 7, 6, 45, 1, 0, 1, 1.2),
('Squirrel', 9, 9, 100, 1, 1, 4, 1),
-- Level 5
('Bear Cub', 9, 9, 40, 5, 0, 4, 1),
('Wolf', 10, 10, 50, 5, 0, 4, 1.2),
('Massive Crab', 11, 11, 70, 5, 0, 4, 1.5),
('Old Wrestler', 13, 13, 150, 5, 1, 7, 1),
-- Level 10
('Deer', 26, 29, 400, 10, 0, 7, 1.1),
('Treant', 30, 29, 420, 10, 0, 7, 0.9),
('Swarm of Bugs', 30, 35, 500, 10, 0, 7, 1.3),
('Goblin Gang', 28, 34, 515, 10, 0, 7, 1.2),
('Basilisk', 30, 17, 900, 10, 0, 7, 1.5),
('Zombie', 31, 31, 450, 10, 0, 7, 1.2),
('Hairy Pooter', 32, 32, 500, 10, 1, 18, 1.2),
('Massive Gorilla', 33, 33, 600, 10, 1, 18, 1.25),
-- Level 20
('Robot', 114, 113, 1900, 20, 0, 18, 1.3),
('Evil Fridge', 110, 117, 1900, 20, 0, 18, 1.3),
('Kitchen Sink', 107, 120, 1940, 20, 0, 18, 1.5),
('Wide Screen TV', 114, 110, 2050, 20, 0, 18, 1.5),
('Scared Blender', 117, 112, 1900, 20, 0, 18, 1.2),
('A Metal Slime', 114, 111, 2080, 20, 0, 18, 1),
('A Ginormous Sword', 115, 110, 2100, 20, 0, 18, 1),
('Broken VCR', 119, 114, 1900, 20, 0, 18, 1.5),
('Robo Rat 9000', 111, 110, 1810, 20, 0, 18, 1.5),
('Kitten in a Mech', 115, 112, 2000, 20, 0, 18, 1.2),
('Butter-Passing Robot', 113, 111, 2130, 20, 0, 18, 1.2),
('Blind Vigilante', 112, 110, 1900, 20, 0, 18, 1.2),
('Giant Raisin', 113, 110, 1900, 20, 0, 18, 1.2),
('Leonidas', 110, 110, 2800, 20, 1, 50, 1.2),
('Lance Carp', 120, 119, 2900, 20, 1, 50, 1.2),
('Some Random Rapper', 110, 122, 3000, 20, 1, 50, 1.2),
-- Level 30
('A Bearded Man', 400, 403, 6333, 30, 0, 50, 1.3),
('A Bearded Lady', 400, 410, 6500, 30, 0, 50, 1.3),
('Floppy Mattress', 412, 422, 6440, 30, 0, 50, 1),
('Ghost Dad', 390, 451, 6500, 30, 0, 50, 1.3),
('Type 2 Diabetes', 420, 402, 6140, 30, 0, 50, 1.3),
('Couch', 426, 404, 6600, 30, 0, 50, 1.2),
('A Pile of Debt', 416, 410, 6200, 30, 0, 50, 1.1),
('A Very Sad Slinky :c', 410, 427, 6300, 30, 0, 50, 1.3),
('The Small Lebobski', 435, 440, 11200, 30, 1, 89, 1.3),
('Rob Boss', 440, 440, 12000, 30, 1, 89, 1.3),
-- Level 50
('Two Bananas In Pyjamas', 1641, 1571, 50000, 50, 0, 89, 1.3),
('A Used Black Couch', 1641, 1591, 52000, 50, 0, 89, 1.3),
('Pizza Delivery Man', 1611, 1611, 54000, 50, 0, 89, 1.3),
('An Italian Plumber', 1631, 1631, 56000, 50, 0, 89, 1.3),
('Another Italian Plumber', 1651, 1651, 58000, 50, 0, 89, 1.3),
('Bored Housewife', 1671, 1671, 60000, 50, 0, 89, 1.3),
('A Giant Chicken', 1691, 1691, 62000, 50, 0, 89, 1.3),
('The Entire Hells Angels', 1700, 1720, 85000, 50, 1, 158, 1.3),
-- Level 75
('T-800', 3076, 3071, 100000, 75, 0, 158, 1),
('A Bunch of Little Green Army Men', 3001, 3091, 101000, 75, 0, 158, 1.1),
('The Elusive ''C.S''', 3065, 3011, 100000, 75, 0, 158, 1.1),
('Excitable Ninja Samurai', 3022, 3031, 105000, 75, 0, 158, 1.2),
('Chip Hazard', 3086, 3071, 108000, 75, 0, 158, 1.2),
('Brick Bazooka', 3159, 3091, 100000, 75, 0, 158, 1.2),
('Rombo', 3041, 3050, 100000, 75, 1, 465, 1.2),
('The A-Team', 3133, 3133, 133333, 75, 1, 465, 1.2),
-- Level 100
('Veal Corleone', 6300, 7100, 256000, 100, 0, 465, 1),
('Captain Milk', 6200, 7100, 250000, 100, 0, 465, 1.1),
('Hannibull Lecter', 6665, 7200, 250000, 100, 0, 465, 1.1),
('Lord Voldemoot', 6480, 7400, 255000, 100, 0, 465, 1.2),
('Admiral Ackbarn', 6500, 7500, 248000, 100, 0, 465, 1.2),
('The Mooderer', 6550, 7550, 260000, 100, 0, 465, 1.2),
('Dairy Queen', 6600, 7600, 335000, 100, 1, 1500, 1.2),
('Genghis Cown', 6600, 7600, 332000, 100, 1, 1500, 1.2),
-- The Reaper
('The Reaper', 8000, 8000, 3000000, 1978, 1, 1500, 2)
