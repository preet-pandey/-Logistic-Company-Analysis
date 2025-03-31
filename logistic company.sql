create database if not exists logisticscompany;
USE LogisticsCompany;

-- Customers Table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT
);

-- Delivery Personnel Table
CREATE TABLE Delivery_Personnel (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    vehicle VARCHAR(50)
);

-- Locations Table
CREATE TABLE Locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100)
);

-- Shipments Table
CREATE TABLE Shipments (
    shipment_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    delivery_id INT,
    source_location INT,
    destination_location INT,
    status ENUM('Pending', 'In Transit', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    shipment_date DATE,
    delivery_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (delivery_id) REFERENCES Delivery_Personnel(delivery_id),
    FOREIGN KEY (source_location) REFERENCES locations(location_id),
    FOREIGN KEY (destination_location) REFERENCES locations(location_id)
);

drop table shipments;

-- Insert Sample Data into Customers
INSERT INTO Customers (name, email, phone, address) VALUES
('John Doe', 'john@example.com', '1234567890', '123 Street, NY'),
('Alice Brown', 'alice@example.com', '9876543210', '456 Road, LA'),
('Bob Smith', 'bob@example.com', '5556667777', '789 Avenue, TX');

-- Insert Sample Data into Delivery Personnel
INSERT INTO Delivery_Personnel (name, phone, vehicle) VALUES
('Michael Johnson', '1112223333', 'Truck-001'),
('Sarah Lee', '4445556666', 'Van-007'),
('David Wilson', '7778889999', 'Bike-002');

-- Insert Sample Data into Locations
INSERT INTO Locations (city, state, country) VALUES
('New York', 'NY', 'USA'),
('Los Angeles', 'CA', 'USA'),
('Chicago', 'IL', 'USA'),
('Houston', 'TX', 'USA');

-- Insert Sample Data into Shipments
INSERT INTO Shipments (customer_id, delivery_id, source_location, destination_location, status, shipment_date, delivery_date) VALUES
(1, 1, 1, 2, 'In Transit', '2025-02-01', NULL),
(2, 2, 2, 3, 'Delivered', '2025-01-25', '2025-01-30'),
(3, 3, 3, 4, 'Pending', '2025-02-02', NULL);

# all shipment details with customer and delivery person info:
SELECT Shipments.shipment_id, 
Customers.name AS customer_name, 
Delivery_Personnel.name AS delivery_person, 
Locations.city AS source_city, 
Locations.city AS destination_city, 
Shipments.status
FROM Shipments
INNER JOIN Customers ON Shipments.customer_id = Customers.customer_id
INNER JOIN Delivery_Personnel ON Shipments.delivery_id = Delivery_Personnel.delivery_id
INNER JOIN Locations ON Shipments.source_location = Locations.location_id
INNER JOIN Locations ON Shipments.destination_location = Locations.location_id;


-- Same Code Can be Written with Alias

SELECT s.shipment_id, 
c.name AS customer_name, 
dp.name AS delivery_person, 
l1.city AS source_city, 
l2.city AS destination_city, 
s.status
FROM Shipments s
INNER JOIN Customers c ON s.customer_id = c.customer_id
INNER JOIN Delivery_Personnel dp ON s.delivery_id = dp.delivery_id
INNER JOIN Locations l1 ON s.source_location = l1.location_id
INNER JOIN Locations l2 ON s.destination_location = l2.location_id;

# all shipments, even if no delivery person is assigned
SELECT s.shipment_id, 
c.name AS customer_name, 
dp.name AS delivery_person, 
s.status
FROM Shipments s
LEFT JOIN Customers c ON s.customer_id = c.customer_id
LEFT JOIN Delivery_Personnel dp ON s.delivery_id = dp.delivery_id;

select * from customers;
select * from delivery_personnel;
select * from locations;
select * from shipments;