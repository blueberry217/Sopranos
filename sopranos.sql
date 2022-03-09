-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 09 mrt 2022 om 17:33
-- Serverversie: 10.4.11-MariaDB
-- PHP-versie: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sopranos`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `address_street` varchar(255) NOT NULL,
  `address_city` varchar(100) NOT NULL,
  `address_state` varchar(100) NOT NULL,
  `address_zip` varchar(50) NOT NULL,
  `address_country` varchar(100) NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `accounts`
--

INSERT INTO `accounts` (`id`, `email`, `password`, `first_name`, `last_name`, `address_street`, `address_city`, `address_state`, `address_zip`, `address_country`, `admin`) VALUES
(1, '122399@mborijnland.nl', '$2y$10$pEHRAE4Ia0mE9BdLmbS.ueQsv/.WlTUSW7/cqF/T36iW.zDzSkx4y', 'John', 'Doe', '98 High Street', 'New York', 'NY', '10001', 'United States', 1);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, ' Tonno'),
(2, 'Vegan'),
(3, 'Accessories');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `discounts`
--

CREATE TABLE `discounts` (
  `id` int(11) NOT NULL,
  `category_ids` varchar(50) NOT NULL,
  `product_ids` varchar(50) NOT NULL,
  `discount_code` varchar(50) NOT NULL,
  `discount_type` enum('Percentage','Fixed') NOT NULL,
  `discount_value` decimal(7,2) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `discounts`
--

INSERT INTO `discounts` (`id`, `category_ids`, `product_ids`, `discount_code`, `discount_type`, `discount_value`, `start_date`, `end_date`) VALUES
(1, '', '', 'newyear2021', 'Percentage', '5.00', '2021-01-01 00:00:00', '2021-12-31 00:00:00');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(7,2) NOT NULL,
  `rrp` decimal(7,2) NOT NULL DEFAULT 0.00,
  `quantity` int(11) NOT NULL,
  `img` text NOT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `weight` decimal(7,2) NOT NULL DEFAULT 0.00,
  `url_structure` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `rrp`, `quantity`, `img`, `date_added`, `weight`, `url_structure`) VALUES
(1, 'Pizza Tonno', '<h3>Beschrijving</h3>\r\n\r\n<h5>tonijn,tomaten,oregano,kaas,ui</h5>', '5.00', '0.00', -1, 'tonno.jpg', '2020-03-13 17:55:22', '0.00', ''),
(2, 'Pizza Vegan', '', '5.00', '0.00', -1, 'vegan.jpg', '2020-03-13 18:52:49', '0.00', ''),
(3, 'Quattro formaggio', '', '5.00', '0.00', -1, 'quattro.png', '2020-03-13 18:47:56', '34.00', ''),
(4, 'Sopranos Deluxe', '', '5.00', '0.00', 43642, 'deluxe.jpg', '2020-03-14 17:42:04', '0.00', '');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `products_categories`
--

CREATE TABLE `products_categories` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `products_categories`
--

INSERT INTO `products_categories` (`id`, `product_id`, `category_id`) VALUES
(1, 1, 2),
(2, 2, 1);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `products_images`
--

CREATE TABLE `products_images` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `img` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `products_images`
--

INSERT INTO `products_images` (`id`, `product_id`, `img`) VALUES
(3, 1, 'quattro.png'),
(1, 1, 'tonno.jpg'),
(2, 1, 'vegan.jpg'),
(4, 2, 'deluxe.jpg'),
(5, 3, 'headphones.jpg'),
(6, 4, 'camera.jpg');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `products_options`
--

CREATE TABLE `products_options` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(7,2) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `products_options`
--

INSERT INTO `products_options` (`id`, `title`, `name`, `price`, `product_id`) VALUES
(1, 'Size', 'Medium', '5.00', 1),
(2, 'Size', 'Large', '10.00', 1),
(3, 'Size', 'Calzone\r\n', '15.00', 1),
(5, 'Size', 'Medium', '5.00', 2),
(6, 'Size', 'Large', '10.00', 2),
(7, 'Size', 'Calzone\r\n', '15.00', 2);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `shipping`
--

CREATE TABLE `shipping` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price_from` decimal(7,2) NOT NULL,
  `price_to` decimal(7,2) NOT NULL,
  `price` decimal(7,2) NOT NULL,
  `weight_from` decimal(7,2) NOT NULL DEFAULT 0.00,
  `weight_to` decimal(7,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `shipping`
--

INSERT INTO `shipping` (`id`, `name`, `price_from`, `price_to`, `price`, `weight_from`, `weight_to`) VALUES
(1, 'Standard', '0.00', '99999.00', '3.99', '0.00', '99999.00'),
(2, 'International', '0.00', '99999.00', '7.99', '0.00', '99999.00');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `txn_id` varchar(255) NOT NULL,
  `payment_amount` decimal(7,2) NOT NULL,
  `payment_status` varchar(30) NOT NULL,
  `created` datetime NOT NULL,
  `payer_email` varchar(255) NOT NULL DEFAULT '',
  `first_name` varchar(100) NOT NULL DEFAULT '',
  `last_name` varchar(100) NOT NULL DEFAULT '',
  `address_street` varchar(255) NOT NULL DEFAULT '',
  `address_city` varchar(100) NOT NULL DEFAULT '',
  `address_state` varchar(100) NOT NULL DEFAULT '',
  `address_zip` varchar(50) NOT NULL DEFAULT '',
  `address_country` varchar(100) NOT NULL DEFAULT '',
  `account_id` int(11) DEFAULT NULL,
  `payment_method` varchar(50) NOT NULL DEFAULT 'website'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `transactions`
--

INSERT INTO `transactions` (`id`, `txn_id`, `payment_amount`, `payment_status`, `created`, `payer_email`, `first_name`, `last_name`, `address_street`, `address_city`, `address_state`, `address_zip`, `address_country`, `account_id`, `payment_method`) VALUES
(151, 'SP6228D570B8E7F6460B', '140.00', 'Completed', '2022-03-09 17:27:28', '122399@mborijnland.nl', 'test', 'test', 'test', 'test', 'test', 'test', '', NULL, 'optional'),
(152, 'SP6228D6BE2CA0C87D31', '40.00', 'Completed', '2022-03-09 17:33:02', '122399@mborijnland.nl', 'test', 'test', 'test', 'test', '', 'test', '', NULL, 'optional');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `transactions_items`
--

CREATE TABLE `transactions_items` (
  `id` int(11) NOT NULL,
  `txn_id` varchar(255) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_price` decimal(7,2) NOT NULL,
  `item_quantity` int(11) NOT NULL,
  `item_options` varchar(255) NOT NULL,
  `item_shipping_price` decimal(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden geëxporteerd voor tabel `transactions_items`
--

INSERT INTO `transactions_items` (`id`, `txn_id`, `item_id`, `item_price`, `item_quantity`, `item_options`, `item_shipping_price`) VALUES
(1, 'SP6064FA944F82290E62', 2, '14.99', 2, '', '0.00'),
(2, 'SP6064FA944F82290E62', 2, '14.99', 2, '', '0.00'),
(3, 'SP6064FA944F82290E62', 2, '14.99', 1, '', '0.00'),
(4, 'SP6064FA944F82290E62', 2, '14.99', 1, '', '0.00'),
(5, 'SP606650D04CCA9B51D7', 3, '19.99', 1, '', '0.00'),
(6, 'SP606650D04CCA9B51D7', 2, '14.99', 1, '', '0.00'),
(7, 'SP60665217D41C94900D', 2, '14.99', 1, '', '0.00'),
(8, 'SP606652C51F7D7AA513', 2, '14.99', 1, '', '0.00'),
(9, 'SP60665413BAF3D1FE21', 2, '14.99', 1, '', '0.00'),
(10, 'SP606655194C4907BB14', 2, '14.99', 1, '', '0.00'),
(11, 'SP6066551B5C85813E5F', 2, '14.99', 1, '', '0.00'),
(12, 'SP60665568C02EDAF375', 2, '14.99', 1, '', '0.00'),
(13, 'SP606655A3D2041E3A3F', 2, '14.99', 1, '', '0.00'),
(14, 'SP606656B681B022D582', 2, '14.99', 1, '', '0.00'),
(15, 'SP60665A99C20082EB6D', 2, '14.99', 1, '', '0.00'),
(16, 'SP60665CC70BCDF9F2F9', 2, '14.99', 1, '', '0.00'),
(17, 'SP60665FB57CC859F06B', 2, '14.99', 1, '', '0.00'),
(18, 'SP60683BB94744CEEFA2', 2, '5.00', 4, '', '0.00'),
(19, 'SP60683BB94744CEEFA2', 2, '5.00', 1, '', '0.00'),
(20, 'SP60683BD67B37932C3C', 2, '5.00', 1, '', '0.00'),
(21, 'SP60683BD67B37932C3C', 4, '5.00', 1, '', '0.00'),
(22, 'SP60683C92174F878808', 2, '5.00', 1, '', '0.00'),
(23, 'SP6068502A3C4F9EA04D', 2, '5.00', 1, '', '0.00'),
(24, 'SP6068502A3C4F9EA04D', 2, '5.00', 1, '', '0.00'),
(25, 'SP60687E1CAAAE6B31D7', 2, '5.00', 1, 'Size-Medium', '0.00'),
(26, 'SP6068A316024F8CF51E', 2, '10.00', 1, 'Size-Large', '0.00'),
(27, 'SP6068A316024F8CF51E', 1, '10.00', 1, 'Size-Large', '0.00'),
(28, 'SP6068A316024F8CF51E', 1, '5.00', 2, 'Size-Medium', '0.00'),
(29, 'SP6068A316024F8CF51E', 2, '5.00', 1, 'Size-Medium', '0.00'),
(30, 'SP6068A316024F8CF51E', 2, '5.00', 1, 'Size-Medium', '0.00'),
(31, 'SP6068A32F3E7D678F5A', 2, '5.00', 1, 'Size-Medium', '0.00'),
(32, 'SP6068AF191D7953F0E2', 2, '5.00', 1, 'Size-Medium', '0.00'),
(33, 'SP6068AF191D7953F0E2', 1, '15.00', 1, 'Size-Calzone\r\n', '0.00'),
(34, 'SP6068AF4AAE8FBA74A7', 2, '5.00', 1, 'Size-Medium', '0.00'),
(35, 'SP6068AFC9E94C30E3F9', 2, '5.00', 1, 'Size-Medium', '0.00'),
(36, 'SP6068AFF755F179A5C4', 2, '5.00', 1, 'Size-Medium', '0.00'),
(37, 'SP6068B0D9F0101E9654', 2, '5.00', 1, 'Size-Medium', '0.00'),
(38, 'SP6068B1128ACC9D816A', 2, '5.00', 1, 'Size-Medium', '0.00'),
(39, 'SP6068B1643E4CE88704', 1, '5.00', 1, 'Size-Medium', '0.00'),
(40, 'SP6068B1643E4CE88704', 3, '5.00', 1, '', '0.00'),
(41, 'SP6068B2424C9BF6BF68', 2, '5.00', 1, 'Size-Medium', '0.00'),
(42, 'SP6068B29BDDDC4DBD40', 2, '5.00', 1, 'Size-Medium', '0.00'),
(43, 'SP6068B29BDDDC4DBD40', 1, '5.00', 1, 'Size-Medium', '0.00'),
(44, 'SP6068B70B380629ED82', 2, '15.00', 1, 'Size-Calzone\r\n', '0.00'),
(45, 'SP6068B70B380629ED82', 2, '5.00', 1, 'Size-Medium', '0.00'),
(46, 'SP6068C49FAB5396098B', 1, '10.00', 1, 'Size-Large', '0.00'),
(47, 'SP6068C4CB12A1327501', 2, '5.00', 1, 'Size-Medium', '0.00'),
(48, 'SP6068C4CB12A1327501', 2, '5.00', 1, 'Size-Medium', '0.00'),
(49, 'SP6068CC6E6FC5E66E6A', 2, '5.00', 4, 'Size-Medium', '0.00'),
(50, 'SP6068CEAE47AC77A70A', 2, '5.00', 1, 'Size-Medium', '0.00'),
(51, 'SP6068CEAE47AC77A70A', 2, '5.00', 1, 'Size-Medium', '0.00'),
(52, 'SP6068CEAE47AC77A70A', 1, '5.00', 1, 'Size-Medium', '0.00'),
(53, 'SP6068CEAE47AC77A70A', 4, '5.00', 1, '', '0.00'),
(54, 'SP606B41262CA5890341', 2, '15.00', 5, 'Size-Calzone\r\n ', '0.00'),
(55, 'SP606B41262CA5890341', 2, '5.00', 11, 'Size-Medium ', '0.00'),
(56, 'SP606B41262CA5890341', 2, '10.00', 1, 'Size-Large ', '0.00'),
(57, 'SP606C8BBF739F0E4A08', 2, '10.00', 1, 'Size-Large ', '0.00'),
(58, 'SP606C8FBE7240720631', 4, '5.00', 1, '', '0.00'),
(59, 'SP606C9033502A52CFD5', 2, '10.00', 1, 'Size-Large ', '0.00'),
(60, 'SP606C904EE92F8E771F', 2, '10.00', 1, 'Size-Large ', '0.00'),
(61, 'SP606C9056B6E6F60176', 2, '10.00', 1, 'Size-Large ', '0.00'),
(62, 'SP606C905C3C477EEB5C', 2, '10.00', 1, 'Size-Large ', '0.00'),
(63, 'SP606C906DD66A3AFFE5', 2, '10.00', 1, 'Size-Large ', '0.00'),
(64, 'SP606C9096E77075FACA', 2, '10.00', 1, 'Size-Large ', '0.00'),
(65, 'SP606C90EB8176872AEE', 2, '10.00', 1, 'Size-Large ', '0.00'),
(66, 'SP606C90F3012C961B14', 2, '10.00', 1, 'Size-Large ', '0.00'),
(67, 'SP606C90FCC2E912A2C7', 2, '10.00', 1, 'Size-Large ', '0.00'),
(68, 'SP606C913C60269B1323', 2, '10.00', 1, 'Size-Large ', '0.00'),
(69, 'SP606C914A87C92C9143', 2, '10.00', 1, 'Size-Large ', '0.00'),
(70, 'SP606C915B3F3FB835DF', 2, '10.00', 1, 'Size-Large ', '0.00'),
(71, 'SP606C9160EA7E3A9670', 2, '10.00', 1, 'Size-Large ', '0.00'),
(72, 'SP606C916E4D1D3BD6C6', 2, '15.00', 1, 'Size-Calzone\r\n ', '0.00'),
(73, 'SP606C920EF0BCBF0218', 2, '15.00', 1, 'Size-Calzone\r\n ', '0.00'),
(74, 'SP606C922541EE233437', 2, '15.00', 1, 'Size-Calzone\r\n ', '0.00'),
(75, 'SP606C923A2BE4486E40', 2, '15.00', 1, 'Size-Calzone\r\n ', '0.00'),
(76, 'SP606DD129258C91D636', 4, '5.00', 1, '', '0.00'),
(77, 'SP606DD129258C91D636', 1, '10.00', 1, 'Size-Large ', '0.00'),
(78, 'SP606DD129258C91D636', 1, '15.00', 1, 'Size-Calzone\r\n ', '0.00'),
(79, 'SP606DD18079A959DE87', 4, '5.00', 1, '', '0.00'),
(80, 'SP606DD18079A959DE87', 2, '10.00', 1, 'Size-Large ', '0.00'),
(81, 'SP606DD18079A959DE87', 3, '5.00', 1, '', '0.00'),
(82, 'SP606DD18079A959DE87', 3, '5.00', 1, '', '0.00'),
(83, 'SP606DD18079A959DE87', 4, '5.00', 1, '', '0.00'),
(84, 'SP606DD1AAB3D58616A4', 2, '10.00', 1, 'Size-Large ', '0.00'),
(85, 'SP606DD1C89947374642', 2, '10.00', 1, 'Size-Large ', '0.00'),
(86, 'SP606DD2E9D14F6946F9', 4, '5.00', 1, '', '0.00'),
(87, 'SP606DD2FCED8DD7DAC7', 4, '5.00', 1, '', '0.00'),
(88, 'SP606DEA999DDA9589CF', 4, '5.00', 1, '', '0.00'),
(89, 'SP606DEAC0B4CEC1CA5E', 4, '5.00', 1, '', '0.00'),
(90, 'SP606DEAF36DADC3485D', 4, '5.00', 1, '', '0.00'),
(91, 'SP606DEB24E67B7EA065', 4, '5.00', 1, '', '0.00'),
(92, 'SP606DED1ED2C6288966', 4, '5.00', 1, '', '0.00'),
(93, 'SP606DED394E0CE6A960', 4, '5.00', 1, '', '0.00'),
(94, 'SP606DF157CED4F66FED', 2, '15.00', 1, 'Size-Calzone\r\n ', '0.00'),
(95, 'SP606E389DA4C488FA53', 4, '5.00', 2, '', '0.00'),
(96, 'SP606E389DA4C488FA53', 2, '5.00', 1, 'Size-Medium ', '0.00'),
(97, 'SP606E389DA4C488FA53', 4, '5.00', 1, '', '0.00'),
(98, 'SP606E38BB5EE9AD2D00', 4, '5.00', 1, '', '0.00'),
(99, 'SP606E38DE1507B7D3F3', 4, '5.00', 1, '', '0.00'),
(100, 'SP606E393F6B6F659758', 4, '5.00', 1, '', '0.00'),
(101, 'SP606E394EDC8F65427B', 4, '5.00', 1, '', '0.00'),
(102, 'SP606E3A0CD2C1F1707C', 4, '5.00', 1, '', '0.00'),
(103, 'SP606F2B55E7E3072589', 4, '5.00', 2, '', '0.00'),
(104, 'SP606F2B55E7E3072589', 4, '5.00', 2, '', '0.00'),
(105, 'SP60734CD846013DFA58', 4, '5.00', 15, '', '0.00'),
(106, 'SP60734CD846013DFA58', 2, '15.00', 22, 'Size-Calzone\r\n ', '0.00'),
(107, 'SP6073554664F188F6D6', 4, '5.00', 3, '', '0.00'),
(108, 'SP6074670E78396834D3', 4, '5.00', 1, '', '0.00'),
(109, 'SP607467784DE7358F59', 4, '5.00', 1, '', '0.00'),
(110, 'SP60746782CEA094D79A', 4, '5.00', 2, '', '0.00'),
(111, 'SP607467995D961BB2B9', 4, '5.00', 3, '', '0.00'),
(112, 'SP60746824D061B4BC5C', 4, '5.00', 1, '', '0.00'),
(113, 'SP607468620FD97D4CDF', 4, '5.00', 1, '', '0.00'),
(114, 'SP607468905C4236CA01', 4, '5.00', 1, '', '0.00'),
(115, 'SP607469516C0A5314AC', 4, '5.00', 2, '', '0.00'),
(116, 'SP607469B961CE3D024C', 4, '5.00', 2, '', '0.00'),
(117, 'SP607469F9D64F9D88FF', 4, '5.00', 3, '', '0.00'),
(118, 'SP60746A8C2B3929B02A', 4, '5.00', 1, '', '0.00'),
(119, 'SP60746AB5CA2FA65628', 4, '5.00', 1, '', '0.00'),
(120, 'SP60746B2A3BA748E3D2', 4, '5.00', 1, '', '0.00'),
(121, 'SP60746BA93A67C5CE36', 4, '5.00', 1, '', '0.00'),
(122, 'SP60746C130331C647C2', 4, '5.00', 1, '', '0.00'),
(123, 'SP60746C2F00B0D07D37', 4, '5.00', 1, '', '0.00'),
(124, 'SP60746CA782BE2B696B', 4, '5.00', 1, '', '0.00'),
(125, 'SP60746CF3E5A9207347', 4, '5.00', 1, '', '0.00'),
(126, 'SP60746DE6B49889083E', 2, '10.00', 1, 'Size-Large ', '0.00'),
(127, 'SP60746DE6B49889083E', 4, '5.00', 1, '', '0.00'),
(128, 'SP60746DFF95972A0E07', 2, '10.00', 1, 'Size-Large ', '0.00'),
(129, 'SP60746DFF95972A0E07', 4, '5.00', 1, '', '0.00'),
(130, 'SP60746E18532583CD7D', 2, '10.00', 1, 'Size-Large ', '0.00'),
(131, 'SP60746E18532583CD7D', 4, '5.00', 1, '', '0.00'),
(132, 'SP60746E1A66DEC1050A', 2, '10.00', 1, 'Size-Large ', '0.00'),
(133, 'SP60746E1A66DEC1050A', 4, '5.00', 1, '', '0.00'),
(134, 'SP60746E3B81950A7C73', 2, '10.00', 1, 'Size-Large ', '0.00'),
(135, 'SP60746E3B81950A7C73', 4, '5.00', 1, '', '0.00'),
(136, 'SP60746E9E3E6A8EDC86', 4, '5.00', 1, '', '0.00'),
(137, 'SP60746EE86D143CCB5F', 4, '5.00', 1, '', '0.00'),
(138, 'SP6074706EE4384D6B87', 4, '5.00', 1, '', '0.00'),
(139, 'SP60747191D9B134EDA4', 4, '5.00', 1, '', '0.00'),
(140, 'SP607471A64AF069DF70', 4, '5.00', 1, '', '0.00'),
(141, 'SP6074732B01EF3A9CF9', 4, '5.00', 1, '', '0.00'),
(142, 'SP60747474721FA6DA4C', 4, '5.00', 1, '', '0.00'),
(143, 'SP60747712C0C9E18165', 4, '5.00', 1, '', '0.00'),
(144, 'SP60747712C0C9E18165', 2, '15.00', 1, 'Size-Calzone\r\n ', '0.00'),
(145, 'SP60747712C0C9E18165', 3, '5.00', 1, '', '0.00'),
(146, 'SP60747712C0C9E18165', 1, '15.00', 1, 'Size-Calzone\r\n ', '0.00'),
(147, 'SP6074777E8644B27523', 4, '5.00', 1, '', '0.00'),
(148, 'SP607478C0C14B765A71', 4, '5.00', 1, '', '0.00'),
(149, 'SP607479AF8691D359A7', 4, '5.00', 1, '', '0.00'),
(150, 'SP60747AC32F5D063C0C', 4, '5.00', 1, '', '0.00'),
(151, 'SP60747CEF20A50B0F91', 4, '5.00', 1, '', '0.00'),
(152, 'SP60747D3805AE41936C', 4, '5.00', 1, '', '0.00'),
(153, 'SP60747DF24EA7ED03EB', 4, '5.00', 1, '', '0.00'),
(154, 'SP60747E1B07E7001675', 4, '5.00', 1, '', '0.00'),
(155, 'SP60747E5BA24BAFD8D9', 4, '5.00', 1, '', '0.00'),
(156, 'SP60747ED93273807562', 4, '5.00', 1, '', '0.00'),
(157, 'SP60747F1D10839A1FEC', 4, '5.00', 1, '', '0.00'),
(158, 'SP60748001BB706A8D38', 4, '5.00', 1, '', '0.00'),
(159, 'SP607480F60A59A8B812', 4, '5.00', 1, '', '0.00'),
(160, 'SP6074812F9836EDB872', 4, '5.00', 1, '', '0.00'),
(161, 'SP6074818BEC4844D877', 2, '10.00', 1, 'Size-Large ', '0.00'),
(162, 'SP6074865DA14B8261A8', 2, '15.00', 1, 'Size-Calzone\r\n ', '0.00'),
(163, 'SP607486AB3A408AF06F', 4, '5.00', 1, '', '0.00'),
(164, 'SP607488A0660A3620FB', 4, '5.00', 1, '', '0.00'),
(165, 'SP6074896C3B25578F4D', 4, '5.00', 1, '', '0.00'),
(166, 'SP6074896C3B25578F4D', 3, '5.00', 1, '', '0.00'),
(167, 'SP60749642BE655059D5', 4, '5.00', 1, '', '0.00'),
(168, 'SP607496D938EF9ABB02', 4, '5.00', 1, '', '0.00'),
(169, 'SP607496F43BFD892124', 4, '5.00', 1, '', '0.00'),
(170, 'SP607499CD0BB3908F02', 4, '5.00', 1, '', '0.00'),
(171, 'SP60749AA829A49A8C07', 4, '5.00', 1, '', '0.00'),
(172, 'SP6074CA11DF58548464', 4, '5.00', 1, '', '0.00'),
(173, 'SP6074CA11DF58548464', 2, '15.00', 1, 'Size-Calzone\r\n ', '0.00'),
(174, 'SP6074CA11DF58548464', 3, '5.00', 1, '', '0.00'),
(175, 'SP6074CA11DF58548464', 1, '15.00', 1, 'Size-Calzone\r\n ', '0.00'),
(176, 'SP6074CA6B3F5122B562', 4, '5.00', 1, '', '0.00'),
(177, 'SP6074CB9B7078303CBA', 4, '5.00', 1, '', '0.00'),
(178, 'SP6074CC5C3112121A00', 4, '5.00', 1, '', '0.00'),
(179, 'SP6074CC8A3DA9EF16BB', 4, '5.00', 1, '', '0.00'),
(180, 'SP6074CCF6515323B8F3', 4, '5.00', 1, '', '0.00'),
(181, 'SP6074CDC0C4FADCA75B', 4, '5.00', 1, '', '0.00'),
(182, 'SP6074CE1254C72C4D33', 4, '5.00', 1, '', '0.00'),
(183, 'SP6074CFD16F47B8D0DD', 4, '5.00', 2, '', '0.00'),
(184, 'SP6074D0623FA7B1063C', 4, '5.00', 2, '', '0.00'),
(185, 'SP6074D1AE2F8C230C5E', 4, '5.00', 1, '', '0.00'),
(186, 'SP6074D22D42D79BBD3E', 4, '5.00', 1, '', '0.00'),
(187, 'SP6074D2B66FD75DD3AF', 4, '5.00', 1, '', '0.00'),
(188, 'SP6074D30B5E3B0AC6A1', 4, '5.00', 1, '', '0.00'),
(189, 'SP6075835FA69582EAA9', 4, '5.00', 1, '', '0.00'),
(190, 'SP6075896730F65269CC', 4, '5.00', 1, '', '0.00'),
(191, 'SP60759066313141EC46', 4, '5.00', 1, '', '0.00'),
(192, 'SP6075B8D50F6E04D192', 4, '5.00', 1, '', '0.00'),
(193, 'SP6075FAB13169AA95BB', 4, '5.00', 1, '', '0.00'),
(194, 'SP6075FBBC3BECD61D80', 4, '5.00', 1, '', '0.00'),
(195, 'SP607601AAF38B8B58BB', 4, '5.00', 1, '', '0.00'),
(196, 'SP60763127279D2EE7AF', 4, '5.00', 1, '', '0.00'),
(197, 'SP607716C47086A2D57A', 4, '5.00', 1, '', '0.00'),
(198, 'SP607716C47086A2D57A', 2, '15.00', 1, 'Size-Calzone\r\n ', '0.00'),
(199, 'SP607716C47086A2D57A', 1, '5.00', 1, 'Size-Medium ', '0.00'),
(200, 'SP60771AD3B1C22F1E1C', 1, '10.00', 2, 'Size-Large ', '0.00'),
(201, 'SP60771AD3B1C22F1E1C', 1, '15.00', 2, 'Size-Calzone\r\n ', '0.00'),
(202, 'SP60771AD3B1C22F1E1C', 1, '5.00', 2, 'Size-Medium ', '0.00'),
(203, 'SP60771C8F974F220EED', 2, '5.00', 4, 'Size-Medium ', '0.00'),
(204, 'SP60771C8F974F220EED', 2, '15.00', 2, 'Size-Calzone\r\n ', '0.00'),
(205, 'SP60771C8F974F220EED', 2, '10.00', 4, 'Size-Large ', '0.00'),
(206, 'SP60771C8F974F220EED', 1, '5.00', 2, 'Size-Medium ', '0.00'),
(207, 'SP607724BC21BAB343F8', 2, '5.00', 4, 'Size-Medium ', '0.00'),
(208, 'SP607724BC21BAB343F8', 2, '15.00', 8, 'Size-Calzone\r\n ', '0.00'),
(209, 'SP607724BC21BAB343F8', 1, '10.00', 8, 'Size-Large ', '0.00'),
(210, 'SP6228D570B8E7F6460B', 1, '5.00', 5, 'Size-Medium', '0.00'),
(211, 'SP6228D570B8E7F6460B', 3, '5.00', 5, '', '0.00'),
(212, 'SP6228D570B8E7F6460B', 1, '15.00', 6, 'Size-Calzone\r\n', '0.00'),
(213, 'SP6228D6BE2CA0C87D31', 3, '5.00', 3, '', '0.00'),
(214, 'SP6228D6BE2CA0C87D31', 4, '5.00', 1, '', '0.00'),
(215, 'SP6228D6BE2CA0C87D31', 2, '10.00', 1, 'Size-Large ', '0.00'),
(216, 'SP6228D6BE2CA0C87D31', 1, '10.00', 1, 'Size-Large ', '0.00');

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexen voor tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `products` ADD FULLTEXT KEY `url_structure` (`url_structure`);

--
-- Indexen voor tabel `products_categories`
--
ALTER TABLE `products_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_id` (`product_id`,`category_id`);

--
-- Indexen voor tabel `products_images`
--
ALTER TABLE `products_images`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_id` (`product_id`,`img`);

--
-- Indexen voor tabel `products_options`
--
ALTER TABLE `products_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `shipping`
--
ALTER TABLE `shipping`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `txn_id` (`txn_id`);

--
-- Indexen voor tabel `transactions_items`
--
ALTER TABLE `transactions_items`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT voor een tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT voor een tabel `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT voor een tabel `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT voor een tabel `products_categories`
--
ALTER TABLE `products_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT voor een tabel `products_images`
--
ALTER TABLE `products_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT voor een tabel `products_options`
--
ALTER TABLE `products_options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT voor een tabel `shipping`
--
ALTER TABLE `shipping`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT voor een tabel `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT voor een tabel `transactions_items`
--
ALTER TABLE `transactions_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=217;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
