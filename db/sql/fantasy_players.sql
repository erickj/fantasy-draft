CREATE TABLE `fantasy_players` (
  `id` int(11) NOT NULL auto_increment,
  `fantasy_league_id` int(11) NOT NULL default 0,
  `fantasy_team_id` int(11) NOT NULL default 0,
  `player_id` int(11) NOT NULL default 0,
  `modified` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY (`fantasy_league_id`),
  KEY (`fantasy_team_id`),
  KEY (`player_id`),
  UNIQUE KEY `league_player` (`fantasy_league_id`, `player_id`)
) ENGINE=MyISAM
