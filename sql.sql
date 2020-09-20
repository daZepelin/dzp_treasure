CREATE TABLE `treasure_boxes` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `coords` varchar(255) NOT NULL,
  `contents` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);


INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`, `price`, `limit`) VALUES ('carkey', 'Abandoned car key', '0', '0', '1', '0', '-1')
