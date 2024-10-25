CREATE DATABASE yourcar_yourway_app;

use yourcar_yourway_app;

CREATE TABLE `users` (
    `id` UUID PRIMARY KEY,
    `email` VARCHAR(255) UNIQUE NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `role` ENUM('USER', 'ADMIN') NOT NULL,
    `status` ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    `created_at` TIMESTAMP DEFAULT(CURRENT_TIMESTAMP),
    `updated_at` TIMESTAMP DEFAULT(CURRENT_TIMESTAMP)
);

CREATE TABLE `user_profiles` (
    `id` UUID PRIMARY KEY,
    `first_name` VARCHAR(255),
    `last_name` VARCHAR(255),
    `date_of_birth` DATE,
    `address` VARCHAR(255),
    `phone_number` VARCHAR(50),
    `created_at` TIMESTAMP DEFAULT(CURRENT_TIMESTAMP),
    `updated_at` TIMESTAMP DEFAULT(CURRENT_TIMESTAMP)
);

CREATE TABLE `bookings` (
    `id` UUID PRIMARY KEY,
    `user_id` UUID,
    `vehicle_id` UUID,
    `start_date` TIMESTAMP,
    `end_date` TIMESTAMP,
    `pick_up_location` VARCHAR(255),
    `drop_off_location` VARCHAR(255),
    `status` ENUM(
        'PENDING',
        'CONFIRMED',
        'CANCELLED'
    ) DEFAULT 'PENDING',
    `payment_status` ENUM('PENDING', 'PAID', 'FAILED') DEFAULT 'PENDING',
    `created_at` TIMESTAMP DEFAULT(CURRENT_TIMESTAMP),
    `updated_at` TIMESTAMP DEFAULT(CURRENT_TIMESTAMP)
);

CREATE TABLE `vehicles` (
    `id` UUID PRIMARY KEY,
    `model` VARCHAR(255),
    `make` VARCHAR(255),
    `year` INT,
    `category` ENUM(
        'SUV',
        'SEDAN',
        'TRUCK',
        'MINIVAN',
        'SPORT'
    ),
    `price_per_day` DECIMAL(10, 2),
    `availability_status` ENUM('AVAILABLE', 'UNAVAILABLE') DEFAULT 'AVAILABLE',
    `location` VARCHAR(255),
    `created_at` TIMESTAMP DEFAULT(CURRENT_TIMESTAMP),
    `updated_at` TIMESTAMP DEFAULT(CURRENT_TIMESTAMP)
);

CREATE TABLE `messages` (
    `id` UUID PRIMARY KEY,
    `user_id` UUID,
    `agent_id` UUID,
    `status` ENUM('ACTIVE', 'CLOSED') DEFAULT 'ACTIVE',
    `content` TEXT,
    `sent_at` TIMESTAMP DEFAULT(CURRENT_TIMESTAMP)
);

CREATE TABLE `payment_methods` (
    `id` UUID PRIMARY KEY,
    `user_id` UUID,
    `card_number` VARCHAR(20),
    `expiration_date` DATE,
    `cardholder_name` VARCHAR(255),
    `billing_address` VARCHAR(255),
    `created_at` TIMESTAMP DEFAULT(CURRENT_TIMESTAMP)
);

CREATE TABLE `transactions` (
    `id` UUID PRIMARY KEY,
    `user_id` UUID,
    `booking_id` UUID,
    `amount` DECIMAL(10, 2),
    `payment_method_id` UUID,
    `transaction_status` ENUM(
        'PENDING',
        'COMPLETED',
        'FAILED'
    ) DEFAULT 'PENDING',
    `created_at` TIMESTAMP DEFAULT(CURRENT_TIMESTAMP)
);

ALTER TABLE `user_profiles`
ADD FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

ALTER TABLE `bookings`
ADD FOREIGN KEY (`user_id`) REFERENCES `user_profiles` (`id`) ON DELETE CASCADE;

ALTER TABLE `bookings`
ADD FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`) ON DELETE CASCADE;

ALTER TABLE `messages`
ADD FOREIGN KEY (`user_id`) REFERENCES `user_profiles` (`id`) ON DELETE CASCADE;

ALTER TABLE `transactions`
ADD FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE;

ALTER TABLE `transactions`
ADD FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`) ON DELETE CASCADE;