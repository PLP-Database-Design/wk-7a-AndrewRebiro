-- Question 1: Achieving 1NF (First Normal Form)
-- Separate multiple products into individual rows for each order
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Insert data into ProductDetail_1NF table by separating the Products into individual rows
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');


-- Question 2: Achieving 2NF (Second Normal Form)
-- Step 1: Create Customers table to store customer information
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(255) NOT NULL
);

-- Step 2: Insert unique customer names into the Customers table
INSERT INTO Customers (CustomerName)
SELECT DISTINCT CustomerName FROM OrderDetails;

-- Step 3: Create OrderDetails table with OrderID and Product as the primary key
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    CustomerID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Step 4: Insert data into OrderDetails_2NF table
INSERT INTO OrderDetails_2NF (OrderID, CustomerID, Product, Quantity)
SELECT 
    o.OrderID, 
    c.CustomerID, 
    o.Product, 
    o.Quantity
FROM 
    OrderDetails o
JOIN 
    Customers c ON o.CustomerName = c.CustomerName;
