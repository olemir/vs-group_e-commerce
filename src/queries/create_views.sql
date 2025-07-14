CREATE VIEW IF NOT EXISTS view_all AS
	SELECT 
		orders.*,
		customer.Name AS CustomerName,
		customer.Segment AS Segment,
		product.Name AS ProductName,
		productcategories.Category,
		productcategories.SubCategory,
		shipment.ShipDate,
		shipment.ShipMode,
		address.PostalCode,
		address.City, 
		addresssecondary.Country,
		addresssecondary.Region,
		addresssecondary.State
	FROM orders
	JOIN customer ON orders.CustomerID = customer.ID
	JOIN product ON orders.ProductID = product.ID
	JOIN productcategories ON product.ProductCategoryID = productcategories.ID
	JOIN shipment ON orders.ShipmentID = shipment.ID
	JOIN address ON shipment.AddressID = address.ID
	JOIN addresssecondary ON address.AddressSecondaryID = addresssecondary.ID;