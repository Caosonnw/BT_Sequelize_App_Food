/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `food` (
  `food_id` int NOT NULL AUTO_INCREMENT,
  `food_name` varchar(150) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `descr` varchar(300) DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  PRIMARY KEY (`food_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `food_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `food_type` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `food_type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `like_res` (
  `date_like` datetime DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `res_id` int DEFAULT NULL,
  KEY `user_id` (`user_id`),
  KEY `res_id` (`res_id`),
  CONSTRAINT `like_res_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `like_res_ibfk_2` FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `orders` (
  `amount` int DEFAULT NULL,
  `code` varchar(150) DEFAULT NULL,
  `arr_sub_id` varchar(150) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `food_id` int DEFAULT NULL,
  KEY `user_id` (`user_id`),
  KEY `food_id` (`food_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `rate_res` (
  `amount` int DEFAULT NULL,
  `date_rate` datetime DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `res_id` int DEFAULT NULL,
  KEY `user_id` (`user_id`),
  KEY `res_id` (`res_id`),
  CONSTRAINT `rate_res_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `rate_res_ibfk_2` FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `restaurant` (
  `res_id` int NOT NULL AUTO_INCREMENT,
  `res_name` varchar(150) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  `descr` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`res_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sub_food` (
  `sub_id` int NOT NULL AUTO_INCREMENT,
  `sub_name` varchar(150) DEFAULT NULL,
  `sub_price` float DEFAULT NULL,
  `food_id` int DEFAULT NULL,
  PRIMARY KEY (`sub_id`),
  KEY `food_id` (`food_id`),
  CONSTRAINT `sub_food_ibfk_1` FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(150) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `refresh_token` text,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `descr`, `type_id`) VALUES
(1, 'Cơm rang', 'com-rang.jpg', 50000, 'Cơm chiên với rau cải và thịt gà', 1);
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `descr`, `type_id`) VALUES
(2, 'Canh chua', 'canh-chua.jpg', 40000, 'Canh chua cá nấu với dưa cải và cà chua', 1);
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `descr`, `type_id`) VALUES
(3, 'Gà chiên', 'ga-chien.jpg', 60000, 'Gà rán giòn', 1);
INSERT INTO `food` (`food_id`, `food_name`, `image`, `price`, `descr`, `type_id`) VALUES
(4, 'Salad trộn', 'salad.jpg', 45000, 'Salad gồm rau cải tươi và sốt dầu giấm', 2),
(5, 'Piza', 'piza.jpg', 80000, 'Piza hải sản với nhiều loại hải sản', 1),
(6, 'Chè trôi nước', 'che-troi-nuoc.jpg', 25000, 'Chè trôi nước với nước cốt dừa', 3);

INSERT INTO `food_type` (`type_id`, `type_name`) VALUES
(1, 'Món chính');
INSERT INTO `food_type` (`type_id`, `type_name`) VALUES
(2, 'Món phụ');
INSERT INTO `food_type` (`type_id`, `type_name`) VALUES
(3, 'Tráng miệng');

INSERT INTO `like_res` (`date_like`, `user_id`, `res_id`) VALUES
('2024-04-01 08:00:00', 2, 1);
INSERT INTO `like_res` (`date_like`, `user_id`, `res_id`) VALUES
('2024-04-02 09:30:00', 2, 2);
INSERT INTO `like_res` (`date_like`, `user_id`, `res_id`) VALUES
('2024-04-03 11:15:00', 1, 3);
INSERT INTO `like_res` (`date_like`, `user_id`, `res_id`) VALUES
('2024-04-04 08:00:00', 4, 1),
('2024-04-05 09:30:00', 5, 2),
('2024-04-06 11:15:00', 3, 3),
('2024-04-07 12:00:00', 2, 1),
('2024-04-08 14:30:00', 1, 2),
('2024-04-09 16:45:00', 2, 3);

INSERT INTO `orders` (`amount`, `code`, `arr_sub_id`, `user_id`, `food_id`) VALUES
(2, 'ORDER123', '1,3', 1, 1);
INSERT INTO `orders` (`amount`, `code`, `arr_sub_id`, `user_id`, `food_id`) VALUES
(1, 'ORDER456', '2', 1, 4);
INSERT INTO `orders` (`amount`, `code`, `arr_sub_id`, `user_id`, `food_id`) VALUES
(3, 'ORDER789', '5,6', 3, 5);
INSERT INTO `orders` (`amount`, `code`, `arr_sub_id`, `user_id`, `food_id`) VALUES
(3, 'ORDER446336', '[1,3,4]', 7, 1);

INSERT INTO `rate_res` (`amount`, `date_rate`, `user_id`, `res_id`) VALUES
(4, '2024-04-01 10:30:00', 1, 1);
INSERT INTO `rate_res` (`amount`, `date_rate`, `user_id`, `res_id`) VALUES
(5, '2024-04-02 12:45:00', 2, 2);
INSERT INTO `rate_res` (`amount`, `date_rate`, `user_id`, `res_id`) VALUES
(3, '2024-04-03 15:20:00', 3, 3);

INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `descr`) VALUES
(1, 'Nhà hàng A', 'nha-hang-a.jpg', 'Nhà hàng phục vụ các món ăn Á Đông');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `descr`) VALUES
(2, 'Quán ăn B', 'quan-an-b.jpg', 'Quán ăn nổi tiếng với các món phụ phong phú');
INSERT INTO `restaurant` (`res_id`, `res_name`, `image`, `descr`) VALUES
(3, 'Nhà hàng C', 'nha-hang-c.jpg', 'Nhà hàng sang trọng với không gian thoáng đãng');

INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`) VALUES
(1, 'Nước ngọt', 10000, 1);
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`) VALUES
(2, 'Nước mắm', 5000, 1);
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`) VALUES
(3, 'Bún', 10000, 2);
INSERT INTO `sub_food` (`sub_id`, `sub_name`, `sub_price`, `food_id`) VALUES
(4, 'Rau sống', 10000, 2),
(5, 'Khoai tây chiên', 20000, 5),
(6, 'Hành phi', 5000, 5);

INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `refresh_token`) VALUES
(1, 'Nguyễn Văn A', 'nguyenvana@example.com', 'password123', NULL);
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `refresh_token`) VALUES
(2, 'Trần Thị B', 'tranthib@example.com', 'securepass', NULL);
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `refresh_token`) VALUES
(3, 'Lê Hoàng C', 'lehoangc@example.com', '123456', NULL);
INSERT INTO `users` (`user_id`, `full_name`, `email`, `password`, `refresh_token`) VALUES
(4, 'Phạm Thị D', 'phamthid@example.com', 'pass123', NULL),
(5, 'Hoàng Văn E', 'hoangvane@example.com', 'abc@123', NULL),
(6, 'Trần Văn F', 'tranvanf@example.com', 'password456', NULL),
(7, 'Cao Sơn', 'caoson@gmail.com', '$2b$10$2y1GXi.Y6fngwd15dGiUyOtztfgjP7nwh.oADM9EvLBXq2ioxcrPO', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7InVzZXJfaWQiOjcsImtleSI6ImxiQk54ZiJ9LCJpYXQiOjE3MTQ3NjQ0OTcsImV4cCI6MTcxNzM1NjQ5N30.XzqRrthm4IRIF4qEqSeEuWsGdGBTRqi3ffiozBADUw0');


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;