-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 16, 2026 at 10:35 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.3.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `event_booking_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `booking_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `booking_status` enum('Pending','Confirmed','Cancelled') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `event_id`, `quantity`, `total_price`, `booking_date`, `booking_status`) VALUES
(1, 1, 1, 1, '50.00', '2026-10-11 05:29:18', 'Cancelled'),
(2, 1, 1, 1, '50.00', '2026-10-11 05:50:26', 'Cancelled'),
(3, 1, 2, 2, '40.00', '2026-10-15 23:17:54', 'Confirmed'),
(4, 1, 3, 3, '105.00', '2026-10-15 23:17:54', 'Confirmed'),
(5, 5, 4, 2, '160.00', '2026-10-15 23:17:54', 'Confirmed'),
(6, 1, 3, 2, '70.00', '2026-10-15 23:46:46', 'Confirmed'),
(7, 1, 3, 1, '35.00', '2026-10-15 23:47:04', 'Confirmed'),
(8, 1, 3, 1, '35.00', '2026-10-15 23:56:23', 'Confirmed'),
(9, 5, 3, 2, '70.00', '2026-10-16 00:09:22', 'Confirmed'),
(10, 1, 3, 1, '35.00', '2026-10-16 07:01:16', 'Confirmed'),
(11, 1, 3, 2, '70.00', '2026-10-16 07:03:01', 'Cancelled');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `venue_id` int(11) NOT NULL,
  `organiser_id` int(11) NOT NULL,
  `event_date` datetime NOT NULL,
  `ticket_price` decimal(10,2) NOT NULL,
  `total_tickets` int(11) NOT NULL,
  `available_tickets` int(11) NOT NULL,
  `status` enum('draft','published','cancelled','completed') DEFAULT 'draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`event_id`, `title`, `description`, `venue_id`, `organiser_id`, `event_date`, `ticket_price`, `total_tickets`, `available_tickets`, `status`, `created_at`, `updated_at`) VALUES
(1, 'CYBERSECURITY', '', 1, 2, '2026-10-11 13:11:00', '50.00', 100, 100, 'completed', '2026-10-11 05:11:41', '2026-10-16 00:07:47'),
(2, 'CYBERDSA', '', 2, 2, '2026-11-20 13:00:00', '20.00', 100, 98, 'published', '2026-10-11 05:49:42', '2026-10-15 23:17:54'),
(3, 'Web Development Bootcamp', 'Two-day hands-on workshop', 3, 2, '2026-11-14 09:00:00', '35.00', 200, 190, 'published', '2026-10-15 23:17:54', '2026-10-16 07:07:36'),
(4, 'Cloud Computing Summit', 'Talks on cloud and DevOps', 4, 4, '2026-11-28 10:00:00', '80.00', 300, 298, 'published', '2026-10-15 23:17:54', '2026-10-15 23:17:54'),
(5, 'Data Science Meetup', 'Evening networking and demos', 1, 4, '2026-12-05 19:00:00', '15.00', 150, 150, 'published', '2026-10-15 23:17:54', '2026-10-15 23:17:54'),
(7, 'SunCTF 2026', '', 8, 2, '2026-11-11 09:10:00', '50.00', 300, 300, 'completed', '2026-10-16 07:16:16', '2026-10-16 07:16:16');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Administrator','Organiser','Staff','Customer') DEFAULT 'Customer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `role`) VALUES
(1, 'Fikri', 'fikrifix3210@gmail.com', '$2y$10$pJy4a2UTCpexf17N08SQUe0xgVJzfWzUqgemEVUvS0sG1iPPM.ZSu', 'Customer'),
(2, 'Seif', 'seifalfayyad@gmail.com', '$2y$10$d4AiKkVdtZidO3vdYikAWuAXBttNm9zHFNoDOxajjhEj6lC7h8AxC', 'Organiser'),
(3, 'Amirul', 'kl2512021779@student.uptm.edu.my', '$2y$10$kRtA6SWETHDC2RO2En5Ra.CpKkAmvgnow4GROwK3suZvzn6hZDTNy', 'Administrator'),
(4, 'mike', 'mike@gmail.com', '$2y$10$nfO9aoyPwMjJGdbSzeGVaeFt8WpFrfz/4K4WLXZQyp3X59zQ0Vg9.', 'Organiser'),
(5, 'Aisyah', 'aisyah@gmail.com', '$2y$10$3Rng8vj.x7CuovNlWUz/1u5QgLG8Gs0z.S9gUom5.eq6mjppSgG16', 'Customer');

-- --------------------------------------------------------

--
-- Table structure for table `venues`
--

CREATE TABLE `venues` (
  `venue_id` int(11) NOT NULL,
  `venue_name` varchar(100) NOT NULL,
  `location` varchar(255) NOT NULL,
  `capacity` int(11) NOT NULL,
  `status` enum('Available','In Use','Unavailable') NOT NULL DEFAULT 'Available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `venues`
--

INSERT INTO `venues` (`venue_id`, `venue_name`, `location`, `capacity`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Merdeka Hall', 'Kuala Lumpur', 1000, 'In Use', '2026-10-11 04:52:43', '2026-10-15 23:17:54'),
(2, 'Putra Arena', 'Putrajaya', 2500, 'In Use', '2026-10-11 04:52:43', '2026-10-11 06:40:08'),
(3, 'Shah Alam Convention Centre', 'Shah Alam', 1500, 'In Use', '2026-10-11 04:52:43', '2026-10-15 23:17:54'),
(4, 'Penang International Hall', 'George Town', 1800, 'In Use', '2026-10-11 04:52:43', '2026-10-15 23:17:54'),
(5, 'Johor Event Centre', 'Johor Bahru', 1200, 'Unavailable', '2026-10-11 04:52:43', '2026-10-16 07:12:02'),
(8, 'sir jeffrey cheah hall, L4, sunway college', 'Subang Jaya', 1000, 'Available', '2026-10-16 07:13:20', '2026-10-16 07:15:03'),
(12, 'Feisol-Hassan Hall, GMI', 'Bangi', 1000, 'Available', '2026-10-16 08:06:48', '2026-10-16 08:06:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `venue_id` (`venue_id`),
  ADD KEY `organiser_id` (`organiser_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `venues`
--
ALTER TABLE `venues`
  ADD PRIMARY KEY (`venue_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `venue_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`);

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`venue_id`),
  ADD CONSTRAINT `events_ibfk_2` FOREIGN KEY (`organiser_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
