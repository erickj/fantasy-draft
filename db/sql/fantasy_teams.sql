CREATE TABLE `fantasy_teams` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `owner` varchar(255) NOT NULL default '',
  `fantasy_league_id` int(11) NOT NULL default 0,
  `modified` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY (`name`),
  KEY (`fantasy_league_id`),
  UNIQUE KEY `fantasy_league_team` (`fantasy_league_id`, `name`)
) ENGINE=MyISAM
