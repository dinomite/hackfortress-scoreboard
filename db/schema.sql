DROP TABLE IF EXISTS `puzzle`;
CREATE TABLE `puzzle` (
    `puzzleID` smallint(3) unsigned NOT NULL auto_increment,
    `name` varchar(64) NOT NULL default '',
    `description` varchar(300) NOT NULL default '',
    `difficultyID` tinyint(1) unsigned NOT NULL default 0,
    `category` enum('Binary', 'Cryptography', 'Information Gathering', 'Network', 'Physical', 'Web') NOT NULL default 'Physical',
    `updated` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    PRIMARY KEY (`puzzleID`),
    UNIQUE KEY `name_difficulty` (`name`, `difficultyID`),
    FOREIGN KEY (`difficultyID`) REFERENCES `difficulty` (`difficultyID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `difficulty`;
CREATE TABLE `difficulty` (
    `difficultyID` tinyint(1) unsigned NOT NULL auto_increment,
    `name` varchar(16) NOT NULL default '',
    `points` smallint(3) default 0,
    PRIMARY KEY (`difficultyID`),
    UNIQUE KEY (`name`, `points`),
    KEY (`difficultyID`, `name`, `points`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `round_has_puzzle`;
CREATE TABLE `round_has_puzzle` (
    `puzzleID` smallint(3) unsigned NOT NULL,
    `roundID` smallint(3) unsigned NOT NULL,
    PRIMARY KEY (`puzzleID`, `roundID`),
    FOREIGN KEY (`puzzleID`) REFERENCES `puzzle` (`puzzleID`),
    FOREIGN KEY (`roundID`) REFERENCES `round` (`roundID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `team`;
CREATE TABLE `team` (
    `teamID` tinyint(1) unsigned NOT NULL auto_increment,
    `name` varchar(64) NOT NULL default '',
    PRIMARY KEY (`teamID`),
    KEY (`teamID`, `name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `round`;
CREATE TABLE `round` (
    `roundID` tinyint(1) unsigned NOT NULL auto_increment,
    `roundName` enum('First', 'Semi-final', 'Final') NOT NULL default 'First',
    `red_team` tinyint(1) unsigned NOT NULL,
    `blue_team` tinyint(1) unsigned NOT NULL,
    PRIMARY KEY (`roundID`),
    FOREIGN KEY (`red_team`) REFERENCES `team` (`teamID`),
    FOREIGN KEY (`blue_team`) REFERENCES `team` (`teamID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `score`;
CREATE TABLE `score` (
    `scoreID` smallint(1) unsigned NOT NULL auto_increment,
    `teamID` tinyint(1) unsigned NOT NULL,
    `roundID` tinyint(1) unsigned NOT NULL,
    `puzzleID` tinyint(1) unsigned NOT NULL,
    PRIMARY KEY (`scoreID`),
    UNIQUE KEY (`teamID`, `puzzleID`),
    FOREIGN KEY (`teamID`) REFERENCES `team` (`teamID`),
    FOREIGN KEY (`roundID`) REFERENCES `round` (`roundID`),
    FOREIGN KEY (`puzzleID`) REFERENCES `puzzle` (`puzzleID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
