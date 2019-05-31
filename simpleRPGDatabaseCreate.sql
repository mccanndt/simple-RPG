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
  IconPath		VARCHAR(255),
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
  IconPath		VARCHAR(255),
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
INSERT INTO item (ID, Name, FlavorText, Power, Defense, Level, Slot, Rarity, Value, IconPath) VALUES
-- Commons - Level 1
(1, 'Paper Hat', 'In the shape of a sailboat.', 0, 2, 1, 'Head', 'Common', 1, ''),
(2, 'Cloth Shirt', 'Hawaiian. Minimal amount of buttons used.', 0, 2, 1, 'Body', 'Common', 2, ''),
(3, 'Cloth Pants', 'Silky smooth.', 0, 2, 1, 'Leg', 'Common', 2, ''),
(4, 'Cloth Sandals', 'Soft and quiet, but not much protection.', 0, 2, 1, 'Boot', 'Common', 2, ''),
(5, 'A Ball of Mud', 'Stress relief is invaluable.', 2, 2, 1, 'Jewelry', 'Common', 2, ''),
(6, 'A Stick', 'What''s brown and sticky?', 8, 0, 1, 'Weapon', 'Common', 3, ''),
-- Commons - Level 5
(7, 'Rusty Bucket', 'Empty out the fried pickle spears and use for cranium protection.', 0, 10, 5, 'Head', 'Common', 1, ''),
(8, 'Hide Jerkin', 'Made from the hides of your enemies.', 0, 10, 5, 'Body', 'Common', 2, ''),
(9, 'Work Slacks', 'Battered and torn. Expensive at one time, but probably not anymore.', 0, 10, 5, 'Leg', 'Common', 2, ''),
(10, 'Leather Boots', 'Found in a local Hot Topic.', 0, 10, 5, 'Boot', 'Common', 2, ''),
(11, 'Twine Necklace', 'This prime-time twine necklace uses fine twine made of thyme.', 10, 10, 5, 'Jewelry', 'Common', 2, ''),
(12, 'Stone Axe', 'Simple, but effective.', 40, 0, 5, 'Weapon', 'Common', 3, ''),
-- Magic - Level 10
(13, 'Wizard Hat', 'Yer a wizard now.', 0, 40, 10, 'Head', 'Magic', 1, ''),
(14, 'Arcane Robes', 'Soft and velvety.', 0, 40, 10, 'Body', 'Magic', 2, ''),
(15, 'Wizz Shorts', 'Is wizz short for wizard shorts or did you wizz in your shorts?', 0, 40, 10, 'Leg', 'Magic', 2, ''),
(16, 'Glass Slippers', 'Fragile, but fashionable.', 0, 40, 10, 'Boot', 'Magic', 2, ''),
(17, 'Crystal Ball', 'Even without magic you could just smack someone with it.', 40, 40, 10, 'Jewelry', 'Magic', 2, ''),
(18, 'Gnarled Staff', 'Veins of glowing energy course through this branch.', 160, 0, 10, 'Weapon', 'Magic', 3, ''),
-- Magic - Level 20
(19, 'Spartan Helmet', 'Intimidation level of 300.', 0, 100, 20, 'Head', 'Magic', 1, ''),
(20, '6 Pack Abs Breastplate', "If you don't have a 6-pack, now you do.", 0, 100, 20, 'Body', 'Magic', 2, ''),
(21, 'Metal Jockstrap', 'Enough protection where it matters, but freedom of mobility.', 0, 100, 20, 'Leg', 'Magic', 2, ''),
(22, 'Steel Toed Buttkickers', 'Can kick many things, not just butts.', 0, 100, 20, 'Boot', 'Magic', 2, ''),
(23, 'Two Chains (Gold)', 'Talk Dirty and have no Mercy.', 100, 100, 20, 'Jewelry', 'Magic', 2, ''),
(24, 'Metal Lance', 'Not lance with the long hair and eye makeup... an actual spear.', 400, 0, 20, 'Weapon', 'Magic', 3, ''),
-- Rare - Level 30
(25, 'Mid-Life Crisis Ball Cap', "Level 30 shouldn't wear this backwards, but you don't care.", 0, 250, 30, 'Head', 'Rare', 1, ''),
(26, 'Mid-Life Crisis Varsity Jacket', 'Putting this on brings back a youthful vigor.', 0, 250, 30, 'Body', 'Rare', 2, ''),
(27, 'Mid-Life Crisis "Too old for those" Jeans', '', 0, 250, 30, 'Leg', 'Rare', 2, ''),
(28, 'Converse All-Stars', 'These were cool before, so they can be cool again!', 0, 250, 30, 'Boot', 'Rare', 2, ''),
(29, 'Generic Tribal Tattoo', 'Adds over 9000 cool points.', 250, 250, 30, 'Jewelry', 'Rare', 2, ''),
(30, 'Broken Beer Bottle', 'A makeshift weapon when the reunion turns into a brawl.', 1000, 0, 30, 'Weapon', 'Rare', 3, ''),
-- Rare - Level 50
(31, 'Blindfold', 'Unsure how this helps, but some people like it.', 60, 860, 50, 'Head', 'Rare', 1, ''),
(32, 'Fur Coat', 'This same coat you may have seen at a thrift shop.', 40, 890, 50, 'Body', 'Rare', 2, ''),
(33, 'Leather Chaps', 'You have other pants to wear too right?', 40, 1000, 50, 'Leg', 'Rare', 2, ''),
(34, 'Studded Biker Boots', 'Ok now this is getting weird.', 40, 1030, 50, 'Boot', 'Rare', 2, ''),
(35, '50 Shades of Grey', 'Last known copy that was not destroyed from overuse.', 900, 900, 50, 'Jewelry', 'Rare', 2, ''),
(36, 'Bull whip', 'When a problem comes along, You must whip it.', 5000, 160, 50, 'Weapon', 'Rare', 3, ''),
-- Legendary - Level 75
(37, 'Red Bandana', 'Keeps sweat out of your eyes and that is all you need.', 100, 1200, 75, 'Head', 'Legendary', 1, ''),
(38, 'Ammo Belt', 'More offense is sometimes the best defense.', 100, 1290, 75, 'Body', 'Legendary', 2, ''),
(39, 'Camo Pants', 'Tough to see, with plenty of cargo pockets.', 140, 1520, 75, 'Leg', 'Legendary', 2, ''),
(40, 'Army Boots', 'Tan with a little bit of red splotches.', 120, 1400, 75, 'Boot', 'Legendary', 2, ''),
(41, 'Dog Tags', 'They were not yours, but now they are.', 1300, 1300, 75, 'Jewelry', 'Legendary', 100, ''),
(42, 'Machine Gun', 'Packs a massive punch, a lot of massive punches, at a high rate of punching.', 9200, 600, 75, 'Weapon', 'Legendary', 3, ''),
-- Legendairy - Level 100
(43, 'Cheesehead Hat', 'Taken from a Green Bay Packers fan.', 100, 2000, 100, 'Head', 'Legendairy', 1, ''),
(44, 'Four Pronged Belly Protector', 'Udderly strong.', 160, 2070, 100, 'Body', 'Legendairy', 2, ''),
(45, 'Calf-Length Khakis', 'Neat cow print too, for style points and to help sneak up on cows.', 140, 2120, 100, 'Leg', 'Legendairy', 2, ''),
(46, 'COWboy Boots', 'Made from rattlesnake skin probably.', 120, 2180, 100, 'Boot', 'Legendairy', 2, ''),
(47, 'The Cowbell', 'The only known artifact that can defeat the Reaper.', 2100, 2100, 100, 'Jewelry', 'Legendairy', 100, ''),
(48, 'A Drumstick', 'Perfect combination for The Cowbell.', 17776, 600, 100, 'Weapon', 'Legendairy', 100, '');

-- -----------------------------------------------------
-- Insert Enemy
-- -----------------------------------------------------
INSERT INTO enemy (ID, Name, BasePower, BaseDefense, BaseHealth, Level, IsBoss, BaseExp, AttackRate, IconPath) VALUES
-- Level 1
(1, 'Imp', 8, 7, 55, 1, 0, 1, 1.5, ''),
(2, 'Mouse', 7, 6, 40, 1, 0, 1, 1, ''),
(3, 'Pigeon', 7, 6, 45, 1, 0, 1, 1.2, ''),
(4, 'Squirrel', 9, 9, 100, 1, 1, 4, 1, ''),
-- Level 5
(5, 'Bear Cub', 9, 9, 40, 5, 0, 4, 1, ''),
(6, 'Wolf', 10, 10, 50, 5, 0, 4, 1.2, ''),
(7, 'Massive Crab', 11, 11, 70, 5, 0, 4, 1.5, ''),
(8, 'Old Wrestler', 13, 13, 150, 5, 1, 7, 1, ''),
-- Level 10
(9, 'Deer', 26, 29, 400, 10, 0, 7, 1.1, ''),
(10, 'Treant', 30, 29, 420, 10, 0, 7, 0.9, ''),
(11, 'Swarm of Bugs', 30, 35, 500, 10, 0, 7, 1.3, ''),
(12, 'Goblin Gang', 28, 34, 515, 10, 0, 7, 1.2, ''),
(13, 'Basilisk', 30, 17, 900, 10, 0, 7, 1.5, ''),
(14, 'Zombie', 31, 31, 450, 10, 0, 7, 1.2, ''),
(15, 'Hairy Pooter', 32, 32, 500, 10, 1, 18, 1.2, ''),
(16, 'Massive Gorilla', 33, 33, 600, 10, 1, 18, 1.25, ''),
-- Level 20
(17, 'Robot', 114, 113, 1900, 20, 0, 18, 1.3, ''),
(18, 'Evil Fridge', 110, 117, 1900, 20, 0, 18, 1.3, ''),
(19, 'Kitchen Sink', 107, 120, 1940, 20, 0, 18, 1.5, ''),
(20, 'Wide Screen TV', 114, 110, 2050, 20, 0, 18, 1.5, ''),
(21, 'Scared Blender', 117, 112, 1900, 20, 0, 18, 1.2, ''),
(22, 'A Metal Slime', 114, 111, 2080, 20, 0, 18, 1, ''),
(23, 'A Ginormous Sword', 115, 110, 2100, 20, 0, 18, 1, ''),
(24, 'Broken VCR', 119, 114, 1900, 20, 0, 18, 1.5, ''),
(25, 'Robo Rat 9000', 111, 110, 1810, 20, 0, 18, 1.5, ''),
(26, 'Kitten in a Mech', 115, 112, 2000, 20, 0, 18, 1.2, ''),
(27, 'Butter-Passing Robot', 113, 111, 2130, 20, 0, 18, 1.2, ''),
(28, 'Blind Vigilante', 112, 110, 1900, 20, 0, 18, 1.2, ''),
(29, 'Giant Raisin', 113, 110, 1900, 20, 0, 18, 1.2, ''),
(30, 'Leonidas', 110, 110, 2800, 20, 1, 50, 1.2, ''),
(31, 'Lance Carp', 120, 119, 2900, 20, 1, 50, 1.2, ''),
(32, 'Some Random Rapper', 110, 122, 3000, 20, 1, 50, 1.2, ''),
-- Level 30
(33, 'A Bearded Man', 400, 403, 6333, 30, 0, 50, 1.3, ''),
(34, 'A Bearded Lady', 400, 410, 6500, 30, 0, 50, 1.3, ''),
(35, 'Floppy Mattress', 412, 422, 6440, 30, 0, 50, 1, ''),
(36, 'Ghost Dad', 390, 451, 6500, 30, 0, 50, 1.3, ''),
(37, 'Type 2 Diabetes', 420, 402, 6140, 30, 0, 50, 1.3, ''),
(38, 'Couch', 426, 404, 6600, 30, 0, 50, 1.2, ''),
(39, 'A Pile of Debt', 416, 410, 6200, 30, 0, 50, 1.1, ''),
(40, 'A Very Sad Slinky :c', 410, 427, 6300, 30, 0, 50, 1.3, ''),
(41, 'The Small Lebobski', 435, 440, 11200, 30, 1, 89, 1.3, ''),
(42, 'Rob Boss', 440, 440, 12000, 30, 1, 89, 1.3, ''),
-- Level 50
(43, 'Two Bananas In Pyjamas', 1641, 1571, 50000, 50, 0, 89, 1.3, ''),
(44, 'A Used Black Couch', 1641, 1591, 52000, 50, 0, 89, 1.3, ''),
(45, 'Pizza Delivery Man', 1611, 1611, 54000, 50, 0, 89, 1.3, ''),
(46, 'An Italian Plumber', 1631, 1631, 56000, 50, 0, 89, 1.3, ''),
(47, 'Another Italian Plumber', 1651, 1651, 58000, 50, 0, 89, 1.3, ''),
(48, 'Bored Housewife', 1671, 1671, 60000, 50, 0, 89, 1.3, ''),
(49, 'A Giant Chicken', 1691, 1691, 62000, 50, 0, 89, 1.3, ''),
(50, 'The Entire Hells Angels', 1700, 1720, 85000, 50, 1, 158, 1.3, ''),
-- Level 75
(51, 'T-800', 3076, 3071, 100000, 75, 0, 158, 1, ''),
(52, 'A Bunch of Little Green Army Men', 3001, 3091, 101000, 75, 0, 158, 1.1, ''),
(53, 'The Elusive ''C.S''', 3065, 3011, 100000, 75, 0, 158, 1.1, ''),
(54, 'Excitable Ninja Samurai', 3022, 3031, 105000, 75, 0, 158, 1.2, ''),
(55, 'Chip Hazard', 3086, 3071, 108000, 75, 0, 158, 1.2, ''),
(56, 'Brick Bazooka', 3159, 3091, 100000, 75, 0, 158, 1.2, ''),
(57, 'Rombo', 3041, 3050, 100000, 75, 1, 465, 1.2, ''),
(58, 'The A-Team', 3133, 3133, 133333, 75, 1, 465, 1.2, ''),
-- Level 100
(59, 'Veal Corleone', 6300, 7100, 256000, 100, 0, 465, 1, ''),
(60, 'Captain Milk', 6200, 7100, 250000, 100, 0, 465, 1.1, ''),
(61, 'Hannibull Lecter', 6665, 7200, 250000, 100, 0, 465, 1.1, ''),
(62, 'Lord Voldemoot', 6480, 7400, 255000, 100, 0, 465, 1.2, ''),
(63, 'Admiral Ackbarn', 6500, 7500, 248000, 100, 0, 465, 1.2, ''),
(64, 'The Mooderer', 6550, 7550, 260000, 100, 0, 465, 1.2, ''),
(65, 'Dairy Queen', 6600, 7600, 335000, 100, 1, 1500, 1.2, ''),
(66, 'Genghis Cown', 6600, 7600, 332000, 100, 1, 1500, 1.2, ''),
-- The Reaper
(67, 'The Reaper', 8000, 8000, 3000000, 1978, 1, 1500, 2, '');

-- -----------------------------------------------------
-- Insert Loot
-- -----------------------------------------------------
INSERT INTO loot (ID, EnemyID, ItemID) VALUES
-- Level 1 EnemyID and ItemID
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
--
(7, 2, 1),
(8, 2, 2),
(9, 2, 3),
(10, 2, 4),
(11, 2, 5),
(12, 2, 6),
--
(13, 3, 1),
(14, 3, 2),
(15, 3, 3),
(16, 3, 4),
(17, 3, 5),
(18, 3, 6),
--
(19, 4, 1),
(20, 4, 2),
(21, 4, 3),
(22, 4, 4),
(23, 4, 5),
(24, 4, 6),
-- Level 5 EnemyID and ItemID
(25, 5, 7),
(26, 5, 8),
(27, 5, 9),
(28, 5, 10),
(29, 5, 11),
(30, 5, 12),
--
(31, 6, 7),
(32, 6, 8),
(33, 6, 9),
(34, 6, 10),
(35, 6, 11),
(36, 6, 12),
--
(37, 7, 7),
(38, 7, 8),
(39, 7, 9),
(40, 7, 10),
(41, 7, 11),
(42, 7, 12),
--
(43, 8, 7),
(44, 8, 8),
(45, 8, 9),
(46, 8, 10),
(47, 8, 11),
(48, 8, 12),
-- Level 10 EnemyID and ItemID
(49, 9, 13),
(50, 9, 14),
(51, 9, 15),
(52, 9, 16),
(53, 9, 17),
(54, 9, 18),
--
(55, 10, 13),
(56, 10, 14),
(57, 10, 15),
(58, 10, 16),
(59, 10, 17),
(60, 10, 18),
--
(61, 11, 13),
(62, 11, 14),
(63, 11, 15),
(64, 11, 16),
(65, 11, 17),
(66, 11, 18),
--
(67, 12, 13),
(68, 12, 14),
(69, 12, 15),
(70, 12, 16),
(71, 12, 17),
(72, 12, 18),
--
(73, 13, 13),
(74, 13, 14),
(75, 13, 15),
(76, 13, 16),
(77, 13, 17),
(78, 13, 18),
--
(79, 14, 13),
(80, 14, 14),
(81, 14, 15),
(82, 14, 16),
(83, 14, 17),
(84, 14, 18),
--
(85, 15, 13),
(86, 15, 14),
(87, 15, 15),
(88, 15, 16),
(89, 15, 17),
(90, 15, 18),
--
(91, 16, 13),
(92, 16, 14),
(93, 16, 15),
(94, 16, 16),
(95, 16, 17),
(96, 16, 18),
-- Level 20 EnemyID and ItemID
(97, 17, 19),
(98, 17, 20),
(99, 17, 21),
(100, 17, 22),
(101, 17, 23),
(102, 17, 24),
--
(103, 18, 19),
(104, 18, 20),
(105, 18, 21),
(106, 18, 22),
(107, 18, 23),
(108, 18, 24),
--
(109, 19, 19),
(110, 19, 20),
(111, 19, 21),
(112, 19, 22),
(113, 19, 23),
(114, 19, 24),
--
(115, 20, 19),
(116, 20, 20),
(117, 20, 21),
(118, 20, 22),
(119, 20, 23),
(120, 20, 24),
--
(121, 21, 19),
(122, 21, 20),
(123, 21, 21),
(124, 21, 22),
(125, 21, 23),
(126, 21, 24),
--
(127, 22, 19),
(128, 22, 20),
(129, 22, 21),
(130, 22, 22),
(131, 22, 23),
(132, 22, 24),
--
(133, 23, 19),
(134, 23, 20),
(135, 23, 21),
(136, 23, 22),
(137, 23, 23),
(138, 23, 24),
--
(139, 24, 19),
(140, 24, 20),
(141, 24, 21),
(142, 24, 22),
(143, 24, 23),
(144, 24, 24),
--
(145, 25, 19),
(146, 25, 20),
(147, 25, 21),
(148, 25, 22),
(149, 25, 23),
(150, 25, 24),
--
(151, 26, 19),
(152, 26, 20),
(153, 26, 21),
(154, 26, 22),
(155, 26, 23),
(156, 26, 24),
--
(157, 27, 19),
(158, 27, 20),
(159, 27, 21),
(160, 27, 22),
(161, 27, 23),
(162, 27, 24),
--
(163, 28, 19),
(164, 28, 20),
(165, 28, 21),
(166, 28, 22),
(167, 28, 23),
(168, 28, 24),
--
(169, 29, 19),
(170, 29, 20),
(171, 29, 21),
(172, 29, 22),
(173, 29, 23),
(174, 29, 24),
--
(175, 30, 19),
(176, 30, 20),
(177, 30, 21),
(178, 30, 22),
(179, 30, 23),
(180, 30, 24),
--
(181, 31, 19),
(182, 31, 20),
(183, 31, 21),
(184, 31, 22),
(185, 31, 23),
(186, 31, 24),
--
(187, 32, 19),
(188, 32, 20),
(189, 32, 21),
(190, 32, 22),
(191, 32, 23),
(192, 32, 24),
-- Level 30 EnemyID and ItemID
(193, 33, 25),
(194, 33, 26),
(195, 33, 27),
(196, 33, 28),
(197, 33, 29),
(198, 33, 30),
--
(199, 34, 25),
(200, 34, 26),
(201, 34, 27),
(202, 34, 28),
(203, 34, 29),
(204, 34, 30),
--
(205, 35, 25),
(206, 35, 26),
(207, 35, 27),
(208, 35, 28),
(209, 35, 29),
(210, 35, 30),
--
(211, 36, 25),
(212, 36, 26),
(213, 36, 27),
(214, 36, 28),
(215, 36, 29),
(216, 36, 30),
--
(217, 37, 25),
(218, 37, 26),
(219, 37, 27),
(220, 37, 28),
(221, 37, 29),
(222, 37, 30),
--
(223, 38, 25),
(224, 38, 26),
(225, 38, 27),
(226, 38, 28),
(227, 38, 29),
(228, 38, 30),
--
(229, 39, 25),
(230, 39, 26),
(231, 39, 27),
(232, 39, 28),
(233, 39, 29),
(234, 39, 30),
--
(235, 40, 25),
(236, 40, 26),
(237, 40, 27),
(238, 40, 28),
(239, 40, 29),
(240, 40, 30),
--
(241, 41, 25),
(242, 41, 26),
(243, 41, 27),
(244, 41, 28),
(245, 41, 29),
(246, 41, 30),
--
(247, 42, 25),
(248, 42, 26),
(249, 42, 27),
(250, 42, 28),
(251, 42, 29),
(252, 42, 30),
-- Level 50 EnemyID and ItemID
(253, 43, 31),
(254, 43, 32),
(255, 43, 33),
(256, 43, 34),
(257, 43, 35),
(258, 43, 36),
--
(259, 44, 31),
(260, 44, 32),
(261, 44, 33),
(262, 44, 34),
(263, 44, 35),
(264, 44, 36),
--
(265, 45, 31),
(266, 45, 32),
(267, 45, 33),
(268, 45, 34),
(269, 45, 35),
(270, 45, 36),
--
(271, 46, 31),
(272, 46, 32),
(273, 46, 33),
(274, 46, 34),
(275, 46, 35),
(276, 46, 36),
--
(277, 47, 31),
(278, 47, 32),
(279, 47, 33),
(280, 47, 34),
(281, 47, 35),
(282, 47, 36),
--
(283, 48, 31),
(284, 48, 32),
(285, 48, 33),
(286, 48, 34),
(287, 48, 35),
(288, 48, 36),
--
(289, 49, 31),
(290, 49, 32),
(291, 49, 33),
(292, 49, 34),
(293, 49, 35),
(294, 49, 36),
--
(295, 50, 31),
(296, 50, 32),
(297, 50, 33),
(298, 50, 34),
(299, 50, 35),
(300, 50, 36),
-- Level 75 EnemyID and ItemID
(301, 51, 37),
(302, 51, 38),
(303, 51, 39),
(304, 51, 40),
(305, 51, 41),
(306, 51, 42),
--
(307, 52, 37),
(308, 52, 38),
(309, 52, 39),
(310, 52, 40),
(311, 52, 41),
(312, 52, 42),
--
(313, 53, 37),
(314, 53, 38),
(315, 53, 39),
(316, 53, 40),
(317, 53, 41),
(318, 53, 42),
--
(319, 54, 37),
(320, 54, 38),
(321, 54, 39),
(322, 54, 40),
(323, 54, 41),
(324, 54, 42),
--
(325, 55, 37),
(326, 55, 38),
(327, 55, 39),
(328, 55, 40),
(329, 55, 41),
(330, 55, 42),
--
(331, 56, 37),
(332, 56, 38),
(333, 56, 39),
(334, 56, 40),
(335, 56, 41),
(336, 56, 42),
--
(337, 57, 37),
(338, 57, 38),
(339, 57, 39),
(340, 57, 40),
(341, 57, 41),
(342, 57, 42),
--
(343, 58, 37),
(344, 58, 38),
(345, 58, 39),
(346, 58, 40),
(347, 58, 41),
(348, 58, 42),
-- 100 EnemyID and ItemID
(349, 59, 43),
(350, 59, 44),
(351, 59, 45),
(352, 59, 46),
(353, 59, 47),
(354, 59, 48),
--
(355, 60, 43),
(356, 60, 44),
(357, 60, 45),
(358, 60, 46),
(359, 60, 47),
(360, 60, 48),
--
(361, 61, 43),
(362, 61, 44),
(363, 61, 45),
(364, 61, 46),
(365, 61, 47),
(366, 61, 48),
--
(367, 62, 43),
(368, 62, 44),
(369, 62, 45),
(370, 62, 46),
(371, 62, 47),
(372, 62, 48),
--
(373, 63, 43),
(374, 63, 44),
(375, 63, 45),
(376, 63, 46),
(377, 63, 47),
(378, 63, 48),
--
(379, 64, 43),
(380, 64, 44),
(381, 64, 45),
(382, 64, 46),
(383, 64, 47),
(384, 64, 48),
--
(385, 65, 43),
(386, 65, 44),
(387, 65, 45),
(388, 65, 46),
(389, 65, 47),
(390, 65, 48),
--
(391, 66, 43),
(392, 66, 44),
(393, 66, 45),
(394, 66, 46),
(395, 66, 47),
(396, 66, 48);