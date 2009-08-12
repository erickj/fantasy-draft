CREATE TABLE `players` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `position` varchar(4) NOT NULL default '',
  `pro_team_id` int(11) default '0',
  `modified` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM
