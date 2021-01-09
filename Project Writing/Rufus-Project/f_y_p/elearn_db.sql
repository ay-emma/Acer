-- phpMyAdmin SQL Dump
-- version 3.5.8.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 22, 2014 at 12:14 AM
-- Server version: 5.6.12-log
-- PHP Version: 5.4.14

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `elearn_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `blg_comment_tbl`
--

CREATE TABLE IF NOT EXISTS `blg_comment_tbl` (
  `id_com` int(11) NOT NULL AUTO_INCREMENT,
  `idart_com` int(11) NOT NULL DEFAULT '0',
  `idlsn_com` int(11) DEFAULT '0',
  `text_com` text NOT NULL,
  `idusr_com` int(11) NOT NULL DEFAULT '0',
  `date_com` datetime DEFAULT NULL,
  PRIMARY KEY (`id_com`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `blg_comment_tbl`
--

INSERT INTO `blg_comment_tbl` (`id_com`, `idart_com`, `idlsn_com`, `text_com`, `idusr_com`, `date_com`) VALUES
(1, 1, 0, 'What is a server behavior? Is it a code snippet? Do I have to create server behaviors manually, or can I generate them using the Dreamweaver GUI?', 2, '2004-10-20 12:50:08'),
(2, 1, 0, 'I don''t like to hand-code in Dreamweaver, because all the panels take up space and I can''t see all the code. The debugger is quite powerful, though.\r\nI usually use a professional PHP editor for large-scale projects.', 1, '2004-10-20 12:51:05'),
(4, 2, 0, 'I use PostgreSQL. How is the connecting operation different from MySQL?\r\n\r\nDo I need any special rights to manage my databases on a PostgreSQL server?', 2, '2004-10-20 12:52:23'),
(6, 4, 0, 'What is the most expensive stamp in the world? What is the country that issued it?', 2, '2004-10-20 12:57:36'),
(16, 2, 0, 'You can also define a PHP object that performs the connection and runs SQL queries in a safe manner. Or use PHAKT.', 1, '2006-09-08 02:45:50'),
(17, 1, 0, 'This is my own comment.....', 80958, '2014-05-13 07:03:34'),
(18, 0, 2, 'The lesson seems too long', 80958, '2014-05-17 09:02:50'),
(21, 0, 2, 'from lecturer', 1, '2014-05-21 10:11:48');

-- --------------------------------------------------------

--
-- Table structure for table `blg_topic_tbl`
--

CREATE TABLE IF NOT EXISTS `blg_topic_tbl` (
  `id_top` int(11) NOT NULL AUTO_INCREMENT,
  `id_usr_top` int(11) NOT NULL,
  `title_top` varchar(100) NOT NULL DEFAULT '',
  `desc_top` text NOT NULL,
  `date_top` varchar(50) NOT NULL,
  PRIMARY KEY (`id_top`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `blg_topic_tbl`
--

INSERT INTO `blg_topic_tbl` (`id_top`, `id_usr_top`, `title_top`, `desc_top`, `date_top`) VALUES
(1, 0, 'Programming Techniques', 'Which one is better between Pascal and C++?', '2014-04-11'),
(2, 0, 'Logic', 'Differentiate between NAND and NOR gate', '2014-03-02'),
(3, 0, 'Field Trip', 'Where would you prefer for this semester''s field trip?', '2014-05-03');

-- --------------------------------------------------------

--
-- Table structure for table `course_tbl`
--

CREATE TABLE IF NOT EXISTS `course_tbl` (
  `id_crs` int(11) NOT NULL AUTO_INCREMENT,
  `title_crs` varchar(255) NOT NULL,
  `code_crs` varchar(255) NOT NULL,
  `unit_crs` int(11) NOT NULL,
  `lect_inc_id` varchar(255) NOT NULL,
  `desc_crs` varchar(255) NOT NULL,
  `app_level_crs` varchar(20) NOT NULL,
  PRIMARY KEY (`id_crs`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `course_tbl`
--

INSERT INTO `course_tbl` (`id_crs`, `title_crs`, `code_crs`, `unit_crs`, `lect_inc_id`, `desc_crs`, `app_level_crs`) VALUES
(1, 'Engineering Mathematics', 'CSE 331', 1, '1', 'This is an important course as far as the LAUTECH is concerned', '300'),
(3, 'Database Management System', 'CSE 305', 3, '2', 'This course entails the rudiments of physical and industrial chemistry', '300'),
(4, 'Computer Logic I', 'CSE 303', 3, '3', 'It''s in evitable', '300'),
(5, 'General Studies 1', 'GNS 101', 2, '4', 'University english language', '100');

-- --------------------------------------------------------

--
-- Table structure for table `lecturer_tbl`
--

CREATE TABLE IF NOT EXISTS `lecturer_tbl` (
  `id_lect` int(11) NOT NULL AUTO_INCREMENT,
  `name_lect` varchar(255) NOT NULL,
  `passwrd_lect` varchar(255) NOT NULL,
  `course_taken_lect` varchar(255) NOT NULL,
  `email_lect` varchar(255) NOT NULL,
  `dept_lect` varchar(50) NOT NULL,
  `faclty_lect` varchar(25) NOT NULL,
  PRIMARY KEY (`id_lect`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `lecturer_tbl`
--

INSERT INTO `lecturer_tbl` (`id_lect`, `name_lect`, `passwrd_lect`, `course_taken_lect`, `email_lect`, `dept_lect`, `faclty_lect`) VALUES
(1, 'Dr. Mrs. Omotosho', 'lecturer', 'CSE 303', 'test_lecturer@ymail.com', 'Computer Science and Engineering', 'FET'),
(2, 'Mr Oyemade', 'doctor', 'kingdom201', 'helloartooyemade@yahoo.com', 'Computer Science and Engineering', 'FET'),
(3, 'Dr. Mrs. Alao', 'lecturer', 'CSE 305', 'test_lecturer@gmail.com', 'Computer Science and Engineering', 'FET');

-- --------------------------------------------------------

--
-- Table structure for table `lesson_tbl`
--

CREATE TABLE IF NOT EXISTS `lesson_tbl` (
  `id_lssn` int(11) NOT NULL AUTO_INCREMENT,
  `title_lssn` varchar(255) NOT NULL,
  `content_lssn` text NOT NULL,
  `course_id_lssn` varchar(255) NOT NULL,
  `lecturer_id_lssn` varchar(255) NOT NULL,
  `date_added_lssn` varchar(255) NOT NULL,
  PRIMARY KEY (`id_lssn`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `lesson_tbl`
--

INSERT INTO `lesson_tbl` (`id_lssn`, `title_lssn`, `content_lssn`, `course_id_lssn`, `lecturer_id_lssn`, `date_added_lssn`) VALUES
(1, 'Algebra 1', 'This is the content of the lesson note. You can read it all here and with this u''ll pass ur exam.\r\nCheck here for recent notes, don''t endanger your life or i''ll just give you zero.', '1', '1', 'Apr, 26th 2012'),
(2, 'Algebra II', 'There is a simple relationship between the factors of\r\na quadratic expression and the roots of the equation\r\nobtained by equating the expression to zero.\r\nFor example, consider the quadratic equation\r\nx2 + 2x = 8 = 0.\r\nTo solve this we may factorize the quadratic expression\r\nx2 + 2x =8 giving (x ? 2)(x + 4). <br/>\r\nHence (x ? 2)(x + 4) = 0.\r\nThen, if the product of two numbers is zero, one or\r\nboth of those numbers must equal zero. Therefore,\r\neither (x ? 2) = 0, from which, x = 2\r\nor (x + 4) = 0, from which, x = ?4\r\nIt is clear then that a factor of (x ? 2) indicates a\r\nroot of +2, while a factor of (x + 4) indicates a root\r\nof ?4. <br/>\r\nIn general, we can therefore say that:\r\na factor of (x ? a) corresponds to a\r\nroot of x /= a <br/>In practice, we always deduce the roots of a simple\r\nquadratic equation from the factors of the quadratic\r\nexpression, as in the above example. However, we\r\ncould reverse this process. If, by trial and error, we\r\ncould determine that x = 2 is a root of the equation\r\nx2+2x?8 = 0 we could deduce at once that (x?2)\r\nis a factor of the expression x2+2x=8.We wouldn''t\r\nnormally solve quadratic equations this way, but\r\nsuppose we have to factorize a cubic expression (i.e.\r\none in which the highest power of the variable is\r\n3). A cubic equation might have three simple linear\r\nfactors and the difficulty of discovering all these factors\r\nby trial and error would be considerable. It is to\r\ndeal with this kind of case that we use the factor\r\ntheorem. ', '1', '1', '2014 03 11 14:42:42');

-- --------------------------------------------------------

--
-- Table structure for table `resource_tbl`
--

CREATE TABLE IF NOT EXISTS `resource_tbl` (
  `id_rc` int(11) NOT NULL AUTO_INCREMENT,
  `idcrs_rc` int(11) NOT NULL,
  `idlect_rc` int(11) NOT NULL,
  `name_rc` varchar(255) NOT NULL,
  `mimetype_rc` varchar(50) NOT NULL,
  `size_rc` varchar(10) NOT NULL,
  `date_rc` varchar(50) NOT NULL,
  PRIMARY KEY (`id_rc`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `resource_tbl`
--

INSERT INTO `resource_tbl` (`id_rc`, `idcrs_rc`, `idlect_rc`, `name_rc`, `mimetype_rc`, `size_rc`, `date_rc`) VALUES
(2, 1, 1, 'Higher Engineering Mathematics 5ed.pdf', 'application/pdf', '16,048', '2013-12-11 06:23:07'),
(3, 1, 1, 'example055.pdf', 'application/pdf', '92.59', '2014-05-22 00:03:35');

-- --------------------------------------------------------

--
-- Table structure for table `student_tbl`
--

CREATE TABLE IF NOT EXISTS `student_tbl` (
  `id_std` int(11) NOT NULL AUTO_INCREMENT,
  `name_std` varchar(255) NOT NULL,
  `matno_std` varchar(255) NOT NULL,
  `passwrd_std` varchar(255) NOT NULL,
  `dept_std` varchar(255) NOT NULL,
  `faclty_std` varchar(255) NOT NULL,
  `level_std` varchar(255) NOT NULL,
  `email_std` varchar(255) NOT NULL,
  PRIMARY KEY (`id_std`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `student_tbl`
--

INSERT INTO `student_tbl` (`id_std`, `name_std`, `matno_std`, `passwrd_std`, `dept_std`, `faclty_std`, `level_std`, `email_std`) VALUES
(1, 'Adeniyi Jones Akanni', '080958', 'christ', 'Computer Science and Engineering', 'FET', '300', 'admin@admin.com'),
(2, 'Oluokun Samuel Tolulope', '080930', 'sam623', 'cse', 'fet', '500', 'samol92@yahoo.com'),
(3, 'Segun', '131313', '131313', 'Medicine', 'College', '100', 'segun@yahoo.com'),
(4, 'Damilola', '089123', 'dammie', 'CSE', 'FET', '300', 'dammie@lautech.com');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
