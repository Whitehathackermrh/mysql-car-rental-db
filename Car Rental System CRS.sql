-- Create database CRS if not exists
CREATE DATABASE IF NOT EXISTS CRSNew;

-- Use CRS database
USE CRSNew;

-- Create table customer_details
CREATE TABLE IF NOT EXISTS customer_details (
    dl_number CHAR(8) NOT NULL,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email_id VARCHAR(30) NOT NULL,
    street VARCHAR(30) NOT NULL,
    city VARCHAR(20) NOT NULL,
    state_name VARCHAR(20) NOT NULL,
    zipcode INT NOT NULL,
    membership_type CHAR(1) DEFAULT 'n' NOT NULL,
    membership_id CHAR(5),
    CONSTRAINT customerpk PRIMARY KEY (dl_number)
);

-- Insert data into customer_details table
INSERT INTO customer_details (dl_number, first_name, last_name, phone_number, email_id, street, city, state_name, zipcode, membership_type, membership_id)
VALUES
('DL00001', 'John', 'Doe', '1234567890', 'john@example.com', '123 Main St', 'New York', 'NY', 10001, 'n', 'MEM01'),
('DL00002', 'Alice', 'Smith', '9876543210', 'alice@example.com', '456 Elm St', 'Los Angeles', 'CA', 90001, 'y', 'MEM02'),
('DL00003', 'Michael', 'Johnson', '4567890123', 'michael@example.com', '789 Oak St', 'Chicago', 'IL', 60001, 'n', 'MEM03'),
('DL00004', 'Emily', 'Brown', '7890123456', 'emily@example.com', '101 Pine St', 'Houston', 'TX', 77001, 'y', 'MEM04'),
('DL00005', 'Sophia', 'Martinez', '2345678901', 'sophia@example.com', '202 Cedar St', 'Miami', 'FL', 33101, 'n', 'MEM05');

-- Create table car_category
CREATE TABLE IF NOT EXISTS car_category (
    category_name VARCHAR(25) NOT NULL,
    no_of_luggage INT NOT NULL,
    no_of_person INT NOT NULL,
    cost_per_day INT NOT NULL,
    late_fee_per_hour INT NOT NULL,
    CONSTRAINT carcategorypk PRIMARY KEY (category_name)
);

-- Insert data into car_category table
INSERT INTO car_category (category_name, no_of_luggage, no_of_person, cost_per_day, late_fee_per_hour)
VALUES
('Compact', 2, 4, 50, 5),
('SUV', 4, 7, 80, 7),
('Luxury', 2, 4, 120, 10),
('Van', 6, 10, 100, 8),
('Convertible', 2, 2, 150, 15);

-- Create table location_details
CREATE TABLE IF NOT EXISTS location_details (
    location_id CHAR(4) NOT NULL,
    location_name VARCHAR(50) NOT NULL,
    street VARCHAR(30) NOT NULL,
    city VARCHAR(20) NOT NULL,
    state_name VARCHAR(20) NOT NULL,
    zipcode INT NOT NULL,
    CONSTRAINT locationpk PRIMARY KEY (location_id)
);

-- Insert data into location_details table
INSERT INTO location_details (location_id, location_name, street, city, state_name, zipcode)
VALUES
('LOC1', 'Downtown Garage', '123 Main St', 'New York', 'NY', 10001),
('LOC2', 'Beachside Rentals', '456 Ocean Ave', 'Los Angeles', 'CA', 90001),
('LOC3', 'City Center Parking', '789 Elm St', 'Chicago', 'IL', 60001),
('LOC4', 'Houston Rental Center', '101 Pine St', 'Houston', 'TX', 77001),
('LOC5', 'Miami Beach Lot', '202 Palm St', 'Miami', 'FL', 33101);

-- Create table discount_details
CREATE TABLE IF NOT EXISTS discount_details (
    discount_code CHAR(5) NOT NULL,
    discount_name VARCHAR(25) NOT NULL,
    expiry_date DATE NOT NULL,
    discount_percentage INT NOT NULL,
    CONSTRAINT discountpk PRIMARY KEY (discount_code),
    CONSTRAINT discounts UNIQUE (discount_name)
);

-- Insert data into discount_details table
INSERT INTO discount_details (discount_code, discount_name, expiry_date, discount_percentage)
VALUES
('DIS01', 'Spring', '2024-06-30', 15),
('DIS02', 'Summer', '2024-09-30', 10),
('DIS03', 'Winter', '2024-12-31', 20),
('DIS04', 'Fall', '2024-11-30', 12),
('DIS05', 'Holiday', '2024-12-25', 18);

-- Create table rental_car_insurance
CREATE TABLE IF NOT EXISTS rental_car_insurance (
    insurance_code CHAR(50) NOT NULL,
    insurance_name VARCHAR(50) NOT NULL,
    coverage_type VARCHAR(200) NOT NULL,
    cost_per_day INT NOT NULL,
    CONSTRAINT insurancepk PRIMARY KEY (insurance_code),
    CONSTRAINT insurances UNIQUE (insurance_name)
);

-- Insert data into rental_car_insurance table
INSERT INTO rental_car_insurance (insurance_code, insurance_name, coverage_type, cost_per_day)
VALUES
('INS01', 'Basic Coverage', 'Basic coverage for rental car', 10),
('INS02', 'Full Coverage', 'Full coverage including damage and theft', 20),
('INS03', 'Premium Coverage', 'Premium coverage with additional benefits', 30),
('INS04', 'Supplemental Liability', 'Additional liability coverage', 15),
('INS05', 'Personal Accident Insurance', 'Coverage for personal accidents', 12);

-- Create table car
CREATE TABLE IF NOT EXISTS car (
    registration_number CHAR(7) NOT NULL,
    model_name VARCHAR(25) NOT NULL,
    make VARCHAR(25) NOT NULL,
    model_year INT NOT NULL,
    mileage INTEGER NOT NULL,
    car_category_name VARCHAR(25) NOT NULL,
    loc_id CHAR(4) NOT NULL,
    availability_flag CHAR(1) NOT NULL,
    CONSTRAINT carpk PRIMARY KEY (registration_number),
    CONSTRAINT carfk1 FOREIGN KEY (car_category_name) REFERENCES car_category(category_name),
    CONSTRAINT carfk2 FOREIGN KEY (loc_id) REFERENCES location_details(location_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Insert data into car table
INSERT INTO car (registration_number, model_name, make, model_year, mileage, car_category_name, loc_id, availability_flag)
VALUES
('CAR001', 'Toyota Camry', 'Toyota', 2019, 30000, 'Compact', 'LOC1', 'Y'),
('CAR002', 'Ford Explorer', 'Ford', 2020, 25000, 'SUV', 'LOC2', 'Y'),
('CAR003', 'BMW 5 Series', 'BMW', 2018, 35000, 'Luxury', 'LOC3', 'Y'),
('CAR004', 'Honda Odyssey', 'Honda', 2021, 20000, 'Van', 'LOC4', 'Y'),
('CAR005', 'Chevrolet Corvette', 'Chevrolet', 2022, 15000, 'Convertible', 'LOC5', 'Y');

-- Create table booking_details
CREATE TABLE IF NOT EXISTS booking_details (
    booking_id CHAR(10) NOT NULL,
    from_dt_time TIMESTAMP NOT NULL,
    ret_dt_time TIMESTAMP NOT NULL,
    amount INT NOT NULL,
    booking_status CHAR(1) NOT NULL,
    pickup_loc CHAR(4) NOT NULL,
    drop_loc CHAR(4) NOT NULL,
    reg_num CHAR(20) NOT NULL,
    dl_num CHAR(10) NOT NULL,
    ins_code CHAR(10),
    act_ret_dt_time TIMESTAMP,
    discount_code CHAR(10),
    CONSTRAINT bookingpk PRIMARY KEY (booking_id),
    CONSTRAINT bookingfk1 FOREIGN KEY (pickup_loc) REFERENCES location_details(location_id),
    CONSTRAINT bookingfk2 FOREIGN KEY (drop_loc) REFERENCES location_details(location_id),
    CONSTRAINT bookingfk3 FOREIGN KEY (reg_num) REFERENCES car(registration_number),
    CONSTRAINT bookingfk4 FOREIGN KEY (dl_num) REFERENCES customer_details(dl_number) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT bookingfk5 FOREIGN KEY (ins_code) REFERENCES rental_car_insurance(insurance_code) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT bookingfk6 FOREIGN KEY (discount_code) REFERENCES discount_details(discount_code) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Insert data into booking_details table
INSERT INTO booking_details (booking_id, from_dt_time, ret_dt_time, amount, booking_status, pickup_loc, drop_loc, reg_num, dl_num, ins_code, act_ret_dt_time, discount_code)
VALUES
('BOOK001', '2024-05-01 08:00:00', '2024-05-10 10:00:00', 500, 'A', 'LOC1', 'LOC2', 'CAR001', 'DL00001', 'INS01', NULL, 'DIS01'),
('BOOK002', '2024-05-02 09:00:00', '2024-05-12 12:00:00', 800, 'A', 'LOC2', 'LOC3', 'CAR002', 'DL00002', 'INS02', NULL, 'DIS02'),
('BOOK003', '2024-05-03 10:00:00', '2024-05-15 15:00:00', 1200, 'A', 'LOC3', 'LOC4', 'CAR003', 'DL00003', 'INS03', NULL, 'DIS03'),
('BOOK004', '2024-05-04 11:00:00', '2024-05-20 18:00:00', 1000, 'A', 'LOC4', 'LOC5', 'CAR004', 'DL00004', 'INS04', NULL, 'DIS04'),
('BOOK005', '2024-05-05 12:00:00', '2024-05-25 20:00:00', 1500, 'A', 'LOC5', 'LOC1', 'CAR005', 'DL00005', 'INS05', NULL, 'DIS05');

-- Create table billing_details
CREATE TABLE IF NOT EXISTS billing_details (
    bill_id CHAR(6) NOT NULL,
    bill_date DATE NOT NULL,
    bill_status CHAR(1) NOT NULL,
    discount_amount INT NOT NULL,
    total_amount INT NOT NULL,
    tax_amount INT NOT NULL,
    booking_id CHAR(10) NOT NULL,
    total_late_fee INT NOT NULL,
    CONSTRAINT billingpk PRIMARY KEY (bill_id),
    CONSTRAINT billingfk1 FOREIGN KEY (booking_id) REFERENCES booking_details(booking_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Insert data into billing_details table
INSERT INTO billing_details (bill_id, bill_date, bill_status, discount_amount, total_amount, tax_amount, booking_id, total_late_fee)
VALUES
('B-01', '2024-05-10', 'P', 50, 450, 30, 'BOOK001', 0),
('B-02', '2024-05-12', 'P', 100, 700, 50, 'BOOK002', 0),
('B-03', '2024-05-15', 'P', 150, 1050, 70, 'BOOK003', 0),
('B-04', '2024-05-20', 'P', 120, 880, 60, 'BOOK004', 0),
('B-05', '2024-05-25', 'P', 180, 1320, 90, 'BOOK005', 0);




DELIMITER //
CREATE PROCEDURE GenerateBill(
    IN p_booking_id CHAR(10)
)
BEGIN
    DECLARE total_amount INT;
    
    -- Calculate total amount
    SET total_amount = CalculateTotalAmount(p_booking_id);
    
    -- Insert data into billing_details table
    INSERT INTO billing_details (bill_id, bill_date, bill_status, discount_amount, total_amount, tax_amount, booking_id, total_late_fee)
    VALUES (
        CONCAT('B-', LPAD((SELECT IFNULL(MAX(SUBSTRING(bill_id, 3))+1, 1) FROM billing_details), 2, '0')), 
        CURDATE(), 
        'P', 
        (SELECT discount_percentage FROM discount_details WHERE discount_code = (SELECT discount_code FROM booking_details WHERE booking_id = p_booking_id)), 
        total_amount - (SELECT discount_percentage FROM discount_details WHERE discount_code = (SELECT discount_code FROM booking_details WHERE booking_id = p_booking_id)), 
        total_amount * 0.15, 
        p_booking_id, 
        0
    );
    
    SELECT CONCAT('Bill generated successfully for Booking ID: ', p_booking_id) AS message;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE AddNewCustomer(
    IN p_dl_number CHAR(8),
    IN p_first_name VARCHAR(25),
    IN p_last_name VARCHAR(25),
    IN p_phone_number VARCHAR(15),
    IN p_email_id VARCHAR(30),
    IN p_street VARCHAR(30),
    IN p_city VARCHAR(20),
    IN p_state_name VARCHAR(20),
    IN p_zipcode INT,
    IN p_membership_type CHAR(1),
    IN p_membership_id CHAR(5)
)
BEGIN
    INSERT INTO customer_details (dl_number, first_name, last_name, phone_number, email_id, street, city, state_name, zipcode, membership_type, membership_id)
    VALUES (p_dl_number, p_first_name, p_last_name, p_phone_number, p_email_id, p_street, p_city, p_state_name, p_zipcode, p_membership_type, p_membership_id);
    
    SELECT CONCAT('New customer added with DL Number: ', p_dl_number) AS message;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE AddNewBooking(
    IN p_booking_id CHAR(10),
    IN p_from_dt_time TIMESTAMP,
    IN p_ret_dt_time TIMESTAMP,
    IN p_amount INT,
    IN p_booking_status CHAR(1),
    IN p_pickup_loc CHAR(4),
    IN p_drop_loc CHAR(4),
    IN p_reg_num CHAR(20),
    IN p_dl_num CHAR(10),
    IN p_ins_code CHAR(10),
    IN p_act_ret_dt_time TIMESTAMP,
    IN p_discount_code CHAR(10)
)
BEGIN
    INSERT INTO booking_details (booking_id, from_dt_time, ret_dt_time, amount, booking_status, pickup_loc, drop_loc, reg_num, dl_num, ins_code, act_ret_dt_time, discount_code)
    VALUES (p_booking_id, p_from_dt_time, p_ret_dt_time, p_amount, p_booking_status, p_pickup_loc, p_drop_loc, p_reg_num, p_dl_num, p_ins_code, p_act_ret_dt_time, p_discount_code);
    
    SELECT CONCAT('New booking added with Booking ID: ', p_booking_id) AS message;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE AddNewBillingDetail(
    IN p_bill_id CHAR(6),
    IN p_bill_date DATE,
    IN p_bill_status CHAR(1),
    IN p_discount_amount INT,
    IN p_total_amount INT,
    IN p_tax_amount INT,
    IN p_booking_id CHAR(10),
    IN p_total_late_fee INT
)
BEGIN
    INSERT INTO billing_details (bill_id, bill_date, bill_status, discount_amount, total_amount, tax_amount, booking_id, total_late_fee)
    VALUES (p_bill_id, p_bill_date, p_bill_status, p_discount_amount, p_total_amount, p_tax_amount, p_booking_id, p_total_late_fee);
    
    SELECT CONCAT('New billing detail added with Bill ID: ', p_bill_id) AS message;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetCustomerByDLNumber(
    IN p_dl_number CHAR(8)
)
BEGIN
    SELECT * FROM customer_details WHERE dl_number = p_dl_number;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE GetBookingDetailsByID(
    IN p_booking_id CHAR(10)
)
BEGIN
    SELECT * FROM booking_details WHERE booking_id = p_booking_id;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE GetBillingDetailsByID(
    IN p_bill_id CHAR(6)
)
BEGIN
    SELECT * FROM billing_details WHERE bill_id = p_bill_id;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE GetAvailableCarsAtLocation(
    IN p_location_id CHAR(4)
)
BEGIN
    SELECT c.* 
    FROM car c
    LEFT JOIN booking_details b ON c.registration_number = b.reg_num
    WHERE c.loc_id = p_location_id AND b.booking_id IS NULL;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GetTotalBookingsByCustomer(
    IN p_dl_number CHAR(8)
)
BEGIN
    SELECT COUNT(*) AS total_bookings 
    FROM booking_details 
    WHERE dl_num = p_dl_number;
END //
DELIMITER ;






