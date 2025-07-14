CREATE TABLE customer (
	ID TEXT PRIMARY KEY,
	Name TEXT NOT NULL,
	Segment TEXT
);

-- constraints needed? 
CREATE TABLE product (
	ID TEXT PRIMARY KEY,
	Name TEXT NOT NULL,
	ProductCategoryID INTEGER,
	PriceBuy NUMERIC,
	PriceSell NUMERIC,
	Profit NUMERIC,
	FOREIGN	KEY (ProductCategoryID) REFERENCES productcategories(ID)
);

CREATE TABLE productcategories (
	ID TEXT PRIMARY KEY,
	Category TEXT,
	SubCategory TEXT
);

CREATE	TABLE addresssecondary (
	ID INTEGER PRIMARY KEY,
	Country TEXT,
	Region TEXT,
	State TEXT
);

CREATE	TABLE address (
	ID INTEGER PRIMARY KEY,
	City TEXT,
	PostalCode INTEGER,
	AddressSecondaryID INTEGER,
	FOREIGN KEY (AddressSecondaryID) REFERENCES addresssecondary(ID)
);

CREATE TABLE shipment (
	ID INTEGER PRIMARY KEY,
	AddressID INTEGER,
	ShipMode TEXT,
	ShipDate DATE,
	FOREIGN KEY (AddressID) REFERENCES address(ID)
);

CREATE TABLE orders (
	OrderDate DATE NOT NULL,
	ProductID INTEGER NOT NULL,
	CustomerID INTEGER NOT NULL,
	ShipmentID INTEGER NOT NULL,
	OrderReference TEXT NOT NULL,
	Quantity INTEGER NOT NULL,
	Discount NUMERIC,
	Sales NUMERIC NOT NULL,
	Profit NUMERIC,
	FOREIGN KEY (ProductID) REFERENCES product(ID),
	FOREIGN KEY (CustomerID) REFERENCES customer(ID),
	FOREIGN KEY (ShipmentID) REFERENCES shipment(ID),
	PRIMARY KEY (ProductID, CustomerID, ShipmentID, OrderReference, OrderDate)
);