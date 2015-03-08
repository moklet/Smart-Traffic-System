-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 08, 2015 at 03:32 AM
-- Server version: 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sts`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_parkir`
--

CREATE TABLE IF NOT EXISTS `detail_parkir` (
`id_detail_parkir` int(11) NOT NULL,
  `id_parkir` int(11) DEFAULT NULL,
  `nama_lantai` varchar(255) DEFAULT NULL,
  `nama_koordinat_lantai` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `detail_parkir`
--

INSERT INTO `detail_parkir` (`id_detail_parkir`, `id_parkir`, `nama_lantai`, `nama_koordinat_lantai`, `status`) VALUES
(1, 1, 'A', 'A1', 0),
(2, 1, 'A', 'A2', 0),
(3, 1, 'A', 'A3', 0),
(4, 1, 'B', 'B1', 0),
(5, 1, 'B', 'B2', 0),
(6, 1, 'B', 'B3', 0),
(7, 1, 'C', 'C1', 0),
(8, 1, 'C', 'C2', 0),
(9, 1, 'C', 'C3', 0);

-- --------------------------------------------------------

--
-- Table structure for table `jenis_kendaraan`
--

CREATE TABLE IF NOT EXISTS `jenis_kendaraan` (
`id_jenis_kendaraan` tinyint(4) NOT NULL,
  `nama_jenis` varchar(255) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `jenis_kendaraan`
--

INSERT INTO `jenis_kendaraan` (`id_jenis_kendaraan`, `nama_jenis`) VALUES
(1, 'Mobil'),
(2, 'Sepeda Motor')
(3, 'Truk'),
(4, 'Bus');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE IF NOT EXISTS `login` (
`login_id` int(11) NOT NULL,
  `username` varchar(35) NOT NULL,
  `password` text NOT NULL,
  `email` varchar(35) NOT NULL,
  `active` int(11) DEFAULT '0'
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`login_id`, `username`, `password`, `email`, `active`) VALUES
(2, 'superadmin', '17c4520f6cfd1ab53d8745e84681eb49', 'superadmin@sts.com', 0);

-- --------------------------------------------------------

--
-- Table structure for table `merek`
--

CREATE TABLE IF NOT EXISTS `merek` (
`id_merek` tinyint(4) NOT NULL,
  `nama_merek` varchar(255) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `merek`
--

INSERT INTO `merek` (`id_merek`, `nama_merek`) VALUES
(1, 'Toyota'),
(2, 'Daihatsu'),
(3, 'Datsun'),
(4, 'Honda'),
(5, 'Chevrolete'),
(6, 'Subaru'),
(7, 'Hino');

-- --------------------------------------------------------

--
-- Table structure for table `parkir`
--

CREATE TABLE IF NOT EXISTS `parkir` (
`id_parkir` int(11) NOT NULL,
  `nama_parkir` varchar(255) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `parkir`
--

INSERT INTO `parkir` (`id_parkir`, `nama_parkir`) VALUES
(1, 'Plasa Ambasador'),
(2, 'ITC Mangga Dua'),
(3, 'Plasa Indonesia');

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE IF NOT EXISTS `pengguna` (
`id_pengguna` int(11) NOT NULL,
  `nama_pengguna` varchar(255) NOT NULL,
  `kata_sandi` varchar(255) NOT NULL,
  `idcardno` varchar(20) NOT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `nama_lengkap` varchar(255) DEFAULT NULL,
  `jenis_kelamin` enum('P','L') DEFAULT NULL,
  `id_jenis_kendaraan` tinyint(4) DEFAULT NULL,
  `id_merek` tinyint(4) DEFAULT NULL,
  `id_tipe_merek` tinyint(4) DEFAULT NULL,
  `warna_kendaraan` varchar(255) DEFAULT NULL,
  `no_plat` varchar(15) DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '0',
  `log_parkir_status` varchar(255) DEFAULT NULL,
  `waktu_parkir` datetime DEFAULT NULL,
  `saldo_delima` int(11) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `pengguna`
--

INSERT INTO `pengguna` (`id_pengguna`, `nama_pengguna`, `kata_sandi`, `idcardno`, `tgl_lahir`, `nama_lengkap`, `jenis_kelamin`, `id_jenis_kendaraan`, `id_merek`, `id_tipe_merek`, `warna_kendaraan`, `no_plat`, `active`, `log_parkir_status`, `waktu_parkir`, `saldo_delima`) VALUES
(5, 'edof0703', '4556', '12345678', '1997-03-07', 'edo feriyus', 'L', 1, 1, 4, 'Black', 'B1234BAS', 0, '0', '0000-00-00 00:00:00', 2975000),
(6, 'dana0803', '2478', '123456', '1997-03-08', 'danang kukuh', 'L', 1, 2, 5, 'hitam', 'B4567CA', 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `posisi`
--

CREATE TABLE IF NOT EXISTS `posisi` (
`id_posisi` int(11) NOT NULL,
  `id_pengguna` int(11) DEFAULT NULL,
  `posisi_terkini_lat` varchar(255) DEFAULT NULL,
  `posisi_terkini_long` varchar(255) DEFAULT NULL,
  `kecepatan_terkini` varchar(255) DEFAULT NULL,
  `waktu_posisi_terkini` datetime DEFAULT NULL,
  `posisi_rumah_lat` varchar(255) DEFAULT NULL,
  `posisi_rumah_long` varchar(255) DEFAULT NULL,
  `posisi_kantor_lat` varchar(255) DEFAULT NULL,
  `posisi_kantor_long` varchar(255) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 

--
-- Dumping data for table `posisi`
--

INSERT INTO `posisi` (`id_posisi`, `id_pengguna`, `posisi_terkini_lat`, `posisi_terkini_long`, `kecepatan_terkini`, `waktu_posisi_terkini`, `posisi_rumah_lat`, `posisi_rumah_long`, `posisi_kantor_lat`, `posisi_kantor_long`) VALUES
(2, 5, '-6.207956359215165', '106.8282339319658', '0.0', '2015-03-08 09:23:42', '-6.236559', '106.827414', '-6.206887', '106.829324'),
(3, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tipe_merek`
--

CREATE TABLE IF NOT EXISTS `tipe_merek` (
`id_tipe_merek` tinyint(4) NOT NULL,
  `id_merek` tinyint(4) DEFAULT NULL,
  `nama_tipe_merek` varchar(255) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `tipe_merek`
--

INSERT INTO `tipe_merek` (`id_tipe_merek`, `id_merek`, `nama_tipe_merek`) VALUES
(1, 1, 'Avanza'),
(2, 1, 'Agya'),
(3, 1, 'Rush'),
(4, 1, 'Fortuner'),
(5, 2, 'Xenia'),
(6, 2, 'Ayla'),
(7, 2, 'Terios'),
(8, 3, 'Go'),
(9, 3, 'Go+'),
(10, 5, 'Spin'),
(11, 6, 'BRZ'),
(12, 4, 'Jazz'),
(13, 4, 'Mobilio');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_parkir`
--
ALTER TABLE `detail_parkir`
 ADD PRIMARY KEY (`id_detail_parkir`), ADD KEY `id_parkir` (`id_parkir`);

--
-- Indexes for table `jenis_kendaraan`
--
ALTER TABLE `jenis_kendaraan`
 ADD PRIMARY KEY (`id_jenis_kendaraan`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
 ADD PRIMARY KEY (`login_id`);

--
-- Indexes for table `merek`
--
ALTER TABLE `merek`
 ADD PRIMARY KEY (`id_merek`);

--
-- Indexes for table `parkir`
--
ALTER TABLE `parkir`
 ADD PRIMARY KEY (`id_parkir`);

--
-- Indexes for table `pengguna`
--
ALTER TABLE `pengguna`
 ADD PRIMARY KEY (`id_pengguna`);

--
-- Indexes for table `posisi`
--
ALTER TABLE `posisi`
 ADD PRIMARY KEY (`id_posisi`);

--
-- Indexes for table `tipe_merek`
--
ALTER TABLE `tipe_merek`
 ADD PRIMARY KEY (`id_tipe_merek`), ADD KEY `id_merek` (`id_merek`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_parkir`
--
ALTER TABLE `detail_parkir`
MODIFY `id_detail_parkir` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `jenis_kendaraan`
--
ALTER TABLE `jenis_kendaraan`
MODIFY `id_jenis_kendaraan` tinyint(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
MODIFY `login_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `merek`
--
ALTER TABLE `merek`
MODIFY `id_merek` tinyint(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `parkir`
--
ALTER TABLE `parkir`
MODIFY `id_parkir` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
MODIFY `id_pengguna` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `posisi`
--
ALTER TABLE `posisi`
MODIFY `id_posisi` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tipe_merek`
--
ALTER TABLE `tipe_merek`
MODIFY `id_tipe_merek` tinyint(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_parkir`
--
ALTER TABLE `detail_parkir`
ADD CONSTRAINT `detail_parkir_ibfk_1` FOREIGN KEY (`id_parkir`) REFERENCES `parkir` (`id_parkir`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
