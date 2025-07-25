WITH 

tbl AS (
    SELECT 
        customer.ID AS CustomerID,
        customer.Segment,
        productcategories.Category,
        productcategories.SubCategory,
        orders.Sales,
        orders.Profit,
        orders.Quantity,
        orders.OrderReference,
        orders.OrderDate
    FROM customer
    JOIN orders ON orders.CustomerID = customer.ID
    JOIN product ON product.ID = orders.ProductID
    JOIN productcategories ON product.ProductCategoryID = productcategories.ID
    WHERE OrderDate >= '01.01.2016'
),

tbl_total AS (
    SELECT 
        MAX(OrderDate) AS OrderDateMax 
    FROM tbl
),

tbl_pivot AS (
    SELECT
        CustomerID,
        Segment,
        COUNT(DISTINCT OrderReference) AS NumOrders,
        sum(Sales) AS Sales,
        sum(Sales) / COUNT(DISTINCT OrderReference) AS AOV,
        sum(Profit) AS Profit,
        JULIANDAY((SELECT OrderDateMax FROM tbl_total)) - JULIANDAY(MAX(OrderDate)) AS Recency,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Technology'), 0) AS SalesTechnology,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Office Supplies'), 0) AS SalesOfficeSupplies,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Furniture'), 0) AS SalesFurniture,
        IFNULL(COUNT(OrderDate) FILTER (WHERE Category = 'Technology'), 0) AS NumOrdersTechnology,
        IFNULL(COUNT(OrderDate) FILTER (WHERE Category = 'Office Supplies'), 0) AS NumOrdersOfficeSupplies,
        IFNULL(COUNT(OrderDate) FILTER (WHERE Category = 'Furniture'), 0) AS NumOrdersFurniture,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Furniture' AND SubCategory = 'Chairs'), 0) AS SalesFurnitureChair,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Furniture' AND SubCategory = 'Tables'), 0) AS SalesFurnitureTables,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Furniture' AND SubCategory = 'Furnishings'), 0) AS SalesFurnitureFurnishings,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Furniture' AND SubCategory = 'Bookcases'), 0) AS SalesFurnitureBookcases,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Furniture' AND (SubCategory = 'Chairs' OR SubCategory = 'Tables')), 0) AS SalesFurnitureNotProfitable,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Furniture' AND (SubCategory = 'Furnishings' OR SubCategory = 'Bookcases')), 0) AS SalesFurnitureProfitable,
        IFNULL(sum(Profit) FILTER (WHERE Category = 'Furniture'), 0) AS ProfitFurniture
    FROM tbl
    GROUP BY CustomerID
    HAVING Sales > 0. AND NumOrders > 0
)

SELECT 
    tbl_pivot.*,
    SalesFurniture>0                AS HasBoughtFurniture,
    SalesFurnitureNotProfitable > 0 AS HasBoughtFurnitureNotProfitable,
    SalesFurnitureProfitable > 0    AS HasBoughtFurnitureProfitable,
    SalesTechnology / Sales         AS FracSalesTechnology,
    SalesOfficeSupplies / Sales     AS FracSalesOfficeSupplies,
    SalesFurniture / Sales          AS FracSalesFurniture,
    SalesFurnitureNotProfitable / Sales AS FracSalesFurnitureNotProfitable,
    SalesFurnitureProfitable / Sales    AS FracSalesFurnitureProfitable
FROM tbl_pivot
;