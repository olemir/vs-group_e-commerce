WITH 

tbl AS (
    SELECT 
        customer.ID AS CustomerID,
        productcategories.Category,
        productcategories.SubCategory,
        orders.Sales,
        orders.Profit,
        orders.Quantity,
        orders.OrderReference
    FROM customer
    JOIN orders ON orders.CustomerID = customer.ID
    JOIN product ON product.ID = orders.ProductID
    JOIN productcategories ON product.ProductCategoryID = productcategories.ID
),

tbl_pivot AS (
    SELECT
        CustomerID,
        COUNT(DISTINCT OrderReference)                                     AS NumOrders,
        sum(Sales)                                                         AS Sales,
        sum(Profit)                                                        AS Profit,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Technology'), 0)       AS SalesTechnology,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Office Supplies'), 0)  AS SalesOfficeSupplies,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Furniture'), 0)        AS SalesFurniture,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Furniture' AND SubCategory = 'Chairs'), 0)      AS SalesFurnitureChair,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Furniture' AND SubCategory = 'Tables'), 0)      AS SalesFurnitureTables,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Furniture' AND SubCategory = 'Furnishings'), 0) AS SalesFurnitureFurnishings,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Furniture' AND SubCategory = 'Bookcases'), 0)   AS SalesFurnitureBookcases,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Furniture' AND (SubCategory = 'Chairs' OR SubCategory = 'Tables')), 0)   AS SalesFurnitureNotProfitable,
        IFNULL(sum(Sales) FILTER (WHERE Category = 'Furniture' AND (SubCategory = 'Bookcases' OR SubCategory = 'Furnishings')), 0)   AS SalesFurnitureProfitable
    FROM tbl
    GROUP BY CustomerID
    HAVING Sales > 0. AND NumOrders > 0
)

SELECT 
    tbl_pivot.*,
    SalesFurniture>0 AS HasBoughtFurniture
FROM tbl_pivot
;