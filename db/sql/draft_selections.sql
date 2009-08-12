CREATE TABLE `draft_selections` (
  `id` int(11) NOT NULL auto_increment,
  `draft_id` int(11) NOT NULL default 0,
  `fantasy_team_id` int(11) NOT NULL default 0,
  `fantasy_player_id` int(11) NOT NULL default 0,
  `round` int(11) NOT NULL default 0,
  `pick` int(11) NOT NULL default 0,
  `modified` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY (`draft_id`),
  KEY (`fantasy_team_id`),
  KEY (`fantasy_player_id`),
  KEY (`draft_id`),
  UNIQUE KEY `selection` (`round`, `pick`, `draft_id`),
  UNIQUE KEY `player_selection` (`fantasy_player_id`, `draft_id`)
) ENGINE=MyISAM
