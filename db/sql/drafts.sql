CREATE TABLE `drafts` (
  `id` int(11) NOT NULL auto_increment,
  `fantasy_league_id` int(11) NOT NULL default 0,
  `modified` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `fantasy_league_id` (`fantasy_league_id`)
) ENGINE=MyISAM
